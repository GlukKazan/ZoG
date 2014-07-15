package com.gluk.dagaz.drf.loader.api;

public interface ILexem {
	boolean isEmpty();
	void    addChar(char c);
	String  getValue();
	boolean isLeftBracket();
	boolean isRightBracket();
	boolean isLiteral();
	boolean isNumber();
	void    setString();
}
