package com.gluk.dagaz.drf.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.gluk.dagaz.drf.api.IList;
import com.gluk.dagaz.drf.api.ILiteral;
import com.gluk.dagaz.drf.api.INode;
import com.gluk.dagaz.drf.loader.api.IListBuilder;
import com.gluk.dagaz.drf.loader.pool.impl.DefPool;
import com.gluk.dagaz.drf.loader.pool.impl.VarPool;

public class NodeList implements IListBuilder {
	
	private List<INode> nodes = new ArrayList<INode>();
	
	public boolean isAtom() {
		return false;
	}

	public boolean isList() {
		return true;
	}

	public boolean isLiteral() {
		return false;
	}

	public boolean isEmpty() {
		return nodes.isEmpty();
	}

	public Collection<INode> getNodes() {
		return nodes;
	}

	public INode getNode(int index) throws Exception {
		INode r = nodes.get(index);
		if (r == null) {
			throw new Exception("Bad Index [" + Integer.toString(index) + "]");
		}
		return r;
	}

	public int getSize() {
		return nodes.size();
	}

	public INode getNode(String name) throws Exception {
		for (INode n: nodes) {
			if (name.equals(n.getName())) {
				return n;
			}
		}
		return null;
	}

	public String getName() throws Exception {
		String r = DefPool.getListName(this);
		if (!r.isEmpty()) {
			return r;
		}
		r = VarPool.getListName(this);
		if (!r.isEmpty()) {
			return r;
		}
		if (isEmpty()) {
			throw new Exception("Empty List");
		}
		INode car = getNode(0);
		return car.getName();
	}

	public IList getList() throws Exception {
		return this;
	}

	public ILiteral getLiteral() throws Exception {
		throw new Exception("Not a Literal");
	}

	public void add(INode n) {
		nodes.add(n);
	}
}
