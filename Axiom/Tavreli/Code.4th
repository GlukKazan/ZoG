DEFER	PI
DEFER	RI

: pawn-promote ( -- )
	from piece-type-at PI = IF
		from SZ MOD
		DUP DUP 0 = SWAP 7 = OR IF
			DROP 1
		ELSE
			DUP DUP 1 = SWAP 6 = OR IF
				DROP 3
			ELSE
				DUP DUP 2 = SWAP 5 = OR IF
					DROP 5
				ELSE
					3 = IF
						7
					ELSE
						9
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		PI + change-type
	ENDIF
;

: pawn-shift ( -- )
	n empty? verify
	from here move
	pawn-promote
	add-move
;

: pawn-jump ( -- )
	n empty? verify
	n empty? verify
	from here move
	pawn-promote
	add-move
;

: pawn-step ( 'dir -- )
	EXECUTE verify
	enemy? verify
	from here move
	pawn-promote
	add-move
;

: pawn-nw-step ( -- ) ['] nw pawn-step ;
: pawn-ne-step ( -- ) ['] ne pawn-step ;

VARIABLE from-pos

: O-O ( -- )
	e empty? verify
	e empty? verify
	from here move
	from piece-type-at 1+ change-type
	e friend? piece-type RI = AND verify
	here from-pos !
	w w from-pos @ here move
	RI 1+ change-type
	add-move
;

: O-O-O ( -- )
	w empty? verify
	w empty? verify
	from here move
	from piece-type-at 1+ change-type
	w empty? verify
	w friend? piece-type RI = AND verify
	here from-pos !
	e e e from-pos @ here move
	RI 1+ change-type
	add-move
;
