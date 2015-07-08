package com.gluk.axiom.checker.application;

import java.io.PrintWriter;

import com.gluk.axiom.checker.api.ISerializer;
import com.gluk.axiom.checker.api.Words;

public class Output implements ISerializer {
	
    private final static String OUT_EXTENSION = ".out";

    private final static int TAB_SIZE = 8;
	private final static int STR_SIZE = 80;
	
	private int len = 0;
	private StringBuffer output  = new StringBuffer();
	private StringBuffer inline  = new StringBuffer();
	private StringBuffer outline = new StringBuffer();
	private boolean isCRLF = false;
	PrintWriter out;
	
	public Output(String s) throws Exception {
		this.out = new PrintWriter(s + OUT_EXTENSION);
 	}

	public void scan(char c) throws Exception {
		if (inline.length() > 0) {
			len += inline.toString().trim().length() + 4; 
			output.append("( ");
			output.append(inline.toString().trim());
			output.append(" )");
			inline.setLength(0);
		}
		switch (c) {
			case Words.CR:
			case Words.LF:
				if (isCRLF) return;
				isCRLF = true;
				String s = output.toString();
				if (outline.length() > 0) {
					while (len < STR_SIZE) {
						output.append(' ');
						len++;
					}
					output.append("( ");
					output.append(outline.toString().trim());
					output.append(")");
					s = output.toString();
					out.println(s);
					outline.setLength(0);
				}
				output.setLength(0);
				len = 0;
				return;
			default:
				isCRLF = false;
				if (c == Words.TAB) {
					int n = TAB_SIZE - (len % TAB_SIZE);
					len += (n == 0)?TAB_SIZE:n;
				} else {
					len++;
				}
				output.append(c);
				return;
		}
	}

	public void addComment(String s, boolean isInline) {
		if (isInline) {
			inline.append(s);
		} else {
			outline.append(s);
		}
	}
	
	public void close() {
		out.close();
	}
}
