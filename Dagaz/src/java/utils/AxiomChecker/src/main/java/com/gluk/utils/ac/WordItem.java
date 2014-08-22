package com.gluk.utils.ac;

public class WordItem {
	
	protected int inArgs;
	protected int outArgs;
	
	public WordItem(int inArgs, int outArgs) {
		this.inArgs  = inArgs;
		this.outArgs = outArgs;
	}
	
	public int getInArgs() {
		return inArgs;
	}

	public int getOutArgs() {
		return outArgs;
	}
}
