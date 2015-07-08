package com.gluk.axiom.checker.api;

public interface IApplication {
	void load(String s) throws Exception;
	ISerializer getSerializer() throws Exception;
	IDictionary getDictionary();
}
