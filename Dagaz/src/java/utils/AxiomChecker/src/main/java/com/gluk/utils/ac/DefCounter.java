package com.gluk.utils.ac;

public class DefCounter extends WordItem implements IParser {
	
	private String name;
	private int phase = 0;

	public DefCounter(String name) {
		super(0, 0);
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public boolean isValid() {
		return (phase == 3);
	}

	public void parse(String word) throws Exception {
		switch (phase) {
			case 0:
				if (word.equals(Words.LB_WORD)) {
					phase++;
				} else {
					phase = 100;
				}
				break;
			case 1:
				if (word.equals(Words.RB_WORD)) {
					phase = 100;
				}
				if (word.equals(Words.SEP_WORD)) {
					phase++;
				} else {
					inArgs++;
				}
				break;
			case 2:
				if (word.equals(Words.RB_WORD)) {
					phase++;
				} else {
					outArgs++;
				}
				break;		
		}
	}
}
