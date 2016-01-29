DEFER		mark
TOTAL []	pos[]
VARIABLE	curr-size
VARIABLE	curr-pos
VARIABLE	collision-size

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
	CT empty-at? IF
		mark 1+
	ELSE
		CT piece-type-at
	ENDIF
;

: change-curr-type ( -- )
	next-player
	get-curr-type 1+
	CT create-player-piece-type-at
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
	PF my-empty-at? IF
		get-curr-type PF create-piece-type-at
	ELSE
		PF capture-at
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
	PF enemy-at? NOT verify
	drop
	change-mark
	PF my-empty-at? NOT IF
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
	PF enemy-at? NOT verify
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

: check-mark ( pos -- )
	DUP empty-at? NOT OVER piece-type-at mark = AND IF
		DUP is-not-big? IF to ENDIF
	ELSE
		DROP
	ENDIF
;

: find-mark ( -- )
	0 to
	0 curr-size !
	0 collision-size !
	c7 check-mark f7 check-mark i7 check-mark
	c4 check-mark f4 check-mark i4 check-mark
	c1 check-mark f1 check-mark i1 check-mark
	here 0> verify
;

: in-collision? ( -- ? )
	FALSE 0 BEGIN
		DUP curr-size @ < IF
			DUP pos[] @ here = IF
				2DROP TRUE 0
				TRUE
			ELSE
				1+ FALSE
			ENDIF
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: pair-found? ( -- ? )
	FALSE 0 BEGIN
		DUP empty-at? NOT OVER piece-type-at piece-type = AND IF
			DUP here <> IF
				DUP 0 pos[] @ = IF
					collision-size @ 0= IF
						curr-size @
						collision-size !
					ENDIF
					DROP ALL
				ELSE
					DUP to
					here curr-size @ pos[] !
					curr-size ++
					2DROP TRUE ALL
				ENDIF
			ENDIF
		ENDIF
		1+ DUP ALL >=
	UNTIL DROP
;

: not-prev? ( -- ? )
	curr-size @ 0> IF
		curr-size @ 1- pos[] @ here <>
	ELSE
		TRUE
	ENDIF
;

: try-pos ( -- )
	down DROP
	BEGIN	here
		my-empty? NOT not-prev? AND IF
			here curr-size @ pos[] !
			curr-size ++
			pair-found? curr-size @ TOTAL < AND IF
				RECURSE
				curr-size --
			ENDIF
			curr-size --
		ENDIF
		to up NOT my-empty? OR collision-size @ 0> OR
	UNTIL
;

: check-collision ( -- )
	find-mark
	try-pos
	collision-size @ 
	DUP 2 > verify
	curr-size !
	from to
	in-collision? verify
;

: select-piece ( -- )
	here ALL < verify
	PF enemy-at? NOT verify
	empty? NOT verify
	piece-type mark > verify
	check-collision
	drop
	mark PF create-piece-type-at
	0 curr-size !
	from to	mark-all
	from to player piece-type
	down DROP bg verify
	DIM + create-player-piece-type
(	untangle )
	add-move
;
