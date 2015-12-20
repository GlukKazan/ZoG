VARIABLE	fox-cnt
VARIABLE	is-fox?
VARIABLE	to-pos

DEFER		ZERO
DEFER		FOX

: check-fox? ( -- ? )
	here to-pos @ = IF
		TRUE
	ELSE
		here from = empty? OR IF
			FALSE
		ELSE
			piece-type FOX =
		ENDIF
	ENDIF
;

: calc-dir ( 'dir -- )
	BEGIN
		DUP EXECUTE IF
			check-fox? IF
				fox-cnt ++
				transparent? IF
					FALSE
				ELSE
					TRUE
				ENDIF
			ELSE
				FALSE
			ENDIF
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: calc-foxes ( -- n )
	0 fox-cnt !
	here ['] n  calc-dir to
	here ['] s  calc-dir to
	here ['] w  calc-dir to
	here ['] e  calc-dir to
	here ['] nw calc-dir to
	here ['] sw calc-dir to
	here ['] ne calc-dir to
	here ['] se calc-dir to
	fox-cnt @
;

: recalc-all ( -- )
	SZ SZ * BEGIN
		1-
		DUP player-at You = OVER piece-type-at FOX < AND IF
			DUP to
			calc-foxes ZERO +
			DUP piece-type = IF
				DROP
			ELSE
				You SWAP create-player-piece-type
			ENDIF
		ENDIF
		DUP 0=
	UNTIL DROP
;

: setup-drop ( -- )
	empty? verify
	drop
	add-move
;

: normal-drop ( -- )
	-1 to-pos !
	friend? NOT verify
	enemy? is-fox? !
	drop
	is-fox? @ IF
		FOX
	ELSE
		calc-foxes
		ZERO +
	ENDIF
	create-piece-type
	add-move
;

: move-fox ( 'dir -- )
	EXECUTE verify
	empty? verify
	here to-pos !
	from here move
	recalc-all
	add-move
;

: move-n ( -- ) ['] n move-fox ;
: move-s ( -- ) ['] s move-fox ;
: move-w ( -- ) ['] w move-fox ;
: move-e ( -- ) ['] e move-fox ;

