DEFER		mark
ALL []		pos[]
ALL []		ix[]
VARIABLE	curr-size
VARIABLE	collision-size
VARIABLE	curr-ix

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
	down verify
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

: find-mark ( -- ix )
	0 BEGIN
		DUP piece-type-at mark = IF
			TRUE
		ELSE
			1+ ALL >=
		ENDIF
	UNTIL
	DUP ALL < verify
	get-ix
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
	FALSE curr-size @ BEGIN
		1-
		DUP ix[] @ curr-size @ ix[] @ = IF
			2DROP TRUE 0
		ENDIF
		DUP 0=
	UNTIL DROP
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
		1+ ALL >=
	UNTIL DROP
;

: try-ix ( -- )
	0 BEGIN
		DUP get-ix curr-size @ ix[] @ = IF
			my-empty-at? NOT OVER piece-type-at mark > AND IF
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

: find-collision ( -- )
	0 collision-size !
	0 curr-size !
	find-mark 0 ix[] !
	try-ix
;

: clear-mark ( -- )
	here get-ix curr-ix !
	0 BEGIN
		DUP piece-type-at mark = OVER get-ix curr-ix @ <> AND IF
			DUP capture-at
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
	from to	down verify
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
	pass-flag empty-at? IF
		mark pass-flag create-piece-type-at
	ELSE
		pass-flag capture-at
	ENDIF
	clear-mark
;

: check-empty ( -- )
	down   verify
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
		down verify
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
	down verify
	FALSE BEGIN
		my-empty? IF
			TRUE
		ELSE
			piece-type get-curr-type = IF
				capture
				DROP TRUE
				TRUE
			ELSE
				up NOT
			ENDIF
		ENDIF
	UNTIL
;

: clear-all ( -- )
	from to	down verify
	BEGIN
		empty? IF
			TRUE
		ELSE
			capture
			up NOT
		ENDIF
	UNTIL
;

: drop-piece ( -- )
	here ALL < verify
	pass-flag enemy-at? NOT verify
	drop
	change-mark
	find-half verify
	clear-all
	from to
	down verify
	bg   verify
	get-curr-type 9 + create-piece-type
(	TODO: Resolve collisions )
	change-curr-type
	add-move
;
