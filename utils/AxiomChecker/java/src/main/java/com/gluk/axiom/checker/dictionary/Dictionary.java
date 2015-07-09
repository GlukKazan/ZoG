package com.gluk.axiom.checker.dictionary;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.gluk.axiom.checker.api.IDictionary;
import com.gluk.axiom.checker.api.IWord;
import com.gluk.axiom.checker.api.Words;

public class Dictionary implements IDictionary {
	
    private static final Logger LOGGER = Logger.getLogger(Dictionary.class);

    private Map<String, Type>  types = new HashMap<String, Type>();
	private Map<String, IWord> words = new HashMap<String, IWord>();
	
	public Type getType(String s) {
		Type r = types.get(s);
		if (r == null) {
			r = new Type();
			types.put(s, r);
		}
		return r;
	}

	public void setEqual(String a, String b) {
		Type ta = getType(a);
		Type tb = getType(b);
		ta.addEqualType(tb);
		tb.addEqualType(ta);
		LOGGER.debug(a + " == " + b);
	}

	public void setInherits(String a, String b) {
		Type ta = getType(a);
		Type tb = getType(b);
		ta.addChildType(tb);
		LOGGER.debug(a + " <= " + b);
	}

	public boolean isTypeMatched(String a, String b) {
		if (a.equals(Words.ANY_TYPE) || b.equals(Words.ANY_TYPE)) {
			return true;
		}
		Type ta = getType(a);
		Type tb = getType(b);
		if (ta.isEqual(tb) || tb.isEqual(ta)) {
			return true;
		}
		return ta.iParentOf(tb);
	}

	public IWord addWord(String s) throws Exception {
		IWord r = words.get(s);
		if (r != null) {
			throw new Exception("Word [" + s + "] already defined");
		}
		r = new Word();
		words.put(s, r);
		return r;
	}

	public IWord getWord(String s) throws Exception {
		IWord r = words.get(s);
		if (r == null) {
			throw new Exception("Word [" + s + "] undefined");
		}
		return r;
	}

	public boolean isDefined(String s) {
		return (words.get(s) != null);
	}
}
