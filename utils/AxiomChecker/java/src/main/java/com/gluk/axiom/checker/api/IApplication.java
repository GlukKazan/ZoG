package com.gluk.axiom.checker.api;

public interface IApplication {
	void Load(String s) throws Exception;
	ISerializer getSerializer();
	IDictionary getDictionary();
}
