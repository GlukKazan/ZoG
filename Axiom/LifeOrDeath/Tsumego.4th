LOAD Go.4th

$gameLog	ON

0	CONSTANT	MIN_WX
0	CONSTANT	MIN_WY
5	CONSTANT	MAX_WX
5	CONSTANT	MAX_WY

0	CONSTANT	MIN_BX
0	CONSTANT	MIN_BY
5	CONSTANT	MAX_BX
5	CONSTANT	MAX_BY

VARIABLE	curr-player
VARIABLE	raw-size
VARIABLE	group-size
VARIABLE	dame-size
VARIABLE	eyes-cnt

SIZE []		raw[]
SIZE []		group[]
SIZE []		dame[]

: between? ( x min max -- ? )
	ROT DUP ROT <=
	ROT ROT <= AND
;

: check-move ( -- ? )
	current-player White = IF
		here get-x MIN_WX MAX_WX between?
		here get-y MIN_WY MAX_WY between? AND
	ENDIF
	current-player Black = IF
		here get-x MIN_BX MAX_BX between?
		here get-y MIN_BY MAX_BY between? AND
	ENDIF
;

' check-move		IS CHECK-MOVE

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
	2DROP
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
	UNTIL
		1- DUP 0 >= IF
			DUP  dame[] @ to ['] North check-eye-dir
			OVER dame[] @ to ['] South check-eye-dir AND
			OVER dame[] @ to ['] East  check-eye-dir AND
			OVER dame[] @ to ['] West  check-eye-dir AND
			IF eyes-cnt ++ ENDIF
		ENDIF
		DUP 0> NOT
	DROP to
;

: check-win-player ( gameResult player -- gameResult )
	DUP get-raw raw-size @ 
	0= IF
		current-player = IF
			2DROP #LossScore
		ELSE
			2DROP #WinScore
		ENDIF
	ELSE
		FALSE BEGIN
			get-group IF
				calc-eyes eyes-cnt @ 2 > IF
					DROP TRUE TRUE
				ELSE
					FALSE
				ENDIF
			ELSE
				TRUE
			ENDIF
		UNTIL
		IF
			current-player = IF
				2DROP #WinScore
			ELSE
				2DROP #LossScore
			ENDIF
		ELSE
			DROP
		ENDIF
	ENDIF
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	move-counter @ 0> IF
		White check-win-player
		Black check-win-player
	ENDIF
;

{board-setup
	{setup}	White	Stone	a18
	{setup}	White	Stone	b18
	{setup}	White	Stone	c18
	{setup}	White	Stone	d18
	{setup}	White	Stone	d19

	{setup}	Black	Stone	b15
	{setup}	Black	Stone	b17
	{setup}	Black	Stone	c17
	{setup}	Black	Stone	d17
	{setup}	Black	Stone	e18
	{setup}	Black	Stone	f18
board-setup}
