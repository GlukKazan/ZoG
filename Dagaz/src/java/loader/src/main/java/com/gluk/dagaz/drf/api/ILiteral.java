package com.gluk.dagaz.drf.api;

import java.math.BigDecimal;

public interface ILiteral extends INode {
	boolean    isString();
	boolean    isNumber();
	String     getString()  throws Exception;
	BigDecimal getNumber()  throws Exception;
}
