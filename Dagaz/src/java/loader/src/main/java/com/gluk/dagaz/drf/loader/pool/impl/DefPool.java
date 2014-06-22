package com.gluk.dagaz.drf.loader.pool.impl;

import com.gluk.dagaz.drf.api.IList;
import com.gluk.dagaz.drf.api.INode;

public class DefPool extends Pool {
	
	private final static String DEF_ATOM = "def";
	
	public static String getListName(IList l) throws Exception {
		if (l.isEmpty()) {
			return "";
		}
		INode car = l.getNode(0);
		if (!car.isAtom() || !car.getName().equals(DEF_ATOM)) {
			return "";
		}
		StringBuffer name = new StringBuffer();
		INode cdar = l.getNode(1);
		if (cdar.isAtom()) {
			name.append(cdar.getName());
		} else if (cdar.isList()) {
			IList cdarl = cdar.getList();
			name.append(cdarl.getNode(0).getName());
			name.append("@");
			name.append(Integer.toString(cdarl.getSize() - 1));
		} else {
			return "";
		}
		return name.toString();
	}
	
	@Override
	public INode add(INode n) throws Exception {
		if (!n.isList()) {
			throw new Exception("Bad List");
		}
		IList l = n.getList();
		INode car = l.getNode(0);
		if (!car.isAtom() || !car.getName().equals(DEF_ATOM)) {
			throw new Exception("Bad Definition");
		}
		return super.add(n);
	}
}
