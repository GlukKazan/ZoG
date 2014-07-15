package com.gluk.dagaz.drf.loader.impl;

import java.util.Stack;

import com.gluk.dagaz.drf.api.IList;
import com.gluk.dagaz.drf.api.INode;
import com.gluk.dagaz.drf.impl.Literal;
import com.gluk.dagaz.drf.impl.NodeList;
import com.gluk.dagaz.drf.loader.api.IEnvironment;
import com.gluk.dagaz.drf.loader.api.ILexem;
import com.gluk.dagaz.drf.loader.api.IListBuilder;
import com.gluk.dagaz.drf.loader.api.ILoader;
import com.gluk.dagaz.drf.loader.api.IParser;
import com.gluk.dagaz.drf.loader.api.IPool;
import com.gluk.dagaz.drf.loader.pool.impl.DefPool;
import com.gluk.dagaz.drf.loader.pool.impl.VarPool;

public class Parser implements IParser {
	
	private final static String LOAD_COMMAND = "load"; 
	
	private IEnvironment env;
	
	private Stack<IListBuilder> context = new Stack<IListBuilder>();
	
	public Parser(IEnvironment env) {
		this.env = env;
	}
	
	private void saveNode(INode n) throws Exception {
		if (!n.isList()) {
			throw new Exception("Syntax Error");
		}
		IList l = n.getList();
		if (l.isEmpty()) {
			throw new Exception("Syntax Error");
		}
		INode car = l.getNode(0);
		if (car == env.getAtoms().getNode(LOAD_COMMAND)) {
			for (int i = 1; i < l.getSize(); i++) {
				INode t = l.getNode(i);
				if (!t.isLiteral()) {
					throw new Exception("Syntax Error");
				}
				ILoader loader = new Loader(env);
				loader.load(t.getLiteral().getString());
			}
			return;
		}
		if (!DefPool.getListName(l).isEmpty()) {
			env.getDefinitions().add(n);
			return;
		}
		if (!VarPool.getListName(l).isEmpty()) {
			env.getVariants().add(n);
			return;
		}
		throw new Exception("Syntax Error");
	}
	
	public void parse(ILexem l) throws Exception {
		if (l.isLeftBracket()) {
			IListBuilder list = new NodeList();
			context.push(list);
		} else if (l.isRightBracket()) {
			if (context.isEmpty()) {
				throw new Exception("Syntax Error");
			}
			INode n = context.peek();
			context.pop();
			if (context.isEmpty()) {
				saveNode(n);
			} else {
				IListBuilder list = context.peek();
				list.add(n);
			}
		} else {
			if (context.isEmpty()) {
				throw new Exception("Syntax Error");
			}
			IListBuilder list = context.peek();
			INode n;
			if (l.isLiteral()) {
				n = new Literal(l);
			} else {
				IPool p = env.getAtoms();
				n = p.getNode(l.getValue());
			}
			list.add(n);
		}
	}
}
