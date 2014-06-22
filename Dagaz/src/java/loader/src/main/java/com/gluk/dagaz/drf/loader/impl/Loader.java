package com.gluk.dagaz.drf.loader.impl;

import com.gluk.dagaz.drf.loader.api.ILoader;
import com.gluk.dagaz.drf.loader.api.IPool;
import com.gluk.dagaz.drf.loader.pool.impl.AtomPool;
import com.gluk.dagaz.drf.loader.pool.impl.DefPool;
import com.gluk.dagaz.drf.loader.pool.impl.VarPool;

public class Loader implements ILoader {
	
	private AtomPool atoms = new AtomPool();
	private DefPool  defs  = new DefPool();
	private VarPool  vars  = new VarPool();

	public IPool getAtoms() {
		return atoms;
	}

	public IPool getDefinitions() {
		return defs;
	}

	public IPool getVariants() {
		return vars;
	}

	public void load(String fileName) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
