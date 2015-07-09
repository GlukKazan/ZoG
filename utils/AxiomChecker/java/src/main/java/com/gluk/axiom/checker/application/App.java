package com.gluk.axiom.checker.application;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Stack;

import org.apache.log4j.Logger;

import com.gluk.axiom.checker.api.IApplication;
import com.gluk.axiom.checker.api.IDictionary;
import com.gluk.axiom.checker.api.IParser;
import com.gluk.axiom.checker.api.IScaner;
import com.gluk.axiom.checker.api.ISerializer;
import com.gluk.axiom.checker.api.Words;
import com.gluk.axiom.checker.dictionary.Dictionary;
import com.gluk.axiom.checker.parser.Loader;
import com.gluk.axiom.checker.parser.Parser;
import com.gluk.axiom.checker.parser.Scaner;

public class App implements IApplication {
	
    private static final Logger LOGGER = Logger.getLogger(App.class);

    private final static String LIB_FILE = "./lib.4th";
	
	private IDictionary dict = new Dictionary();
	private Stack<ISerializer> outs = new Stack<ISerializer>();
	private IParser loader = null;
	private String path = ".";

	public IDictionary getDictionary() {
		return dict;
	}

	public ISerializer getSerializer() {
		if (outs.isEmpty()) {
			return null;
		}
		return outs.peek();
	}
	
	private String getPath(String s) {
		int pos = Math.max(s.indexOf('/'), s.indexOf('\\'));
		if (pos <= 0) {
			return "";
		}
		while (true) {
			int p = Math.max(s.indexOf('/', pos + 1), s.indexOf('\\', pos + 1));
			if (p < 0) break;
			pos = p;
		}
		return s.substring(0, pos);
	}
	
	private void read(String s, IParser parser) throws Exception {
		IScaner scaner = new Scaner(this, parser);
		BufferedReader f = new BufferedReader(new FileReader(s));
		try {
			String line = f.readLine();
			while (line != null) {
				try {
					for (Character c: line.toCharArray()) {
						scaner.scan(c);
					}
					scaner.scan(Words.CR);
				} catch (Exception e) {
					ISerializer o = getSerializer();
					o.addComment(e.toString(), true);
				}
				line = f.readLine();
			}
		} finally {
			f.close();
		}
	}
	
	private void init() throws Exception {
		loader = new Loader(dict);
		read(LIB_FILE, loader);
	}

	public void load(String s) throws Exception {
		String p = getPath(s);
		if (p.isEmpty()) {
			s = path + "/" + s;
		} else {
			path = p;
		}
		ISerializer out = new Output(s);
		outs.push(out);
		try {
			IParser parser = new Parser(this, loader);
			read(s, parser);
		} finally {
			out.close();
			outs.pop();
		}
	}
	
	public static void main(String[] args) {
		App app = new App();
		try {
			app.init();
			for (String s: args) {
				app.load(s);
			}
		} catch (Exception e) {
			LOGGER.fatal(e.toString(), e);
		}
	}
}
