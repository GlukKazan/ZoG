package com.gluk.dagaz.drf.loader.impl;

import com.gluk.dagaz.drf.loader.api.IEnvironment;
import org.apache.commons.io.FilenameUtils;

public class RootLoader extends Loader {
	
	public RootLoader(IEnvironment env) {
		super(env);
	}

	public void load(String fileName) throws Exception {
		String path = FilenameUtils.getFullPath(fileName);
		if (!path.isEmpty()) {
			env.setPath(path);
		}
		super.load(FilenameUtils.getName(fileName));
	}
}
