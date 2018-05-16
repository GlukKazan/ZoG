DEFER	PI
DEFER	RI
DEFER	KI
DEFER	PR
DEFER	PK
DEFER	PB
DEFER	PQ
DEFER	PH

DEFER	ROOK
DEFER	KNIGHT
DEFER	BISHOP
DEFER	QUEEN
DEFER	HELGI
DEFER	MARK

VARIABLE from-pos

: clear-mark ( -- )
	SZ DUP *
	BEGIN
		DUP 0> IF
			1- DUP piece-type-at MARK = IF
				DUP capture-at
			ENDIF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: my-empty? ( -- ? )
	empty? IF
		TRUE
	ELSE
		piece-type MARK =
	ENDIF
;

: promotion-zone? ( pos -- ? )
	current-player Red = IF
		SZ <
	ELSE
		SZ DUP 1- * >=
	ENDIF
;

: pawn-promote ( -- )
	here promotion-zone? IF
		from piece-type-at PR = IF ROOK   change-type ENDIF
		from piece-type-at PK = IF KNIGHT change-type ENDIF
		from piece-type-at PB = IF BISHOP change-type ENDIF
		from piece-type-at PQ = IF QUEEN  change-type ENDIF
		from piece-type-at PH = IF HELGI  change-type ENDIF
	ENDIF
	from piece-type-at PI = IF
		from SZ MOD
		DUP DUP 0 = SWAP 7 = OR IF
			DROP PR
		ELSE
			DUP DUP 1 = SWAP 6 = OR IF
				DROP PK
			ELSE
				DUP DUP 2 = SWAP 5 = OR IF
					DROP PB
				ELSE
					3 = IF PQ ELSE PH ENDIF
				ENDIF
			ENDIF
		ENDIF
		change-type
	ENDIF
;

: pawn-shift ( -- )
	n empty? verify
	from here move
	pawn-promote
	clear-mark
	add-move
;

: pawn-jump ( -- )
	n empty? verify
	here from-pos !
	n empty? verify
	from here move
	pawn-promote
	clear-mark
	MARK from-pos @ create-piece-type-at
	add-move
;

: pawn-step ( 'dir -- )
	EXECUTE verify
	enemy? verify
	from here move
	pawn-promote
	piece-type MARK = IF
		s capture
	ELSE
		clear-mark
	ENDIF
	add-move
;

: pawn-nw-step ( -- ) ['] nw pawn-step ;
: pawn-ne-step ( -- ) ['] ne pawn-step ;

: king-step ( 'dir -- )
	EXECUTE verify
	friend? NOT verify
	from here move
	KI 1+ change-type
	clear-mark
	add-move
;

: king-n-step  ( -- ) ['] n  king-step ;
: king-e-step  ( -- ) ['] e  king-step ;
: king-w-step  ( -- ) ['] w  king-step ;
: king-s-step  ( -- ) ['] s  king-step ;
: king-nw-step ( -- ) ['] nw king-step ;
: king-ne-step ( -- ) ['] ne king-step ;
: king-sw-step ( -- ) ['] sw king-step ;
: king-se-step ( -- ) ['] se king-step ;

: O-O ( -- )
	e empty? verify
	e empty? verify
	from here move
	from piece-type-at 1+ change-type
	e friend? piece-type RI = AND verify
	here from-pos !
	w w from-pos @ here move
	RI 1+ change-type
	clear-mark
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
	clear-mark
	add-move
;

: step ( 'dir -- )
	EXECUTE verify
	friend? NOT verify
	from here move
	clear-mark
	add-move
;

: n-step  ( -- ) ['] n  step ;
: e-step  ( -- ) ['] e  step ;
: w-step  ( -- ) ['] w  step ;
: s-step  ( -- ) ['] s  step ;
: nw-step ( -- ) ['] nw step ;
: ne-step ( -- ) ['] ne step ;
: sw-step ( -- ) ['] sw step ;
: se-step ( -- ) ['] se step ;

: leap ( 'dir 'dir -- )
	EXECUTE verify
	EXECUTE verify
	friend? NOT verify
	from here move
	clear-mark
	add-move
;

: nnw-leap ( -- ) ['] nw ['] n leap ;
: nne-leap ( -- ) ['] ne ['] n leap ;
: ssw-leap ( -- ) ['] sw ['] s leap ;
: sse-leap ( -- ) ['] se ['] s leap ;
: wnw-leap ( -- ) ['] nw ['] w leap ;
: wsw-leap ( -- ) ['] sw ['] w leap ;
: ene-leap ( -- ) ['] ne ['] e leap ;
: ese-leap ( -- ) ['] se ['] e leap ;

: rook-slide ( 'dir -- )
	BEGIN
		DUP EXECUTE my-empty? AND IF
			from here move
			RI 1+ change-type
			empty? IF clear-mark ENDIF
			add-move
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	friend? NOT verify
	from here move
	RI 1+ change-type
	clear-mark
	add-move
;

: rook-n-slide  ( -- ) ['] n  rook-slide ;
: rook-e-slide  ( -- ) ['] e  rook-slide ;
: rook-w-slide  ( -- ) ['] w  rook-slide ;
: rook-s-slide  ( -- ) ['] s  rook-slide ;
: rook-nw-slide ( -- ) ['] nw rook-slide ;
: rook-se-slide ( -- ) ['] se rook-slide ;
: rook-sw-slide ( -- ) ['] sw rook-slide ;
: rook-ne-slide ( -- ) ['] ne rook-slide ;

: slide ( 'dir -- )
	BEGIN
		DUP EXECUTE my-empty? AND IF
			from here move
			add-move
			empty? IF clear-mark ENDIF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	friend? NOT verify
	from here move
	clear-mark
	add-move
;

: n-slide  ( -- ) ['] n  slide ;
: e-slide  ( -- ) ['] e  slide ;
: w-slide  ( -- ) ['] w  slide ;
: s-slide  ( -- ) ['] s  slide ;
: nw-slide ( -- ) ['] nw slide ;
: se-slide ( -- ) ['] se slide ;
: sw-slide ( -- ) ['] sw slide ;
: ne-slide ( -- ) ['] ne slide ;
