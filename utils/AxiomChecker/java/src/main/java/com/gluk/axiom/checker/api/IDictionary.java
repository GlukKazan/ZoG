package com.gluk.axiom.checker.api;

public interface IDictionary {
	void    setEqual(String a, String b);
	void    setInherits(String a, String b);
	boolean isTypeMatched(String a, String b);
	IWord   addWord(String s) throws Exception;
	IWord   getWord(String s) throws Exception;
	boolean isDefined(String s);
}
