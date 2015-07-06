package com.gluk.axiom.checker.api;

import java.util.List;

public interface IWord {
	void addInput(String s) throws Exception;
	void addOutput(String s) throws Exception;
	void addArgument(String s) throws Exception;
	List<String> getInput();
	List<String> getOutput();
	List<String> getArguments();
}
