VARIABLE	alloc-path
VARIABLE	alloc-val
VARIABLE	alloc-target
VARIABLE	alloc-pos
VARIABLE	pos-count
7 []		pos[]

DEFER		mark

: val ( -- n )
	piece-type mark - ABS
;

: val-at ( pos -- n )
	piece-type-at mark - ABS
;

: add-pos ( pos -- )
	pos-count @ pos[] !
	pos-count ++
;

: not-in-pos? ( pos -- ? )
	TRUE SWAP
	0 BEGIN
		OVER OVER pos[] @ = IF
			2DROP DROP FALSE
			0 0 TRUE
		ELSE
			1+ DUP pos-count @ >=
		ENDIF
	UNTIL 2DROP
;

: clear-neg ( -- )
	0 BEGIN
		DUP enemy-at? OVER here <> AND IF
			DUP piece-type-at mark -
			DUP 0< IF
				NEGATE mark +
				OVER DUP
				player-at ROT ROT
				create-player-piece-type-at
			ELSE
				DROP
			ENDIF
		ENDIF
		1+ DUP A9 >
	UNTIL DROP
;

: neg-exists? ( -- ? )
	FALSE 0 BEGIN
		DUP friend-at? OVER piece-type-at mark < AND IF
			2DROP TRUE A9
		ENDIF
		1+ DUP A9 >
	UNTIL DROP
;

: check-neg ( -- )
	neg-exists? IF
		piece-type mark < verify
	ENDIF
;

: mirror ( 'dir  -- 'dir )
	DUP ['] nw = IF
		DROP ['] sw
	ELSE
		DUP ['] ne = IF
			DROP ['] se
		ELSE
			DUP ['] sw = IF
				DROP ['] nw
			ELSE
				['] se = verify
				['] ne
			ENDIF
		ENDIF
	ENDIF
;

: step ( 'dir  -- 'dir )
	DUP EXECUTE NOT IF
		mirror
		DUP EXECUTE verify
	ENDIF
;

: check-pass ( -- )
	pass-flag enemy-at? NOT verify
;

: check-empty-pass ( -- )
	pass-flag empty-at? verify
;

: set-pass ( -- )
	mark pass-flag create-piece-type-at
;

: clear-pass ( -- )
	pass-flag empty-at? NOT IF
		pass-flag player-at for-player = IF
			pass-flag capture-at
		ENDIF
	ENDIF
;

: exchange ( n 'dir -- )
	LITE-VERSION NOT IF
		check-empty-pass
		neg-exists? NOT verify
	ENDIF
	OVER val < verify
	EXECUTE verify
	friend? verify
	DUP val + 6 <= verify
	from here move
	LITE-VERSION NOT IF
		clear-neg
	ENDIF
	DUP piece-type mark - ABS mark + + create-piece-type
	from to piece-type mark - ABS mark + SWAP - create-piece-type
	add-move
;

: exchange-1-nw ( -- ) 1 ['] nw exchange ;
: exchange-1-sw ( -- ) 1 ['] sw exchange ;
: exchange-1-ne ( -- ) 1 ['] ne exchange ;
: exchange-1-se ( -- ) 1 ['] se exchange ;
: exchange-1-w  ( -- ) 1 ['] w  exchange ;
: exchange-1-e  ( -- ) 1 ['] e  exchange ;

: exchange-2-nw ( -- ) 2 ['] nw exchange ;
: exchange-2-sw ( -- ) 2 ['] sw exchange ;
: exchange-2-ne ( -- ) 2 ['] ne exchange ;
: exchange-2-se ( -- ) 2 ['] se exchange ;
: exchange-2-w  ( -- ) 2 ['] w  exchange ;
: exchange-2-e  ( -- ) 2 ['] e  exchange ;

: exchange-3-nw ( -- ) 3 ['] nw exchange ;
: exchange-3-sw ( -- ) 3 ['] sw exchange ;
: exchange-3-ne ( -- ) 3 ['] ne exchange ;
: exchange-3-se ( -- ) 3 ['] se exchange ;
: exchange-3-w  ( -- ) 3 ['] w  exchange ;
: exchange-3-e  ( -- ) 3 ['] e  exchange ;

: exchange-4-nw ( -- ) 4 ['] nw exchange ;
: exchange-4-sw ( -- ) 4 ['] sw exchange ;
: exchange-4-ne ( -- ) 4 ['] ne exchange ;
: exchange-4-se ( -- ) 4 ['] se exchange ;
: exchange-4-w  ( -- ) 4 ['] w  exchange ;
: exchange-4-e  ( -- ) 4 ['] e  exchange ;

: exchange-5-nw ( -- ) 5 ['] nw exchange ;
: exchange-5-sw ( -- ) 5 ['] sw exchange ;
: exchange-5-ne ( -- ) 5 ['] ne exchange ;
: exchange-5-se ( -- ) 5 ['] se exchange ;
: exchange-5-w  ( -- ) 5 ['] w  exchange ;
: exchange-5-e  ( -- ) 5 ['] e  exchange ;

: my-empty? ( -- ? )
	empty? here from = OR NOT IF
		FALSE
	ELSE
		here E5 <>
	ENDIF
;

: bump ( 'dir -- )
	BEGIN
		here E5 <> verify
		friend? here from <> AND IF
			piece-type SWAP step SWAP
			mark - ABS mark
			LITE-VERSION NOT enemy? AND IF
				SWAP -
			ELSE
				+
			ENDIF
			create-piece-type
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: my-next-player ( -- player )
	current-player Red = IF
		White
	ELSE
		Red
	ENDIF
;

: alloc-to ( pos -- )
	DUP add-pos
	DUP val-at 6 SWAP -
	DUP alloc-val @ > IF
		DROP alloc-val @
		0 alloc-val !
	ELSE
		alloc-val @ OVER - alloc-val !
	ENDIF
	my-next-player ROT ROT
	OVER piece-type-at + SWAP
	create-player-piece-type-at
;

: alloc ( -- )
	6 0 BEGIN
		DUP enemy-at? OVER not-in-pos? AND IF
			SWAP OVER val-at MIN SWAP
		ENDIF
		1+ DUP A9 >
	UNTIL DROP
	DUP 6 < IF
		alloc-target !
		alloc-path @ 10 MOD alloc-pos !
		0 BEGIN
			DUP enemy-at? OVER not-in-pos? AND IF
				DUP val-at alloc-target @ = IF
					alloc-pos @ 0= IF
						DUP alloc-to
						0 alloc-target !
						DROP A9
					ELSE
						alloc-pos --
					ENDIF
				ENDIF
			ENDIF
			1+ DUP A9 >
		UNTIL DROP
		alloc-target @ 0= verify
		alloc-val @ 0> IF
			alloc-path @ 10 / alloc-path !
			RECURSE
		ENDIF
	ELSE
		DROP
	ENDIF
;

: slide ( 'dir -- )
	LITE-VERSION NOT IF
		check-empty-pass
		neg-exists? NOT verify
	ENDIF
	val SWAP BEGIN
		step
		SWAP 1- DUP 0= IF
			TRUE
		ELSE
			my-empty? verify
			SWAP FALSE
		ENDIF
	UNTIL DROP
	from here move
	bump 
	LITE-VERSION NOT IF
		clear-neg
	ENDIF
	my-empty? verify
	add-move
;

: slide-nw ( -- ) ['] nw slide ;
: slide-sw ( -- ) ['] sw slide ;
: slide-ne ( -- ) ['] ne slide ;
: slide-se ( -- ) ['] se slide ;
: slide-w  ( -- ) ['] w  slide ;
: slide-e  ( -- ) ['] e  slide ;

: alloc-all ( -- )
	val alloc-val !
	0 pos-count !
	here add-pos
	alloc
;

: eat ( 'dir n -- )
	LITE-VERSION NOT IF
		check-pass
		check-neg
	ENDIF
	alloc-path !
	val SWAP BEGIN
		step
		SWAP 1- DUP 0= IF
			TRUE
		ELSE
			my-empty? verify
			SWAP FALSE
		ENDIF
	UNTIL DROP
	from here move
	LITE-VERSION NOT enemy? AND IF
		from piece-type-at mark - ABS
		mark SWAP - create-piece-type
	ENDIF
	bump 
	enemy? verify
	LITE-VERSION NOT IF
		clear-neg
		set-pass
	ENDIF
	alloc-all
	add-move
;

: eat-nw-0 ( -- ) ['] nw 0 eat ;
: eat-sw-0 ( -- ) ['] sw 0 eat ;
: eat-ne-0 ( -- ) ['] ne 0 eat ;
: eat-se-0 ( -- ) ['] se 0 eat ;
: eat-w-0  ( -- ) ['] w  0 eat ;
: eat-e-0  ( -- ) ['] e  0 eat ;

: eat-nw-1 ( -- ) ['] nw 1 eat ;
: eat-sw-1 ( -- ) ['] sw 1 eat ;
: eat-ne-1 ( -- ) ['] ne 1 eat ;
: eat-se-1 ( -- ) ['] se 1 eat ;
: eat-w-1  ( -- ) ['] w  1 eat ;
: eat-e-1  ( -- ) ['] e  1 eat ;

: drop-m ( -- )
	op-flag here = verify
	drop
	clear-pass
	add-move
;
