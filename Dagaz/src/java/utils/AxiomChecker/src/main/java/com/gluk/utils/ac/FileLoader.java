package com.gluk.utils.ac;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;

public class FileLoader {
	
	private static FileLoader instance = null;
	
	private DefLoader defs = DefLoader.getInstance();
	
	private FileLoader() {}
	
	public synchronized static FileLoader getInstance() {
		if (instance == null) {
			instance = new FileLoader();
		}
		return instance;
	}
	
	public void load(String name) throws Exception {
		defs.load(name);
		Parser parser = new Parser();
		Scaner scaner = new Scaner(parser);
		BufferedReader in = new BufferedReader(
			       new InputStreamReader(
			                  new FileInputStream(name), "UTF-8"));
		String str;
		while ((str = in.readLine()) != null) {
			for (char c: str.toCharArray()) {
				scaner.scan(c);
			}
			scaner.scan(Chars.CR);
		}
		scaner.scan(Chars.SPACE);
	}
}
