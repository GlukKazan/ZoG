package com.gluk.axiom.checker.dictionary;

import java.util.ArrayList;
import java.util.List;

import com.gluk.axiom.checker.api.IWord;

public class Word implements IWord {
	
	private List<String> inp = new ArrayList<String>();
	private List<String> out = new ArrayList<String>();
	private List<String> arg = new ArrayList<String>();

	public void addInput(String s) throws Exception {
		inp.add(s);
	}

	public void addOutput(String s) throws Exception {
		out.add(s);
	}

	public void addArgument(String s) throws Exception {
		arg.add(s);
	}

	public List<String> getInput() {
		return inp;
	}

	public List<String> getOutput() {
		return out;
	}

	public List<String> getArguments() {
		return arg;
	}
}
