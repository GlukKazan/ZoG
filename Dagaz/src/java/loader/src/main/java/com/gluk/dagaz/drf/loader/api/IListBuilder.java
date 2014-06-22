package com.gluk.dagaz.drf.loader.api;

import com.gluk.dagaz.drf.api.IList;
import com.gluk.dagaz.drf.api.INode;

public interface IListBuilder extends IList {
	void add(INode n);
}
