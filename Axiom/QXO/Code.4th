DEFER		mark
TOTAL []	pos[]
TOTAL []	ix[]
VARIABLE	curr-size
VARIABLE	collision-size
VARIABLE	curr-ix
VARIABLE	curr-pos

: my-empty? ( -- ? )
	empty? IF
		TRUE
	ELSE
		piece-type mark =
	ENDIF
;

: my-empty-at? ( pos -- ? )
	DUP empty-at? IF
		DROP TRUE
	ELSE
		piece-type-at mark =
	ENDIF
;

: common-dir ( 'dir -- ? )
	down DROP
	EXECUTE verify
	FALSE BEGIN
		my-empty? IF
			DROP TRUE
			TRUE
		ELSE
			up NOT
		ENDIF
	UNTIL
;

: n  ( -- ? ) ['] n-internal common-dir ;
: s  ( -- ? ) ['] s-internal common-dir ;
: w  ( -- ? ) ['] w-internal common-dir ;
: e  ( -- ? ) ['] e-internal common-dir ;

: nw ( -- ? ) ['] nw-internal common-dir ;
: sw ( -- ? ) ['] sw-internal common-dir ;
: ne ( -- ? ) ['] ne-internal common-dir ;
: se ( -- ? ) ['] se-internal common-dir ;

: get-x ( pos -- x )
	DIM MOD
;

: get-y ( pos -- y )
	DIM /
;

: get-ix ( pos - ix )
	DUP ALL < IF
		DUP  get-y get-y DIM *
		SWAP get-x get-y +
	ELSE
		ALL  -
		DUP  get-y DIM *
		SWAP get-x +
	ENDIF
;

: pieces-equals-at? ( pos -- ? )
	curr-size @ 0> verify
	DUP curr-size @ 1- pos[] @ = OVER my-empty-at? OR IF
		DROP FALSE
	ELSE
		piece-type-at
		curr-size @ 1- pos[] @
		piece-type-at =
	ENDIF
;

: is-looped? ( -- ? )
	curr-size @ 0> verify
	curr-size @ ix[] @
	0 ix[] @ =
;

: find-pair ( -- ? )
	FALSE 0 BEGIN
		DUP pieces-equals-at? IF
			DUP get-ix curr-size @ ix[] !
			is-looped? IF
				curr-size @ collision-size !
				DROP ALL
			ELSE
				2DROP TRUE ALL
			ENDIF
		ENDIF
		1+ DUP ALL >=
	UNTIL DROP
;

: try-ix ( -- )
	0 BEGIN
		DUP get-ix curr-size @ ix[] @ = IF
			DUP my-empty-at? NOT OVER piece-type-at mark > AND IF
				DUP curr-size @ pos[] !
				curr-size ++
				find-pair IF
					RECURSE
				ENDIF
				curr-size --
			ENDIF
		ENDIF
		1+ ALL >=
	UNTIL DROP
;

: check-mark ( pos -- )
	DUP empty-at? NOT OVER piece-type-at mark = AND IF
		curr-size @ 0< verify
		get-ix 0 ix[] !
		0 curr-size !
	ELSE
		DROP
	ENDIF
;

: find-mark ( -- )
	-1 curr-size !
	c7 check-mark c4 check-mark c1 check-mark
	f7 check-mark f4 check-mark f1 check-mark
	i7 check-mark i4 check-mark i1 check-mark
	curr-size @ 0= verify
;

: find-collision ( -- )
	0 collision-size !
	find-mark
	try-ix
	collision-size @ 1 > verify
;

: is-not-big? ( pos -- ? )
	here SWAP to
	down DROP bg verify
	empty? SWAP to
;

: clear-mark ( -- )
	0 BEGIN
		DUP piece-type-at mark = IF
			DUP is-not-big? IF
				DUP capture-at
			ENDIF
		ENDIF
		1+ DUP ALL >=
	UNTIL DROP
;

: get-curr-type ( -- piece-type )
	curr-type empty-at? IF
		mark 1+
	ELSE
		curr-type piece-type-at
	ENDIF
;

: change-curr-type ( -- )
	next-player
	get-curr-type 1+
	curr-type create-player-piece-type-at
;

: find-empty ( -- ? )
	from to	down DROP
	FALSE BEGIN
		my-empty? IF
			DROP TRUE
			TRUE
		ELSE
			piece-type get-curr-type = IF
				TRUE
			ELSE
				up NOT
			ENDIF
		ENDIF
	UNTIL
;

: change-mark ( -- )
	pass-flag my-empty-at? IF
		get-curr-type pass-flag create-piece-type-at
	ELSE
		pass-flag capture-at
	ENDIF
;

: check-empty ( -- )
	down   DROP
	bg     verify
	empty? verify
	from to
;

: drop-half ( -- )
	check-empty
	here ALL < verify
	pass-flag enemy-at? NOT verify
	drop
	change-mark
	pass-flag empty-at? NOT IF
		clear-mark
		down DROP
		mr   verify
		mark create-piece-type
		change-curr-type
	ENDIF
	find-empty verify
	get-curr-type create-piece-type
	here from <> IF
		from to
		empty? NOT IF
			player piece-type create-player-piece-type
		ENDIF
	ENDIF
	add-move
;

: find-half ( -- ? )
	down DROP
	FALSE BEGIN
		my-empty? IF
			TRUE
		ELSE
			piece-type get-curr-type = IF
				DROP TRUE
				TRUE
			ELSE
				up NOT
			ENDIF
		ENDIF
	UNTIL
;

: not-in-position? ( pos -- )
	TRUE SWAP 0 BEGIN
		DUP curr-size @ < IF
			DUP pos[] @ OVER = IF
				2DROP DROP FALSE
				0 0 TRUE
			ELSE
				1+ FALSE
			ENDIF
		ELSE
			TRUE
		ENDIF
	UNTIL 2DROP
;

: add-position ( -- )
	0 BEGIN
		DUP here <> OVER empty-at? NOT AND IF
			DUP piece-type-at piece-type = OVER not-in-position? AND curr-size @ ALL < AND IF
				DUP curr-size @ pos[] !
				curr-size ++
			ENDIF
		ENDIF
		1+ DUP ALL >=
	UNTIL DROP
;


: clear-all ( -- )
	here curr-pos !
	down DROP
	BEGIN
		empty? IF
			TRUE
		ELSE
			here curr-pos @ <> piece-type mark > AND IF
				add-position
			ENDIF
			capture
			up NOT
		ENDIF
	UNTIL
;

: untangle ( -- )
	0 BEGIN
		DUP curr-size @ < IF
			DUP pos[] @
			to player piece-type clear-all
			down DROP
			bg   verify
			DIM + create-player-piece-type
			1+ FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: mark-all ( -- )
	here curr-pos !
	down DROP
	mr   verify mark create-piece-type
	down DROP
	BEGIN
		empty? NOT here curr-pos @ <> AND piece-type mark > AND IF
			add-position
		ENDIF
		mark create-piece-type
		up NOT
	UNTIL
;

: drop-piece ( -- )
	here ALL < verify
	pass-flag enemy-at? NOT verify
	drop
	change-mark
	find-half verify
	0 curr-size !
	from to	mark-all
	from to	down DROP
	bg verify get-curr-type DIM + create-piece-type
	change-curr-type
	untangle
	add-move
;

: in-collision? ( -- ? )
	FALSE 0 BEGIN
		DUP pos[] @ here = IF
			2DROP TRUE
			TRUE
		ELSE
			1+ DUP collision-size @ >=
		ENDIF
	UNTIL DROP
;
