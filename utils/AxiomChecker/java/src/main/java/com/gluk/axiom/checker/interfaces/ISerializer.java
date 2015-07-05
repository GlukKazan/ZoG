package com.gluk.axiom.checker.interfaces;

public interface ISerializer extends IScaner {
	void addComment(String s, boolean isInline);
	void setSpecification(String s);
}
