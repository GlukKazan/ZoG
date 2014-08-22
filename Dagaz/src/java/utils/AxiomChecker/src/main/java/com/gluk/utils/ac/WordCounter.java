package com.gluk.utils.ac;

public class WordCounter {
	
	private String name;
	private int size;
	private int priv = -1;
	private WordCounter counter = null;
	
	public WordCounter(String name, int size) {
		this.name = name;
		this.size = size;
	}
	
	public int getSize() {
		return size;
	}

	public boolean isWellClosed() {
		return (counter == null);
	}
	
	public boolean check(String word) throws Exception {
		WordPool pool = WordPool.getInstance();
		if (counter != null) {
			boolean r = counter.check(word);
			if ((counter != null) && counter.isWellClosed()) {
				if (word.equals(Words.UNTIL_WORD)) {
					if (counter.getSize() != size) return false;
					counter = null;
				}
				if (word.equals(Words.ELSE_WORD)) {
					if (priv >= 0) return false;
					priv = counter.getSize(); 
					counter = new WordCounter(name, size);
				}
				if (word.equals(Words.ENDIF_WORD)) {
					if (priv >= 0) {
						if (counter.getSize() != priv) return false;
					}
					size = counter.getSize();
					counter = null;
				}
			}
			return r;
		}
		if (word.equals(Words.R_WORD)) {
			WordItem item = pool.getWord(name);
			int ic = item.getInArgs();
			int oc = item.getOutArgs();
			if (size < ic) {
				return false;
			}
			size -= ic - oc;
			return true;
		}
		if (word.equals(Words.LOOP_WORD)) {
			counter = new WordCounter(name, size);
			return true;
		}
		if (word.equals(Words.IF_WORD)) {
			priv = -1;
			if (size < 1) return false;
			size--;
			counter = new WordCounter(name, size);
			return true;
		}
		WordItem item = pool.getWord(word);
		int ic = item.getInArgs();
		int oc = item.getOutArgs();
		if (size < ic) {
			return false;
		}
		size -= ic - oc;
		return true;
	}
}
