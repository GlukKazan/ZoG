package com.gluk.dagaz.drf.loader.api;

import java.util.Collection;

import com.gluk.dagaz.drf.api.INode;

public interface IPool {
	INode getNode(String name) throws Exception;
	Collection<String> getNames();
}
