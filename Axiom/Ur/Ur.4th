{board
	5 17 		{grid}
	{variable}	WhitePieces
	{variable}	BlackPieces
board}

{directions
	( Afree )
	{link}		Afree h5 i5
	{link}		Afree i5 j5
	{link}		Afree j5 k5
	{link}		Afree k5 l5
	{link}		Afree l5 m5
	{link}		Afree m5 n5
	{link}		Afree n5 o5

	( Bfree )
	{link}		Bfree h5 i1
	{link}		Bfree i1 j1
	{link}		Bfree j1 k1
	{link}		Bfree k1 l1
	{link}		Bfree l1 m1
	{link}		Bfree m1 n1
	{link}		Bfree n1 o1

	( Anext )
	{link}		Anext i1 l2
	{link}		Anext j1 l2
	{link}		Anext k1 l2
	{link}		Anext l1 l2
	{link}		Anext m1 l2
	{link}		Anext n1 l2
	{link}		Anext o1 l2
	{link}		Anext l2 k2
	{link}		Anext k2 j2
	{link}		Anext j2 i2
	{link}		Anext i2 i3
	{link}		Anext i3 j3
	{link}		Anext j3 k3
	{link}		Anext k3 l3
	{link}		Anext l3 m3
	{link}		Anext m3 n3
	{link}		Anext n3 o3
	{link}		Anext o3 o2
	{link}		Anext o2 p2
	{link}		Anext p2 p3
	{link}		Anext p3 p4
	{link}		Anext p4 o4
	{link}		Anext o4 o3

	( Bnext )
	{link}		Bnext i5 l4
	{link}		Bnext j5 l4
	{link}		Bnext k5 l4
	{link}		Bnext l5 l4
	{link}		Bnext m5 l4
	{link}		Bnext n5 l4
	{link}		Bnext o5 l4
	{link}		Bnext l4 k4
	{link}		Bnext k4 j4
	{link}		Bnext j4 i4
	{link}		Bnext i4 i3
	{link}		Bnext i3 j3
	{link}		Bnext j3 k3
	{link}		Bnext k3 l3
	{link}		Bnext l3 m3
	{link}		Bnext m3 n3
	{link}		Bnext n3 o3
	{link}		Bnext o3 o4
	{link}		Bnext o4 p4
	{link}		Bnext p4 p3
	{link}		Bnext p3 p2
	{link}		Bnext p2 o2
	{link}		Bnext o2 o3

	( Cnext )
	{link}		Cnext p3 p4
	{link}		Cnext p4 o4
	{link}		Cnext o4 o3
	{link}		Cnext o3 n3
	{link}		Cnext n3 m3
	{link}		Cnext m3 l3
	{link}		Cnext l3 k3
	{link}		Cnext k3 j3
	{link}		Cnext j3 i3
	{link}		Cnext i3 h3

	( Dnext )
	{link}		Dnext p3 p2
	{link}		Dnext p2 o2
	{link}		Dnext o2 o3
	{link}		Dnext o3 n3
	{link}		Dnext n3 m3
	{link}		Dnext m3 l3
	{link}		Dnext l3 k3
	{link}		Dnext k3 j3
	{link}		Dnext j3 i3
	{link}		Dnext i3 h3

	( Top )
	{link}		Top j2 a2
	{link}		Top a2 a3
	{link}		Top a3 a4

	{link}		Top j4 b2
	{link}		Top b2 b3
	{link}		Top b3 b4

	{link}		Top l2 c2
	{link}		Top c2 c3
	{link}		Top c3 c4

	{link}		Top l4 d2
	{link}		Top d2 d3
	{link}		Top d3 d4

	{link}		Top o3 e2
	{link}		Top e2 e3
	{link}		Top e3 e4

	{link}		Top k3 f2
	{link}		Top f2 f3
	{link}		Top f3 f4

	{link}		Top n3 g2
	{link}		Top g2 g3
	{link}		Top g3 g4

directions}

{players
	{player}	White   {random}
	{player}	Black   {random}
	{player}	?Dice	{random}
players}

{symmetries 
	Black		{symmetry} Afree Bfree
	Black		{symmetry} Anext Bnext
	Black		{symmetry} Cnext Dnext
symmetries}

{turn-order
	{turn}	White
	{turn}	?Dice {of-type} clear-type
	{turn}	?Dice
	{turn}	?Dice
	{turn}	?Dice
	{turn}	Black
	{turn}	?Dice {of-type} clear-type
	{turn}	?Dice
	{turn}	?Dice
	{turn}	?Dice
turn-order}

VARIABLE		isPromouted
VARIABLE		isCaptured

: WhitePieces++ WhitePieces ++ ;
: BlackPieces++ BlackPieces ++ ;

: is-rosette? ( -- ? )
	here i2 =
	here i4 = OR
	here l3 = OR
	here o2 = OR
	here o4 = OR
;

: move-granted? ( -- ? )
	empty?
	current-piece-type
	isPromouted @ IF
		1+
	ENDIF
	piece-type = enemy? AND OR
;

: enemy-player ( -- player )
	current-player
	White = IF
		Black
	ELSE
		White
	ENDIF
;

: move-to-reserve ( -- )
	h5 to
	BEGIN
		Afree IF
			empty? IF
				enemy-player 
				q1 piece-type-at 1+
				create-player-piece-type
				TRUE
			ELSE
				FALSE
			ENDIF
		ELSE
			TRUE
		ENDIF
	UNTIL
;

: count-dices ( -- n )
	q2 piece-at piece-value
	q3 piece-at piece-value +
	q4 piece-at piece-value +
	DUP 0= IF
		DROP
		4
	ENDIF
;

: common-move ( 'dir n -- )
	q5 enemy-at? NOT IF
		FALSE isPromouted !
		FALSE isCaptured !
		SWAP
		BEGIN
			current-player White
			= IF
				here p2
				= IF TRUE isPromouted ! ENDIF
			ELSE
				here p4
				= IF TRUE isPromouted ! ENDIF
			ENDIF
			DUP EXECUTE DROP SWAP
			1-  DUP
			0=  IF
				DROP
				TRUE
			ELSE
				SWAP
				FALSE
			ENDIF
		UNTIL
		move-granted? IF
			enemy? IF 
				TRUE isCaptured !
			ENDIF
			from
			here
			move
			here h3
			= IF
				current-player White = IF
					COMPILE WhitePieces++
				ELSE
					COMPILE BlackPieces++
				ENDIF
				capture
			ENDIF
				isPromouted @ IF
				current-piece-type 1+ change-type
			ENDIF
			is-rosette? IF
				q1 piece-type-at q5 create-piece-type-at
			ELSE  
				q5 capture-at
			ENDIF
			isCaptured @ IF
				move-to-reserve
			ENDIF
			add-move
		ENDIF
	ENDIF
;

: drop-dices ( -- )
	q2 here = q3 here = OR q4 here = OR empty? AND IF
		drop
		add-move
	ENDIF
;

: clear-dices ( -- )
	q1 here = verify
	q2 not-empty-at? q3 not-empty-at? q4 not-empty-at?
	AND AND IF
		drop
		q2 capture-at
		q3 capture-at
		q4 capture-at
		add-move
	ENDIF
;

: pass-move ( -- )
	q5 capture-at
	repetition-reset
	Pass
	add-move
;

: i-move ( -- ) ['] Anext count-dices common-move ;
: p-move ( -- ) ['] Cnext count-dices common-move ;

: OnIsGameOver ( -- gameResult )
	repetition-reset
	#UnknownScore
	current-player White = IF
		BlackPieces @
		7 - 0=  IF
			DROP
			#LossScore
		ENDIF
	ENDIF
	current-player Black = IF
		WhitePieces @
		7 - 0=  IF
			DROP
			#LossScore
		ENDIF
	ENDIF
;

{moves i-moves
	{move} i-move {move-type} normal-type
	{move} pass-move {move-type} pass-type
moves}

{moves p-moves
	{move} p-move {move-type} normal-type
	{move} pass-move {move-type} pass-type
moves}

{moves drops
	{move} drop-dices {move-type} normal-type
	{move} pass-move {move-type} pass-type
moves}

{moves clears
	{move} clear-dices {move-type} clear-type
moves}

{move-priorities
	{move-priority} normal-type
	{move-priority} pass-type
move-priorities}

{pieces
	{piece}		lock	{moves} clears
	{piece}		init	{moves} i-moves
	{piece}		prom	{moves} p-moves
	{piece}		wdice	{drops} drops 
					1 {value}
	{piece}		bdice	{drops} drops 
					0 {value}
pieces}

{board-setup
	{setup}	?Dice wdice q4
	{setup}	?Dice bdice q3
	{setup}	?Dice bdice q2
	{setup}	?Dice lock  q1

	{setup}	Black init i5
	{setup}	Black init j5
	{setup}	Black init k5
	{setup}	Black init l5
	{setup}	Black init m5
	{setup}	Black init n5
	{setup}	Black init o5

	{setup}	White init i1
	{setup}	White init j1
	{setup}	White init k1
	{setup}	White init l1
	{setup}	White init m1
	{setup}	White init n1
	{setup}	White init o1
board-setup}
