package com.gluk.utils.ac;

import java.util.HashMap;
import java.util.Map;

public class WordPool {
	
	private static WordPool instance = null;
	
	private Map<String, WordItem> words = new HashMap<String, WordItem>();
	
	private WordPool() {}
	
	public synchronized static WordPool getInstance() throws Exception {
		if (instance == null) {
			instance = new WordPool();
			Core.init();
		}
		return instance;
	}
	
	public WordItem getWord(String name) throws Exception {
		WordItem r = words.get(name);
		if (r == null) {
			throw new Exception("Word [" + name + "] not found");
		}
		return r;
	}
	
	public void setWord(String name, int inArgs, int outArgs) throws Exception {
		WordItem r = words.get(name);
		if (r != null) {
			throw new Exception("Word [" + name + "] already defined");
		}
		words.put(name, new WordItem(inArgs, outArgs));
	}
	
	public boolean isDefined(String name) {
		return (words.get(name) != null);
	}
}
