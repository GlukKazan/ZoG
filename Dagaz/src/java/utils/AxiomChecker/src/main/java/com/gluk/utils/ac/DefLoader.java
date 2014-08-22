package com.gluk.utils.ac;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.filefilter.SuffixFileFilter;

public class DefLoader {
	
	private static DefLoader instance = null;
	
	private Set<String> names = new HashSet<String>();
	
	private DefLoader() {}
	
	public synchronized static DefLoader getInstance() {
		if (instance == null) {
			instance = new DefLoader();
		}
		return instance;
	}
	
	private boolean isRelative(String name) {
		return FilenameUtils.getPrefix(name).isEmpty(); 
	}
	
	public void load(String name) throws Exception {
		if (isRelative(name)) {
			name = "./" + name;
		}
		name = FilenameUtils.getFullPath(name);
		File dir = new File(name);
		String[] files = dir.list( 
			new SuffixFileFilter(".4th")						
		);
		for (int i=0; i < files.length; i++) {
			load(name, files[i]);
		}
	}

	private void load(String dir, String name) throws Exception {
		if (names.contains(name)) {
			return;
		}
		names.add(name);
		PreParser parser = new PreParser();
		PreScaner scaner = new PreScaner(parser);
		BufferedReader in = new BufferedReader(
			       new InputStreamReader(
			                  new FileInputStream(dir + name), "UTF-8"));
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
