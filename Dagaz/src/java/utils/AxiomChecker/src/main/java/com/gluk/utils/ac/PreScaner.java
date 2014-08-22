package com.gluk.utils.ac;

public class PreScaner implements IScaner {

	private IParser parser;
	private StringBuffer sb = new StringBuffer();
	
	private boolean isEscaped = false;

	public PreScaner(PreParser parser) {
		this.parser = parser;
	}
	
	private void parse(String word) throws Exception {
		if (word.equals(Words.ESC_WORD)) {
			isEscaped = true;
			return;
		}
		parser.parse(word);
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
