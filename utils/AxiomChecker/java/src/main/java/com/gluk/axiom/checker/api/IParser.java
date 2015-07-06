package com.gluk.axiom.checker.api;

public interface IParser {
	void parse(String s, boolean isComment) throws Exception;
	void dumpStack();
}
