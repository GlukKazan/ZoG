package com.gluk.axiom.checker.api;

public interface ISerializer extends IScaner {
	void addComment(String s, boolean isInline);
	void close();
}
