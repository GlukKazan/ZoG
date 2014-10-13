VARIABLE	curr-player
VARIABLE	raw-size
VARIABLE	group-size
VARIABLE	dame-size
VARIABLE	eyes-cnt

SIZE []		raw[]
SIZE []		group[]
SIZE []		dame[]

: add-to-raw ( pos -- )
	raw-size @ SIZE < IF
		raw-size @ raw[] !
		raw-size ++
	ELSE
		DROP
	ENDIF
;

: del-from-raw ( pos -- )
	raw-size @ BEGIN
		1- DUP 0 >= IF
			OVER OVER raw[] @ = IF
				-1 OVER raw[] !
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	2DROP
;

: find-raw ( -- pos )
	-1 raw-size @ BEGIN
		1- DUP 0 >= IF
			DUP raw[] @ 
			DUP 0< IF
				DROP
			ELSE
				SWAP DROP SWAP DROP 0
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	DROP
;

: get-raw ( player -- )
	0 raw-size !
	DUP curr-player !
	SIZE BEGIN
		1- DUP 0 >= IF
			DUP my-empty-at? NOT IF
				OVER OVER player-at = IF
					DUP add-to-raw
				ENDIF
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	2DROP
;

: in-group? ( pos -- ? )
	FALSE group-size @
	BEGIN
		1- DUP 0 >= IF
			OVER OVER group[] @ = IF
				2DROP TRUE 0
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	DROP
;

: add-to-group ( pos -- )
	DUP in-group? NOT IF
		DUP del-from-raw
		group-size @ SIZE < IF
			group-size @ group[] !
			group-size ++
		ELSE
			DROP
		ENDIF
	ELSE
		DROP
	ENDIF
;

: in-dame? ( pos -- ? )
	FALSE dame-size @
	BEGIN
		1- DUP 0 >= IF
			OVER OVER dame[] @ = IF
				2DROP TRUE 0
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	DROP
;

: add-to-dame ( pos -- )
	DUP in-dame? NOT IF
		dame-size @ SIZE < IF
			dame-size @ dame[] !
			dame-size ++
		ELSE
			DROP
		ENDIF
	ELSE
		DROP
	ENDIF
;

: check-dir ( 'dir -- )
	EXECUTE IF
		my-empty? IF
			here add-to-dame
		ELSE
			curr-player @ player = IF
				here add-to-group
			ENDIF
		ENDIF
	ENDIF
;

: scan-group ( -- )
	0 BEGIN
		DUP group[] @ DUP
		to  ['] North check-dir DUP
		to  ['] South check-dir DUP
		to  ['] East  check-dir DUP
		to  ['] West  check-dir
		1+ DUP group-size @ >=
	UNTIL
	DROP
;

: get-group ( -- ? )
	0 group-size !
	0 dame-size !
	find-raw DUP 0< IF
		DROP FALSE
	ELSE
		add-to-group
		here scan-group to
	ENDIF
;

: check-eye-dir ( 'dir -- ? )
	EXECUTE IF
		my-empty? IF
			FALSE
		ELSE
			curr-player @ player =
		ENDIF
	ELSE
		TRUE
	ENDIF
;

: calc-eyes ( -- )
	0 eyes-cnt !
	here dame-size @ BEGIN
		1- DUP 0 >= IF
			DUP  dame[] @ to ['] North check-eye-dir
			OVER dame[] @ to ['] South check-eye-dir AND
			OVER dame[] @ to ['] East  check-eye-dir AND
			OVER dame[] @ to ['] West  check-eye-dir AND
			IF eyes-cnt ++ ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	DROP to
;
