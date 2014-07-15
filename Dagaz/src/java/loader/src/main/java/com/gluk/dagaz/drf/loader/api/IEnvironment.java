package com.gluk.dagaz.drf.loader.api;

public interface IEnvironment {
	IPool  getAtoms();
	IPool  getDefinitions();
	IPool  getVariants();
	void   setPath(String path);
	String getPath();
}
