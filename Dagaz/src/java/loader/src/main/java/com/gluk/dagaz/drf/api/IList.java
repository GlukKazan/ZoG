package com.gluk.dagaz.drf.api;

import java.util.Collection;

public interface IList extends INode {
	boolean isEmpty();
	Collection<INode> getNodes();
	INode getNode(int index) throws Exception;
	INode getNode(String name) throws Exception;
	int getSize();
}
