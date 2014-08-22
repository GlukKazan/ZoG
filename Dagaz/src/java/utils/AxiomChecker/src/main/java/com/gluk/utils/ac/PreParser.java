package com.gluk.utils.ac;

public class PreParser implements IParser {
	
	private boolean nameRequired = false;
	private boolean varRequired  = false;
	
	private WordPool   pool      = null;
	private DefCounter counter   = null;
	
	private boolean  isApos      = false;
	private boolean  synRequired = false;
	private WordItem syn         = null;
	
	private boolean isVar(String word) {
		return word.equals(Words.CONST_WORD)  || 
			   word.equals(Words.BVAR_WORD)   ||
			   word.equals(Words.ARRAY_WORD)  ||
			   word.equals(Words.DIR_WORD)    ||
			   word.equals(Words.LINK_WORD)   ||
			   word.equals(Words.PLAYER_WORD) ||
			   word.equals(Words.VAR_WORD);
	}

	public void parse(String word) throws Exception {
		if (pool == null) {
			pool = WordPool.getInstance();
		}
		if (varRequired) {
			pool.setWord(word, 0, 1);
			varRequired = false;
			return;
		}
		if (isVar(word)) {
			varRequired = true;
			return;
		}
		if (nameRequired) {
			counter = new DefCounter(word);
			nameRequired = false;
			return;
		}
		if (synRequired && word.equals(Words.IS_WORD)) {
			pool.setWord(word, syn.getInArgs(), syn.getOutArgs());
			syn = null;
			return;
		}		
		if ((syn != null) && word.equals(Words.IS_WORD)) {
			synRequired = true;
			return;
		}
		if (isApos) {
			syn = pool.getWord(word);
			isApos = false;
			return;
		}
		if (word.equals(Words.APOS_WORD)) {
			isApos = true;
			return;
		}
		if (word.equals(Words.BEGIN_WORD)) {
			nameRequired = true;
			return;
		}
		if (word.equals(Words.END_WORD)) {
			if ((counter != null) && counter.isValid()) {
				pool.setWord(counter.getName(), counter.getInArgs(), counter.getOutArgs());
			}
			counter = null;
			return;
		}
		if (counter != null) {
			counter.parse(word);
		}
	}
}
