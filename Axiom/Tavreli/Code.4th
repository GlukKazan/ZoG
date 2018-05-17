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

DEFER	PRE
DEFER	PKE
DEFER	PBE
DEFER	PQE
DEFER	PHE
DEFER	RE
DEFER	KE
DEFER	BE
DEFER	QE

: is-enemy-piece? ( -- ? )
	empty? IF
		FALSE
	ELSE
		piece-type PRE = 
		piece-type PKE = OR
		piece-type PBE = OR
		piece-type PQE = OR
		piece-type PHE = OR
		piece-type RE  = OR
		piece-type KE  = OR
		piece-type BE  = OR
		piece-type QE  = OR
	ENDIF
;

: calc-enemies ( -- n )
	here 0
	BEGIN
		['] down EXECUTE is-enemy-piece? AND IF
			1+
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL SWAP to
;

VARIABLE temp-pos

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

: pawn-promote-at ( pos -- )
	here promotion-zone? DUP piece-type-at KI < AND IF
		DUP piece-type-at PR = IF ROOK   change-type ENDIF
		DUP piece-type-at PK = IF KNIGHT change-type ENDIF
		DUP piece-type-at PB = IF BISHOP change-type ENDIF
		DUP piece-type-at PQ = IF QUEEN  change-type ENDIF
		DUP piece-type-at PH = IF HELGI  change-type ENDIF
	ENDIF DROP
;

: pawn-i-promote ( -- )
	from pawn-promote-at
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

VARIABLE stack-size
VARIABLE from-pos
VARIABLE to-pos
VARIABLE top-pos
VARIABLE target-pos

: to-down-at ( pos -- pos )
	here SWAP to
	['] down EXECUTE DROP 
        here SWAP to
;

: move-stack ( -- )
	from from-pos !
	here top-pos  !
	here to-pos   !
	stack-size    @
	BEGIN
		DUP 0> IF
			from-pos @ to-down-at DUP from-pos !
			to-pos   @ to-down-at DUP to-pos   !
			move
			1- FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	to-pos @ target-pos !
	from to-pos !
	BEGIN
		from-pos @ to-down-at from-pos !
		from-pos @ empty-at? IF
			TRUE
		ELSE
			from-pos @ to-pos @ move
			here to-pos @ to
			from-pos @ pawn-promote-at to
			to-pos @ to-down-at to-pos !
			FALSE
		ENDIF
	UNTIL
;

: capture-pawn ( -- )
	target-pos @ to-down-at target-pos !
	here target-pos @ move
	( TODO: promote )

;

: push-stack ( -- )
	top-pos @ to-pos !
	BEGIN
		top-pos @ empty-at? IF
			TRUE
		ELSE
			target-pos @ to-down-at target-pos !
			top-pos    @ target-pos @ move
			top-pos    @ to-down-at top-pos    !
			( TODO: promote )

			FALSE
		ENDIF
	UNTIL
	to-pos @ empty-at? NOT IF
		from piece-type-at to-pos @ create-piece-type-at
		( TODO: Use promoted piece-type )

	ENDIF
;

: empty-or-friend? ( -- )
	friend? IF
		piece-type KI =
		piece-type KI 1+ = OR NOT
	ELSE
		empty?
	ENDIF
;

: not-friend-king? ( -- )
	friend? IF
		piece-type KI =
		piece-type KI 1+ = OR NOT
	ELSE
		TRUE
	ENDIF
;

: pawn-shift ( -- )
	calc-enemies stack-size !
	n empty-or-friend? verify
	from here move
	pawn-i-promote
	move-stack
	push-stack
	clear-mark
	add-move
;

: pawn-jump ( -- )
	n empty? verify
	here temp-pos !
	n empty-or-friend? verify
	from here move
	pawn-i-promote
	clear-mark
	MARK temp-pos @ create-piece-type-at
	add-move
;

: pawn-step ( 'dir -- )
	calc-enemies stack-size !
	EXECUTE verify
	enemy? verify
	from here move
	pawn-i-promote
	move-stack
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
	calc-enemies stack-size !
	EXECUTE verify
	not-friend-king? verify
	from here move
	KI 1+ change-type
	move-stack
	piece-type MARK = NOT IF
		clear-mark
	ENDIF
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
	here temp-pos !
	w w temp-pos @ here move
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
	here temp-pos !
	e e e temp-pos @ here move
	RI 1+ change-type
	clear-mark
	add-move
;

: step ( 'dir -- )
	calc-enemies stack-size !
	EXECUTE verify
	not-friend-king? verify
	from here move
	move-stack
	piece-type MARK = NOT IF
		clear-mark
	ENDIF
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
	calc-enemies stack-size !
	EXECUTE verify
	EXECUTE verify
	not-friend-king? verify
	from here move
	move-stack
	piece-type MARK = NOT IF
		clear-mark
	ENDIF
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
	not-friend-king? verify
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
	calc-enemies stack-size !
	BEGIN
		DUP EXECUTE my-empty? AND IF
			from here move
			move-stack
			empty? IF clear-mark ENDIF
			add-move
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	not-friend-king? verify
	from here move
	move-stack
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
