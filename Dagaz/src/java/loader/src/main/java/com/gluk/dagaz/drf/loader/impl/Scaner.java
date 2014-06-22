package com.gluk.dagaz.drf.loader.impl;

import com.gluk.dagaz.drf.loader.api.ILexem;
import com.gluk.dagaz.drf.loader.api.IParser;
import com.gluk.dagaz.drf.loader.api.IScaner;

public class Scaner implements IScaner {
	
	private final static char CR_CHAR      = (char)0x0D;
	private final static char LF_CHAR      = (char)0x0A;
	private final static char TAB_CHAR     = (char)0x09;
	private final static char SPACE_CHAR   = ' ';
	private final static char COMMENT_CHAR = ';';
	private final static char LB_CHAR      = '(';
	private final static char RB_CHAR      = ')';
	
	private IParser parser;
	private ILexem  currentLexem = new Lexem();
	private boolean isCommented  = false;
	
	public Scaner(IParser parser) {
		this.parser = parser;
	}
	
	private void closeLexem() throws Exception {
		if (!currentLexem.isEmpty()) {
			parser.parse(currentLexem);
			currentLexem = new Lexem();
		}
	}

	public void scan(char c) throws Exception {
		if (isCommented) {
			switch (c) {
				case CR_CHAR:
				case LF_CHAR:
					isCommented = false;
					break;
			}
			return;
		}
		switch (c) {
			case COMMENT_CHAR:
				isCommented = true;
			case CR_CHAR:
			case LF_CHAR:
			case TAB_CHAR:
			case SPACE_CHAR:
				closeLexem();
				break;
			case LB_CHAR:
			case RB_CHAR:
				closeLexem();
				currentLexem.addChar(c);
				closeLexem();
				break;
			default:
				currentLexem.addChar(c);
				break;
		}
	}
}
