package com.gluk.axiom.checker.parser;

import com.gluk.axiom.checker.interfaces.IDictionary;
import com.gluk.axiom.checker.interfaces.IParser;
import com.gluk.axiom.checker.interfaces.IWord;

public class Loader implements IParser {
	
	private final static String BNG_WORD          = "!";
	private final static String DEF_WORD          = ":";
	private final static String EQL_WORD          = "==";
	private final static String INH_WORD          = "<=";
	private final static String OUT_WORD          = "--";
	private final static String ARG_WORD          = "<<";

	private final static int    INITIAL           = 0;
	private final static int    WORD_EXPECTED     = 1;
	private final static int    TYPE_EXPECTED     = 2;
	private final static int    EQUEAL_EXPECTED   = 3;
	private final static int    INHERITS_EXPECTED = 4;
	private final static int    OUT_TYPES         = 5;
	private final static int    ARG_TYPES         = 6;
	
	private IDictionary dict;
	
	private int mode = INITIAL;
	private String type = null;
	private IWord word = null;
	
	public Loader(IDictionary dict) {
		this.dict = dict;
	}

	public void parse(String s, boolean isComment) throws Exception {
		if (isComment) {
			if (word != null) {
				if (s.equals(OUT_WORD)) {
					mode = OUT_TYPES;
				}
				else if (s.equals(ARG_WORD)) {
					mode = ARG_TYPES;
				}
				else if (mode == INITIAL) {
					word.addInput(s);
				}
				else if (mode == OUT_TYPES) {
					word.addOutput(s);
				}
				else if (mode == ARG_TYPES) {
					word.addArgument(s);
				}
			}
			else if (mode == INHERITS_EXPECTED) {
				dict.setInherits(type, s);
				type = null;
				mode = INITIAL;
			}
			else if (mode == EQUEAL_EXPECTED) {
				dict.setEqual(type, s);
				type = null;
				mode = INITIAL;
			}
			else if (mode == TYPE_EXPECTED) {
				type = s;
				mode = INITIAL;
			}
			else if (s.equals(BNG_WORD)) {
				mode = TYPE_EXPECTED;
			}
			else if (s.equals(EQL_WORD)) {
				if (type == null) {
					throw new Exception("Syntax Error");
				}
				mode = EQUEAL_EXPECTED;
			}
			else if (s.equals(INH_WORD)) {
				if (type == null) {
					throw new Exception("Syntax Error");
				}
				mode = INHERITS_EXPECTED;
			}
		} else {
			if (mode == WORD_EXPECTED) {
				word = dict.addWord(s);
				mode = INITIAL;
			}
			else if (s.equals(DEF_WORD)) {
				if (word != null) {
					throw new Exception("Syntax Error");
				}
				mode = WORD_EXPECTED;
			}
			else {
				word = null;
			}
		}
	}
}
