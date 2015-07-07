package com.gluk.axiom.checker.parser;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

import com.gluk.axiom.checker.api.IApplication;
import com.gluk.axiom.checker.api.IDictionary;
import com.gluk.axiom.checker.api.IParser;
import com.gluk.axiom.checker.api.ISerializer;
import com.gluk.axiom.checker.api.IWord;
import com.gluk.axiom.checker.api.Words;

public class Parser implements IParser {
	
	private final static int    INITIAL           = 0;
	private final static int    ERROR             = 1;
	private final static int    CODE              = 2;
	private final static int    LOAD              = 3;
	private final static int    NAME              = 4;
	private final static int    CODE_WAITING      = 5;

	private IApplication app;
	private IParser      loader;
	private ISerializer  output;
	private IDictionary  dict;
	private String       curr = null;

	private int mode = INITIAL;
	private List<String> stack = new ArrayList<String>();
	private List<List<String>> stackList= new ArrayList<List<String>>();
	private Stack<String> commands = new Stack<String>();
	private List<String> args = new ArrayList<String>();
	
	public Parser(IApplication app, IParser loader) {
		this.app    = app;
		this.loader = loader;
		this.output = app.getSerializer();
		this.dict   = app.getDictionary();
	}
	
	public void dumpStack(List<String> l, boolean f) {
		if (mode == CODE) {
			for (String s: l) {
				output.addComment(" ", f);
				output.addComment(s, f);
			}
		}
	}
	
	public void dumpStack() {
		dumpStack(stack, false);
	}
	
	private void pushStack(String c) { // IF, BEGIN
		List<String> l = new ArrayList<String>();
		for (String s: stack) {
			l.add(s);
		}
		stackList.add(l);
		commands.add(c);
	}
	
	private void replaceStack() throws Exception {  // ELSE
		if (stackList.isEmpty() || commands.isEmpty()) {
			throw new Exception("Stack List is empty");
		}
		String c = commands.peek();
		if (!c.equals(Words.IF_WORD)) {
			throw new Exception("Syntax error");
		}
		List<String> l = new ArrayList<String>();
		for (String s: stack) {
			l.add(s);
		}
		List<String> o = stackList.get(stackList.size() - 1);
		stackList.set(stackList.size() - 1, l);
		stack.clear();
		for (String s: o) {
			stack.add(s);
		}
	}
	
	private void checkStack(List<String> l) throws Exception {
		boolean f = true;
		if (l.size() == stack.size()) {
			f = false;
			for (int i = 0; i < l.size(); i++) {
				if (!dict.isEqualTypes(l.get(i), stack.get(i))) {
					f = true;
					break;
				}
			}
		}
		if (f) {
			dumpStack(l, true);
			output.addComment(" #", true);
			dumpStack(stack, true);
			mode = ERROR;
		}
	}
	
	private void checkRecurse() throws Exception { // RECURSE
		if (curr == null) {
			throw new Exception("Internal error");
		}
		IWord w = dict.getWord(curr);
		List<String> l = w.getInput();
		checkStack(l);
		for (int i = 0; i < l.size(); i++) {
			stack.remove(stack.size() - 1);
		}
		l = w.getOutput();
		for (String s: l) {
			stack.add(s);
		}
	}
	
	private void checkStack(String c) throws Exception { // ENDIF, UNTIL
		if (stackList.isEmpty()) {
			throw new Exception("Stack List is empty");
		}
		if (c.equals(Words.ENDIF_WORD)) {
			c = commands.peek();
			if (!c.equals(Words.IF_WORD)) {
				throw new Exception("Syntax error");
			}
		}
		if (c.equals(Words.UNTIL_WORD)) {
			c = commands.peek();
			if (!c.equals(Words.BEGIN_WORD)) {
				throw new Exception("Syntax error");
			}
		}
		commands.pop();
		List<String> l = stackList.get(stackList.size() - 1);
		stackList.remove(stackList.size() - 1);
		checkStack(l);
	}

	private void checkInput(String s) throws Exception {
		List<String> l = dict.getWord(s).getInput();
		boolean f = true;
		if (l.size() <= stack.size()) {
			f = false;
			for (int i = 0, j = stack.size() - l.size(); i < l.size(); i++, j++) {
				if (!dict.isEqualTypes(l.get(i), stack.get(j))) {
					f = true;
					break;
				}
			}
		}
		if (f) {
			dumpStack(stack, true);
			output.addComment(" #", true);
			dumpStack(l, true);
			mode = ERROR;
		}
	}
	
	private void genOutput(String s) throws Exception { // DUP, 2DUP, SWAP, DROP, 2DROP, OVER, ROT
		if (!dict.isDefined(s)) {
			if (mode == CODE) {
				output.addComment(" ?", true);
			}
			return;
		}
		checkInput(s);
		List<String> i = dict.getWord(s).getInput();
		List<String> o = dict.getWord(s).getOutput();
		List<String> l = new ArrayList<String>();
		for (int j = stack.size() - i.size(); j < stack.size(); j++) {
			l.add(stack.get(j));
		}
		for (int j = 0; j < i.size(); j++) {
			stack.remove(stack.size() - 1);
		}
		for (int j = 0; j < o.size(); j++) {
			int ix = -1;
			for (int k = 0; k < i.size(); k++) {
				if (i.get(k).equals(o.get(j))) {
					ix = k;
					break;
				}
			}
			if (ix >= 0) {
				stack.add(l.get(ix));
			} else {
				stack.add(o.get(j));
			}
		}
	}
	
	private boolean genArg(String s) throws Exception { // CONSTANT, VARIABLE, DEFER ...
		if (args.isEmpty()) {
			return false;
		}
		String a = args.get(0);
		args.remove(0);
		if (dict.isDefined(s)) {
			if (mode == CODE) {
				stack.add(s); // ['] for EXECUTE
			}
			return true;
		} else {
			if (mode == CODE) {
				output.addComment(" ?", true);
			}
		}
		IWord w = dict.addWord(s);
		if (a.equals(Words.ARRAY_TYPE)) {
			w.addInput(Words.NUM_TYPE);
			w.addOutput(Words.QUOTE_TYPE);
		} else {
			w.addOutput(a);
		}
		return true;
	}
	
	private boolean isNumOrPosition(String s) {
		if (s.isEmpty()) return false;
		int i = 0;
		if ((s.charAt(0) >= 'a') && (s.charAt(0) <= 'z')) {
			i++;
		}
		boolean r = false;
		for (; i < s.length(); i++) {
			r = true;
			if ((s.charAt(i) > '9') || (s.charAt(i) < '0')) {
				return false;
			}
		}
		return r;
	}
	
	private void checkWord(String s) throws Exception {
		if (genArg(s)) {
			return;
		}
		if (dict.isDefined(s)) {
			args.clear();
			for (String a: dict.getWord(s).getArguments()) {
				args.add(a);
			}
		}
		if (mode == CODE) {
			if (s.equals(Words.RECURSE_WORD)) {
				checkRecurse();
			}
			else if (s.equals(Words.EXECUTE_WORD)) {
				if (stack.isEmpty()) {
					throw new Exception("Stack is empty");
				}
				String f = stack.get(stack.size() - 1);
				stack.remove(stack.size() - 1);
				checkWord(f);
			} else if (isNumOrPosition(s)) {
				stack.add(Words.POS_TYPE); 
			} else {
				genOutput(s);
				if (s.equals(Words.IF_WORD) || s.equals(Words.BEGIN_WORD)) {
					pushStack(s);
				}
				if (s.equals(Words.ELSE_WORD)) {
					replaceStack();
				}
				if (s.equals(Words.ENDIF_WORD) || s.equals(Words.UNTIL_WORD)) {
					checkStack(s);
				}
			}
		}
	}

	public void parse(String s, boolean isComment) throws Exception {
		loader.parse(s, isComment);
		if (isComment) {
			return;
		}
		if (mode == CODE) {
			if (s.equals(Words.END_WORD)) {
				List<String> l = dict.getWord(curr).getOutput();
				checkStack(l);
				if (!stackList.isEmpty()) {
					throw new Exception("Syntax Error");
				}
			}
		}
		if (mode == ERROR) {
			if (s.equals(Words.END_WORD)) {
				mode = INITIAL;
				curr = null;
			}
			return;
		}
		if (mode == LOAD) {
			mode = INITIAL;
			app.Load(s);
			return;
		}
		if (mode == NAME) {
			curr = s;
			mode = CODE_WAITING;
			return;
		}
		if (mode == INITIAL) {
			if (s.equals(Words.LOAD_WORD)) {
				mode = LOAD;
			}
			if (s.equals(Words.DEF_WORD)) {
				mode = NAME;
			}
		}
		if (s.equals(Words.END_WORD)) {
			mode = INITIAL;
			return;
		}
		if (mode == CODE_WAITING) {
			stack.clear();
			stackList.clear();
			IWord w = dict.getWord(curr);
			for (String a: w.getInput()) {
				stack.add(a);
			}
		}
		checkWord(s);
	}
}
