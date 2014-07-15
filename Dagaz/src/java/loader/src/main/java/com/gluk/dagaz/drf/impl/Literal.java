
package com.gluk.dagaz.drf.impl;

import java.math.BigDecimal;

import com.gluk.dagaz.drf.api.IList;
import com.gluk.dagaz.drf.api.ILiteral;
import com.gluk.dagaz.drf.api.INode;
import com.gluk.dagaz.drf.loader.api.ILexem;

public class Literal implements INode, ILiteral {
	
	private String strValue = null;
	private BigDecimal numValue = null;
	
	public Literal(ILexem l) {
		if (l.isNumber()) {
			numValue = new BigDecimal(l.getValue());
		} else {
			strValue = l.getValue();
		}
	}

	public boolean isAtom() {
		return false;
	}

	public boolean isList() {
		return false;
	}

	public boolean isLiteral() {
		return true;
	}

	public String getName() throws Exception {
		throw new Exception("No Name");
	}

	public IList getList() throws Exception {
		throw new Exception("Is not a List");
	}

	public ILiteral getLiteral() throws Exception {
		return this;
	}

	public boolean isString() {
		return (strValue == null);
	}

	public boolean isNumber() {
		return (numValue == null);
	}

	public String getString() throws Exception {
		if (isNumber()) {
			return numValue.toString();
		} 
		return strValue;
	}

	public BigDecimal getNumber() throws Exception {
		if (isString()) {
			throw new Exception("Is not a Number");
		}
		return numValue;
	}
}
