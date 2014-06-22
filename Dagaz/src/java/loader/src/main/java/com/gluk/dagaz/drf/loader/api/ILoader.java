package com.gluk.dagaz.drf.loader.api;

public interface ILoader {
	IPool getAtoms();
	IPool getDefinitions();
	IPool getVariants();
	void  load(String fileName) throws Exception;
}
