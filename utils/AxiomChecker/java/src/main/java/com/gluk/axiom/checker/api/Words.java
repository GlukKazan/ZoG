package com.gluk.axiom.checker.api;

public interface Words {
	public final static String BNG_WORD          = "!";
	public final static String DEF_WORD          = ":";
	public final static String END_WORD          = ";";
	public final static String EQL_WORD          = "==";
	public final static String INH_WORD          = "<=";
	public final static String OUT_WORD          = "--";
	public final static String ARG_WORD          = "<<";
	
	public final static String IF_WORD           = "IF";
	public final static String ELSE_WORD         = "ELSE";
	public final static String ENDIF_WORD        = "ENDIF";
	public final static String BEGIN_WORD        = "BEGIN";
	public final static String UNTIL_WORD        = "UNTIL";
	public final static String EXECUTE_WORD      = "EXECUTE";
	public final static String RECURSE_WORD      = "RECURSE";
	public final static String LOAD_WORD         = "LOAD";

	public final static String ANY_TYPE          = ".";
	public final static String NUM_TYPE          = "i";
	public final static String POS_TYPE          = "p";
	public final static String ARRAY_TYPE        = "*";
	public final static String QUOTE_TYPE        = "\'";
	public final static String FUNC_TYPE         = "`";
	
	public final static char   OPEN              = '(';
	public final static char   CLOSE             = ')';
	public final static char   COMMENT           = '\\';
	public final static char   CR                = '\n';
	public final static char   LF                = '\r';
	public final static char   TAB               = '\t';
	public final static char   SPACE             = ' ';
	public final static char   BANG              = '!';
}
