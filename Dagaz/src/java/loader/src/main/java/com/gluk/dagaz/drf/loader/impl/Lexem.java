package com.gluk.dagaz.drf.loader.impl;

import com.gluk.dagaz.drf.loader.api.ILexem;

public class Lexem implements ILexem {
	
	private StringBuffer value = new StringBuffer();
	private boolean isString = false;
	private boolean isNumber = true;
	
	public boolean isEmpty() {
		return (value.length() == 0);
	}

	public void addChar(char c) {
		if ((c == '-') && !isEmpty()) {
			isNumber = false;
		}
		if (!Character.isDigit(c)) {
			isNumber = false;
		}
		value.append(c);
	}

	public String getValue() {
		return value.toString();
	}
	
	public boolean isLeftBracket() {
		return getValue().equals("(");
	}

	public boolean isRightBracket() {
		return getValue().equals(")");
	}

	public boolean isLiteral() {
		return (isString || isNumber);
	}

	public boolean isNumber() {
		return isNumber;
	}

	public void setString() {
		isString = true;
	}
}
