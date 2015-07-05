package com.gluk.axiom.checker.interfaces;

public interface IDictionary {
	void addType(String s) throws Exception;
	String getType(String s) throws Exception;
	void setEqual(String a, String b) throws Exception;
	void setInherits(String a, String b) throws Exception;
	boolean isEqualTypes(String a, String b) throws Exception;
	IWord addWord(String s) throws Exception;
	IWord getWord(String s) throws Exception;
}
