6 3 * 		CONSTANT	TOTAL

TOTAL []	positions[]
TOTAL []	trace[]
VARIABLE	trace-count
VARIABLE	stone-count
VARIABLE	target-pos

DEFER		MARK
DEFER		TRAP

: get-value ( -- value )
	empty? here from = OR IF
		0
	ELSE
		piece piece-value
	ENDIF
;

: get-value-at ( pos -- value )
	DUP empty-at? IF
		DROP 0
	ELSE
		piece-at piece-value
	ENDIF
;

: get-player ( -- )
	here e2 < IF
		Second
	ELSE
		First
	ENDIF
;

: check-zero ( -- )
	current-player First = IF
		a1 empty-at? NOT verify
	ELSE
		h1 empty-at? NOT verify
	ENDIF
;

: clear-zero ( player -- )
	First = IF
		a1 capture-at
	ELSE
		h1 capture-at
	ENDIF
;

: build-trace ( -- )
	0 trace-count !
	0 BEGIN
		DUP TOTAL >= IF
			DROP 0
		ENDIF
		DUP trace-count @ < IF
			DUP trace[] @
		ELSE
			trace-count ++
			get-value
		ENDIF
		1+ 
		empty? NOT IF
			piece-type MARK < IF NEGATE ENDIF
		ENDIF
		OVER trace[] !
		here OVER positions[] !
		stone-count --
		stone-count @ 0= IF
			TRUE
		ELSE
			1+ next verify
			FALSE
		ENDIF
	UNTIL 
	trace-count @ 0> verify
	here target-pos !
	get-value 
	0> IF
		piece-type MARK < IF
			TRAP a3 create-piece-type-at
			next-player clear-zero
		ENDIF
		DUP trace[] @ DUP 0> IF NEGATE ENDIF OVER trace[] !
	ELSE
		current-player clear-zero
	ENDIF
	DROP
;

: use-trace ( -- )
	0 BEGIN
		next verify
		DUP trace[] @
		DUP 0 <> IF
			DUP 0> IF
				get-player
			ELSE
				target-pos @ here = IF
					current-player
				ELSE
					next-player
				ENDIF
			ENDIF
			SWAP MARK + create-player-piece-type
		ELSE
			DROP
			empty? NOT IF capture ENDIF
		ENDIF
		1+ DUP trace-count @ >=
	UNTIL DROP
;

: zero-p ( -- )
	check-zero
	piece piece-value stone-count !
	next verify
	from here move
	build-trace
	from to use-trace
	add-move
;

: zero-q ( -- )
	check-zero
	piece piece-value
	a3 empty-at? NOT IF 1- ENDIF
	stone-count !
	next verify
	from here move
	build-trace
	from to use-trace
	a3 empty-at? NOT IF 
		a3 capture-at 
		from to
		get-player MARK 1+ create-player-piece-type
	ENDIF
	add-move
;
