package com.gluk.axiom.checker.parser;

import com.gluk.axiom.checker.api.IApplication;
import com.gluk.axiom.checker.api.IParser;
import com.gluk.axiom.checker.api.IScaner;
import com.gluk.axiom.checker.api.ISerializer;
import com.gluk.axiom.checker.api.Words;

public class Scaner implements IScaner {
	
	private final static int    INITIAL           = 0;
	private final static int    DF_WAITING        = 1;
	private final static int    SL_COMMENT        = 2;
	private final static int    ML_COMMENT        = 3;
	private final static int    SP_COMMENT        = 4;

	private IParser     parser;
	private ISerializer output;
	
	private StringBuffer word = new StringBuffer();
	private int mode = INITIAL;
	private boolean prevNewLine = false;
	
	public Scaner(IApplication app, IParser parser) throws Exception {
		this.parser = parser;
		this.output = app.getSerializer();
	}
	
	private boolean isNewLine(char c) {
		switch (c) {
	 	case Words.CR:
	 	case Words.LF:
	 		return true;
 		default:
 			return false;
	}
	}
	
	private boolean isSpaceChar(char c) {
		switch (c) {
		 	case Words.SPACE:
		 	case Words.TAB:
		 		return true;
	 		default:
	 			return isNewLine(c);
		}
	}
	
	private void out(char c) throws Exception {
		if (output != null) {
			output.scan(c);
		}
	}

	public void scan(char c) throws Exception {
		if (mode >= ML_COMMENT) {
			if (c == Words.BANG) {
				mode = SP_COMMENT;
			}
			if (c == Words.CLOSE) {
				mode = INITIAL;
				return;
			}
			if (mode == ML_COMMENT) {
				return;
			}
		}
		if (mode == SL_COMMENT) {
			if (isNewLine(c)) { 
				mode = INITIAL;
			} else {
				return;
			}
		}
		if (isNewLine(c)) {
			if (!prevNewLine) {
				parser.dumpStack();
			}
			prevNewLine = true;
		} else {
			prevNewLine = false;
		}
		if (isSpaceChar(c)) {
			out(c);
			if (word.length() > 0) {
				String w = word.toString();
				if (w.equals(Words.DEF_WORD)) {
					mode = DF_WAITING;
				}
				parser.parse(w, mode == SP_COMMENT);
				word.setLength(0);
			}
			return;
		}
		if (word.length() == 0) {
			if (c == Words.OPEN) {
				mode = (mode == DF_WAITING)? SP_COMMENT : ML_COMMENT;
				if (mode == SP_COMMENT) {
					out(c);
				}
				return;
			}
			if (c == Words.COMMENT) {
				mode = SL_COMMENT;
				return;
			}
		}
		word.append(c);
		out(c);
	}
}
