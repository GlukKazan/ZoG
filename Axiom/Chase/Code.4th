VARIABLE	alloc-path
VARIABLE	alloc-val
VARIABLE	alloc-target
VARIABLE	alloc-pos
VARIABLE	split-val
VARIABLE	split-target
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

: bump ( 'dir -- 'dir )
	BEGIN
		friend? here from <> AND IF
			val split-val !
			piece-type SWAP step SWAP
			mark - ABS mark
			LITE-VERSION NOT enemy? AND IF
				SWAP -
			ELSE
				+
			ENDIF
			here E5 <> IF
				create-piece-type
			ELSE
				DROP
			ENDIF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
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
	bump DROP
	here E5 <> verify
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
	bump DROP
	here E5 <> verify
	enemy? verify
	LITE-VERSION NOT IF
		clear-neg
		set-pass
	ENDIF
	val alloc-val !
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

: to-left ( 'dir  -- 'dir )
	MY-VERSION IF
		DUP ['] nw = IF
			DROP ['] w
		ELSE
			DUP ['] ne = IF
				DROP ['] nw
			ELSE
				DUP ['] e = IF
					DROP ['] ne
				ELSE
					DUP ['] se = IF
						DROP ['] e
					ELSE
						DUP ['] sw = IF
							DROP ['] se
						ELSE
							['] w = verify
							['] sw
						ENDIF
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ELSE
		DUP ['] nw = IF
			DROP ['] sw
		ELSE
			DUP ['] ne = IF
				DROP ['] w
			ELSE
				DUP ['] e = IF
					DROP ['] nw
				ELSE
					DUP ['] se = IF
						DROP ['] ne
					ELSE
						DUP ['] sw = IF
							DROP ['] e
						ELSE
							['] w = verify
							['] se
						ENDIF
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDIF
;

: to-right ( 'dir  -- 'dir )
	MY-VERSION IF
		DUP ['] nw = IF
			DROP ['] ne
		ELSE
			DUP ['] ne = IF
				DROP ['] e
			ELSE
				DUP ['] e = IF
					DROP ['] se
				ELSE
					DUP ['] se = IF
						DROP ['] sw
					ELSE
						DUP ['] sw = IF
							DROP ['] w
						ELSE
							['] w = verify
							['] nw
						ENDIF
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ELSE
		DUP ['] nw = IF
			DROP ['] e
		ELSE
			DUP ['] ne = IF
				DROP ['] nw
			ELSE
				DUP ['] e = IF
					DROP ['] sw
				ELSE
					DUP ['] se = IF
						DROP ['] w
					ELSE
						DUP ['] sw = IF
							DROP ['] nw
						ELSE
							['] w = verify
							['] ne
						ENDIF
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDIF
;

: move-part ( 'dir n -- )
	DUP split-target !
	MY-VERSION NOT IF
		DROP 1
	ENDIF
	SWAP BEGIN
		step
		SWAP 1- DUP 0= IF
			TRUE
		ELSE
			my-empty? verify
			SWAP FALSE
		ENDIF
	UNTIL DROP
	split-target @
	enemy? IF
		val alloc-val @ + alloc-val !
		LITE-VERSION NOT IF
			NEGATE
		ENDIF
	ENDIF
	mark + create-piece-type
	friend? IF
		bump
		enemy? IF
			val alloc-val @ + alloc-val !
		ENDIF
	ENDIF DROP
;

: check-ten ( -- )
	0 0 BEGIN
		DUP friend-at? IF
			SWAP 1+ SWAP
		ENDIF
		1+ DUP A9 >
	UNTIL DROP
	10 < verify
;

: split ( 'dir n -- )
	check-ten
	LITE-VERSION NOT IF
		check-pass
		check-neg
	ENDIF
	alloc-path !
	val split-val !
	val SWAP BEGIN
		step
		SWAP 1- DUP 0= IF
			TRUE
		ELSE
			empty? verify
			SWAP FALSE
		ENDIF
	UNTIL DROP
	from here move
	empty? IF
		E5 here = verify
		capture
	ENDIF
	bump
	here E5 = verify
	empty? verify
	DUP to-right SWAP to-left
	split-val @
	MY-VERSION IF
		DUP 1 > verify
	ENDIF
	1+ 2/ split-val @ OVER - ROT ROT
	0 alloc-val !
	move-part E5 to
	DUP 0> IF
		move-part
	ELSE
		2DROP
	ENDIF
	alloc-val @ 0> IF
		alloc-all
		LITE-VERSION NOT IF
			set-pass
		ENDIF
	ELSE
		alloc-path @ 0= verify
		check-empty-pass
		neg-exists? NOT verify
	ENDIF
	LITE-VERSION NOT IF
		clear-neg
	ENDIF
	add-move
;

: split-nw-0 ( -- ) ['] nw 0 split ;
: split-sw-0 ( -- ) ['] sw 0 split ;
: split-ne-0 ( -- ) ['] ne 0 split ;
: split-se-0 ( -- ) ['] se 0 split ;
: split-w-0  ( -- ) ['] w  0 split ;
: split-e-0  ( -- ) ['] e  0 split ;

: split-nw-1 ( -- ) ['] nw 1 split ;
: split-sw-1 ( -- ) ['] sw 1 split ;
: split-ne-1 ( -- ) ['] ne 1 split ;
: split-se-1 ( -- ) ['] se 1 split ;
: split-w-1  ( -- ) ['] w  1 split ;
: split-e-1  ( -- ) ['] e  1 split ;
