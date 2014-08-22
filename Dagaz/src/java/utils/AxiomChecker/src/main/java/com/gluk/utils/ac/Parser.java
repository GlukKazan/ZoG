package com.gluk.utils.ac;

public class Parser implements IParser {
	
	private WordChecker  checker = null;
	private boolean nameRequired = false;

	public void parse(String word) throws Exception {
		if (checker != null) {
			if (!checker.check(word)) {
				System.out.println("Error [" + word + "] in [" + checker.getName() + "]");
			}
		} 
		if (nameRequired) {
			checker = new WordChecker(word);
			nameRequired = false;
			return;
		}
		if (word.equals(Words.BEGIN_WORD)) {
			nameRequired = true;
			return;
		}
		if (word.equals(Words.END_WORD)) {
			checker = null;
			return;
		}
	}
}
