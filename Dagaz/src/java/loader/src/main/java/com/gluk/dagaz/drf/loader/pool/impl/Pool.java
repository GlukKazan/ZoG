package com.gluk.dagaz.drf.loader.pool.impl;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import com.gluk.dagaz.drf.api.INode;
import com.gluk.dagaz.drf.impl.Atom;
import com.gluk.dagaz.drf.loader.api.IPool;

public abstract class Pool implements IPool {
	
	protected Map<String, INode> nodes = new HashMap<String, INode>();

	protected void add(String name, INode n) {
		nodes.put(name, n);
	}

	public INode getNode(String name) throws Exception {
		INode r = nodes.get(name);
		if (r == null) {
			throw new Exception("Node [" + name + "] not found");
		}
		return r;
	}

	public Collection<String> getNames() {
		return nodes.keySet();
	}
	
	public INode add(INode n) throws Exception {
		String name = n.getName();
		INode r = nodes.get(name);
		if (r == null) {
			r = new Atom(name);
			nodes.put(name, r);
		}
		return r;
	}
}
