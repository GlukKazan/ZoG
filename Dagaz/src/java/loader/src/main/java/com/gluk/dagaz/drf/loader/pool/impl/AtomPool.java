package com.gluk.dagaz.drf.loader.pool.impl;

import com.gluk.dagaz.drf.api.INode;

public class AtomPool extends Pool {

	@Override
	public INode add(INode n) throws Exception {
		if ((n == null) || !n.isAtom()) {
			throw new Exception("Bad Atom");
		}
		return super.add(n);
	}
}
