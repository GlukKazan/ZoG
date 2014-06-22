package com.gluk.dagaz.drf.api;

public interface INode {
	boolean  isAtom();
	boolean  isList();
	boolean  isLiteral();
	String   getName()   throws Exception;
	IList    getList()   throws Exception;
	ILiteral getLiteral() throws Exception;
}
