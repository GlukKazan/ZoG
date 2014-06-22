package com.gluk.dagaz.drf.loader.pool.impl;

import com.gluk.dagaz.drf.api.IList;
import com.gluk.dagaz.drf.api.ILiteral;
import com.gluk.dagaz.drf.api.INode;

public class VarPool extends Pool {

	private final static String VAR_ATOM   = "variant";
	private final static String TITLE_ATOM = "title";

	public static String getListName(IList l) throws Exception {
		if (l.isEmpty()) {
			return "";
		}
		INode car = l.getNode(0);
		if (!car.isAtom() || !car.getName().equals(VAR_ATOM)) {
			return "";
		}
		INode n = l.getNode(TITLE_ATOM);
		if ((n == null) || !n.isList()) {
			throw new Exception("Bad Game Variant");
		}
		IList nl = n.getList();
		if (nl.getSize() != 2) {
			throw new Exception("Bad Game Variant");
		}
		INode cdar = nl.getNode(1);
		if (!cdar.isLiteral()) {
			throw new Exception("Bad Game Variant");
		}
		ILiteral cdars = cdar.getLiteral();
		return cdars.getString();
	}
	
	@Override
	public INode add(INode n) throws Exception {
		if (!n.isList()) {
			throw new Exception("Bad List");
		}
		IList l = n.getList();
		INode car = l.getNode(0);
		if (!car.isAtom() || !car.getName().equals(VAR_ATOM)) {
			throw new Exception("Bad Game Variant");
		}
		return super.add(n);
	}
}
