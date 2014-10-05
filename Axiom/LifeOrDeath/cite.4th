LOAD Go.4th

VARIABLE	raw-size
VARIABLE	group-size
VARIABLE	dame-size

SIZE []		raw[]
SIZE []		group[]
SIZE []		dame[]

: is-empty-board? ( -- ? )
	TRUE SIZE BEGIN
		1- DUP 0 >= IF
			DUP empty-at? NOT IF
				2DROP
				FALSE 0
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL DROP
;

: check-move ( -- ? )
	here FALSE
	North IF
		player Black = OR
	ENDIF OVER to
	South IF
		player Black = OR
	ENDIF OVER to
	East IF
		player Black = OR
	ENDIF OVER to
	West IF
		player Black = OR
	ENDIF SWAP to
	is-empty-board? OR
;

' check-move		IS CHECK-MOVE

: add-raw ( pos -- )
	raw-size @ SIZE < IF
		raw-size @ raw[] !
		raw-size ++
	ELSE
		DROP
	ENDIF
;

: del-raw ( pos -- )
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

: get-black-raw ( -- )
	Black
	SIZE BEGIN
		1- DUP 0 >= IF
			DUP empty-at? NOT IF
				OVER OVER player-at = IF
					DUP add-raw
				ENDIF
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	2DROP
;

: add-to-group ( pos -- )
	DUP del-raw
	group-size @ SIZE < IF
		group-size @ group[] !
		group-size ++
	ELSE
		DROP
	ENDIF
;

: init-group ( -- ? )
	0 group-size !
	raw-size @ BEGIN
		1- DUP 0< IF
			TRUE
		ELSE
			DUP raw[] @
			DUP 0< IF
				DROP FALSE
			ELSE
				add-to-group
				TRUE
			ENDIF
		ENDIF
		OVER 0 <= IF
			2DROP 0 TRUE
		ENDIF
	UNTIL
	raw-size !
	group-size @ 0>
;

: add-dame ( pos -- )
	dame-size @ SIZE < IF
		dame-size @ dame[] !
		dame-size ++
	ELSE
		DROP
	ENDIF
;

: check-neighbor ( 'dir pos -- )
	to EXECUTE IF
		empty? IF
			here add-dame
		ELSE
			player Black = IF
				here add-to-group
			ENDIF
		ENDIF
	ENDIF
;

: get-dame ( -- )
	0 BEGIN
		DUP group[] @ 
		['] North OVER check-neighbor
		['] South OVER check-neighbor
		['] East  OVER check-neighbor
		['] West  SWAP check-neighbor
		1+ DUP group-size @ >=
	UNTIL
	DROP
;

: get-atari ( -- )
	get-black-raw here
	BEGIN
		init-group IF
			get-dame
			dame-size @ 1 =
		ELSE
			TRUE
		ENDIF
	UNTIL
	to
;
