package com.gluk.dagaz.drf.impl;

import com.gluk.dagaz.drf.api.IList;
import com.gluk.dagaz.drf.api.INode;
import com.gluk.dagaz.drf.api.ILiteral;

public class Atom implements INode {
	
	private String name;
	
	public Atom(String name) {
		this.name = name;
	}

	public boolean isAtom() {
		return true;
	}

	public boolean isList() {
		return false;
	}

	public boolean isLiteral() {
		return false;
	}

	public boolean isString() {
		return false;
	}

	public boolean isNumber() {
		return false;
	}

	public IList getList() throws Exception {
		throw new Exception("Not a List");
	}

	public ILiteral getLiteral() throws Exception {
		throw new Exception("Not a Literal");
	}

	public String getName() throws Exception {
		return name;
	}
}
