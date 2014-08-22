package com.gluk.utils.ac;

public class Scaner implements IScaner {
	
	private IParser parser;
	private StringBuffer sb = new StringBuffer();
	
	private int commentCounter = 0;
	private boolean  isEscaped = false;
	
	public Scaner(Parser parser) {
		this.parser = parser;
	}
	
	private boolean isNumber(String word) {
		for (char c: word.toCharArray()) {
			if (!Character.isDigit(c)) {
				return false;
			}
		}
		return true;
	}
	
	private void parse(String word) throws Exception {
		if (word.equals(Words.ESC_WORD)) {
			isEscaped = true;
			return;
		}
		if (word.equals(Words.LB_WORD)) {
			commentCounter++;
			return;
		}
		if (commentCounter > 0) {
			if (word.equals(Words.RB_WORD)) {
				commentCounter--;
			}
			return;
		}
		if (isNumber(word)) {
			parser.parse(Words.TRUE_WORD);
		} else {
			parser.parse(word);
		}
	}

	public void scan(char c) throws Exception {
		if (isEscaped) {
			switch (c) {
				case Chars.CR:
				case Chars.LF:
					isEscaped = false;
			}
		}
		switch (c) {
			case Chars.SPACE:
			case Chars.TAB:
			case Chars.CR:
			case Chars.LF:
				if (sb.length() > 0) {
					parse(sb.toString());
					sb.setLength(0);
				}
				break;
			default:
				sb.append(c);
		}
	}
}
