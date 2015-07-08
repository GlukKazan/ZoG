package com.gluk.axiom.checker.dictionary;

import java.util.HashSet;
import java.util.Set;

public class Type {
	
	private Set<Type> equalTypes = new HashSet<Type>();
	private Set<Type> childTypes = new HashSet<Type>();
	
	public void addEqualType(Type t) {
		equalTypes.add(t);
	}
	
	public void addChildType(Type t) {
		childTypes.add(t);
	}
	
	public boolean isEqual(Type t) {
		return equalTypes.contains(t);
	}
	
	public boolean iParentOf(Type t) {
		if (childTypes.contains(t)) {
			return true;
		}
		for (Type p: equalTypes) {
			if (p.iParentOf(t)) {
				return true;
			}
		}
		return false;
	}
}
