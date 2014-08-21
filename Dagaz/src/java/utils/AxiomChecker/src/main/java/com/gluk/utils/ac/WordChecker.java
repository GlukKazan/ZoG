package com.gluk.utils.ac;

public class WordChecker {
	
	private String  name;
	private boolean isSpecified;
	private WordCounter counter;
	
	public WordChecker(String name) throws Exception {
		this.name = name;
		WordPool pool = WordPool.getInstance();
		isSpecified = pool.isDefined(name);
		counter = new WordCounter(name, pool.getWord(name).getInArgs());
	}
	
	public String getName() {
		return name;
	}
	
	public boolean check(String word) throws Exception {
		if (!isSpecified) return true;
		boolean r = counter.check(word);
		if (!r) {
			isSpecified = false;
		}
		if (word.equals(Words.END_WORD)) {
			if (!counter.isWellClosed()) {
				return false;
			}
			WordPool pool = WordPool.getInstance();
			int sz = pool.getWord(name).getOutArgs();
			if (counter.getSize() != sz) {
				return false;
			}
		}
		return r;
	}
}
