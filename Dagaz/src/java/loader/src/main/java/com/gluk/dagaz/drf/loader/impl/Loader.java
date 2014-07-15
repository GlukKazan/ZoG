package com.gluk.dagaz.drf.loader.impl;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import org.apache.commons.io.FilenameUtils;

import com.gluk.dagaz.drf.loader.api.IEnvironment;
import com.gluk.dagaz.drf.loader.api.ILoader;
import com.gluk.dagaz.drf.loader.api.IParser;
import com.gluk.dagaz.drf.loader.api.IScaner;

public class Loader implements ILoader {
	
	private final String UTF8 = "UTF-8";
	
	protected IEnvironment env;
	
	public Loader(IEnvironment env) {
		this.env = env;
	}
	
	private boolean isAbsolute(String fileName) {
		String prefix = FilenameUtils.getPrefix(fileName);
		return (prefix.contains("/") || prefix.contains("\\")); 
	}
	
	public void load(String fileName) throws Exception {
		if (!isAbsolute(fileName)) {
			fileName = env.getPath() + FilenameUtils.getPath(fileName) + FilenameUtils.getName(fileName);
		}
		IParser parser = new Parser(env);
		IScaner scaner = new Scaner(parser);
		BufferedReader in = new BufferedReader(
			       new InputStreamReader(
			                  new FileInputStream(fileName), UTF8));
		String str;
		while ((str = in.readLine()) != null) {
			for (char c: str.toCharArray()) {
				scaner.scan(c);
			}
			scaner.cr();
		}
	}
}
