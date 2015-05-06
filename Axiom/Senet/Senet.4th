4	CONSTANT	ROWS
11	CONSTANT	COLS

VARIABLE		piece-counter
DEFER			MARK
DEFER			ONE

{board
	ROWS 	COLS	{grid}
board}

{directions
	( next )
	{link}		next a4 b4
	{link}		next b4 c4
	{link}		next c4 d4
	{link}		next d4 e4
	{link}		next e4 f4
	{link}		next f4 g4
	{link}		next g4 h4
	{link}		next h4 i4
	{link}		next i4 j4
	{link}		next j4 j3
	{link}		next j3 i3
	{link}		next i3 h3
	{link}		next h3 g3
	{link}		next g3 f3
	{link}		next f3 e3
	{link}		next e3 d3
	{link}		next d3 c3
	{link}		next c3 b3
	{link}		next b3 a3
	{link}		next a3 a2
	{link}		next a2 b2
	{link}		next b2 c2
	{link}		next c2 d2
	{link}		next d2 e2
	{link}		next e2 f2
	{link}		next h2 i2
	{link}		next i2 j2

	( priv )
	{link}		priv f2 g2
	{link}		priv g2 h2
	{link}		priv h2 i2
	{link}		priv i2 j2
	{link}		priv j2 k2

	( prev )
	{link}		prev b4 a4
	{link}		prev c4 b4
	{link}		prev d4 c4
	{link}		prev e4 d4
	{link}		prev f4 e4
	{link}		prev g4 f4
	{link}		prev h4 g4
	{link}		prev i4 h4
	{link}		prev j4 i4
	{link}		prev j3 j4
	{link}		prev i3 j3
	{link}		prev h3 i3
	{link}		prev g3 h3
	{link}		prev f3 g3
	{link}		prev e3 f3
	{link}		prev d3 e3
	{link}		prev c3 d3
	{link}		prev b3 c3
	{link}		prev a3 b3
	{link}		prev a2 a3
	{link}		prev b2 a2
	{link}		prev c2 b2
	{link}		prev d2 c2
	{link}		prev e2 d2
	{link}		prev f2 e2
	{link}		prev i2 h2
	{link}		prev j2 i2

	( cnt )
	{link}		cnt a1 b1
	{link}		cnt b1 c1
	{link}		cnt c1 d1
	{link}		cnt d1 e1
directions}

{players
	{player}	White	 {random}
	{player}	Black	 {random}
	{player}	?White	 {random}
	{player}	?Black	 {random}
	{player}	?Counter {random}
players}

{turn-order
	{turn}	?Black	 {of-type} dice-type
	{turn}	?Black	 {of-type} dice-type
	{turn}	?Black	 {of-type} dice-type
	{turn}	?Black	 {of-type} dice-type
	{turn}	Black
	{turn}	?White	 {of-type} dice-type
	{turn}	?White	 {of-type} dice-type
	{turn}	?White	 {of-type} dice-type
	{turn}	?White	 {of-type} dice-type
	{turn}	White
	{turn}	?Counter {of-type} counter-type
turn-order}

: OnNewGame ( -- )
	RANDOMIZE
;

: calc-pieces ( player -- n )
	0 piece-counter !
	k2 BEGIN
		1-
		OVER OVER player-at = IF
			piece-counter ++
		ENDIF
		DUP 0=
	UNTIL 2DROP
	piece-counter @
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	White calc-pieces 0= IF
		current-player Black = IF
			DROP
			#LossScore
		ENDIF
		current-player White = IF
			DROP
			#WinScore
		ENDIF
	ENDIF
	Black calc-pieces 0= IF
		current-player White = IF
			DROP
			#LossScore
		ENDIF
		current-player Black = IF
			DROP
			#WinScore
		ENDIF
	ENDIF
;

: check-finis ( -- )
	k2 here = IF
		k2 capture-at
	ENDIF
;

: check-neighbor ( 'dir -- ? )
	here SWAP
	EXECUTE IF
		enemy?
	ELSE
		FALSE
	ENDIF
	SWAP to
;

: my-piece-value ( piece-type -- n )
	ONE = IF 1 ELSE 0 ENDIF
;

: check-dices ( n -- )
	k1 enemy-at? IF
		DROP 0
	ENDIF
	g1 piece-type-at my-piece-value
	h1 piece-type-at my-piece-value +
	i1 piece-type-at my-piece-value +
	j1 piece-type-at my-piece-value +
	DUP 0= IF
		DROP 5
	ENDIF
	= verify
;

: set-repeat ( -- )
	k1 empty-at? IF
		MARK k1 create-piece-type-at
	ENDIF
;

: clear-repeat ( -- )
	k1 empty-at? NOT IF
		k1 capture-at
	ENDIF
;

: check-repeat ( -- )
	g1 piece-type-at my-piece-value
	h1 piece-type-at my-piece-value +
	i1 piece-type-at my-piece-value +
	j1 piece-type-at my-piece-value +
	DUP 2 = SWAP 3 = OR IF
		clear-repeat
	ELSE
		set-repeat
	ENDIF
;

: drop-dice ( -- )
	here g1 >=  verify
	here k1 <   verify
	friend? NOT verify
	drop
	add-move
;

: drop-mark ( -- )
	here f1 = verify
	drop
	a1 to
	BEGIN
		empty? IF
			MARK create-piece-type
			TRUE
		ELSE
			capture
			cnt NOT
		ENDIF
	UNTIL
	add-move
;

{moves dice-drops
	{move} drop-dice {move-type} dice-type
moves}

{moves counter-drops
	{move} drop-mark {move-type} counter-type
moves}
