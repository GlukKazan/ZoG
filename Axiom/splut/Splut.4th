{board
	10 9 		{grid}
board}

{directions
	( north )
	{link}		north e1 e2
	{link}		north d2 d3
	{link}		north e2 e3
	{link}		north f2 f3
	{link}		north c3 c4
	{link}		north d3 d4
	{link}		north e3 e4
	{link}		north f3 f4
	{link}		north g3 g4
	{link}		north b4 b5
	{link}		north c4 c5
	{link}		north d4 d5
	{link}		north e4 e5
	{link}		north f4 f5
	{link}		north g4 g5
	{link}		north h4 h5
	{link}		north b5 b6
	{link}		north c5 c6
	{link}		north d5 d6
	{link}		north e5 e6
	{link}		north f5 f6
	{link}		north g5 g6
	{link}		north h5 h6
	{link}		north c6 c7
	{link}		north d6 d7
	{link}		north e6 e7
	{link}		north f6 f7
	{link}		north g6 g7
	{link}		north d7 d8
	{link}		north e7 e8
	{link}		north f7 f8
	{link}		north e8 e9

	( south )
	{link}		south e2 e1
	{link}		south d3 d2
	{link}		south e3 e2
	{link}		south f3 f2
	{link}		south c4 c3
	{link}		south d4 d3
	{link}		south e4 e3
	{link}		south f4 f3
	{link}		south g4 g3
	{link}		south b5 b4
	{link}		south c5 c4
	{link}		south d5 d4
	{link}		south e5 e4
	{link}		south f5 f4
	{link}		south g5 g4
	{link}		south h5 h4
	{link}		south b6 b5
	{link}		south c6 c5
	{link}		south d6 d5
	{link}		south e6 e5
	{link}		south f6 f5
	{link}		south g6 g5
	{link}		south h6 h5
	{link}		south c7 c6
	{link}		south d7 d6
	{link}		south e7 e6
	{link}		south f7 f6
	{link}		south g7 g6
	{link}		south d8 d7
	{link}		south e8 e7
	{link}		south f8 f7
	{link}		south e9 e8

	( east )
	{link}		east a5 b5
	{link}		east b6 c6
	{link}		east b5 c5
	{link}		east b4 c4
	{link}		east c7 d7
	{link}		east c6 d6
	{link}		east c5 d5
	{link}		east c4 d4
	{link}		east c3 d3
	{link}		east d8 e8
	{link}		east d7 e7
	{link}		east d6 e6
	{link}		east d5 e5
	{link}		east d4 e4
	{link}		east d3 e3
	{link}		east d2 e2
	{link}		east e8 f8
	{link}		east e7 f7
	{link}		east e6 f6
	{link}		east e5 f5
	{link}		east e4 f4
	{link}		east e3 f3
	{link}		east e2 f2
	{link}		east f7 g7
	{link}		east f6 g6
	{link}		east f5 g5
	{link}		east f4 g4
	{link}		east f3 g3
	{link}		east g6 h6
	{link}		east g5 h5
	{link}		east g4 h4
	{link}		east h5 i5

	( west )
	{link}		west b5 a5
	{link}		west c6 b6
	{link}		west c5 b5
	{link}		west c4 b4
	{link}		west d7 c7
	{link}		west d6 c6
	{link}		west d5 c5
	{link}		west d4 c4
	{link}		west d3 c3
	{link}		west e8 d8
	{link}		west e7 d7
	{link}		west e6 d6
	{link}		west e5 d5
	{link}		west e4 d4
	{link}		west e3 d3
	{link}		west e2 d2
	{link}		west f8 e8
	{link}		west f7 e7
	{link}		west f6 e6
	{link}		west f5 e5
	{link}		west f4 e4
	{link}		west f3 e3
	{link}		west f2 e2
	{link}		west g7 f7
	{link}		west g6 f6
	{link}		west g5 f5
	{link}		west g4 f4
	{link}		west g3 f3
	{link}		west h6 g6
	{link}		west h5 g5
	{link}		west h4 g4
	{link}		west i5 h5

directions}

{players
	{player}	South
	{player}	West
	{player}	North
	{player}	East
players}

DEFER CONTINUE-TYPE
DEFER LOCK
DEFER STONE
DEFER WIZARD
DEFER DWARF
DEFER TROLL

: lock-continue ( -- )
	LOCK a1 create-piece-type-at
;

: unlock-continue ( -- )
	a1 capture-at
;

: check-continue? ( -- ? )
	a1 friend-at? NOT
;

: one-step ( 'dir -- )
	check-continue? IF
		EXECUTE verify
		empty? verify
		from
		here
		move
		unlock-continue
		add-move
	ELSE
		DROP
	ENDIF
;

: step-to-north ( -- ) ['] north one-step ;
: step-to-south ( -- ) ['] south one-step ;
: step-to-east  ( -- ) ['] east  one-step ;
: step-to-west  ( -- ) ['] west  one-step ;

: is-stone? ( -- ? )
	piece-type STONE =
;

: drag ( 'dir 'opposite -- )
	check-continue? IF
		EXECUTE verify
		is-stone? verify
		piece-type
		SWAP here SWAP
		DUP EXECUTE DROP EXECUTE verify
		empty? verify
		from
		here
		move
		capture-at
		from create-piece-type-at
		unlock-continue
		add-move
	ELSE
		DROP DROP
	ENDIF
;

: drag-to-north ( -- ) ['] north ['] south drag ;
: drag-to-south ( -- ) ['] south ['] north drag ;
: drag-to-east  ( -- ) ['] east  ['] west  drag ;
: drag-to-west  ( -- ) ['] west  ['] east  drag ;

: take-stone ( 'dir -- )
	check-continue? IF
		EXECUTE verify
		is-stone? verify
		CONTINUE-TYPE partial-move-type
		from
		here
		move
		unlock-continue
		add-move
	ELSE
		DROP
	ENDIF
;

: take-to-north ( -- ) ['] north take-stone ;
: take-to-south ( -- ) ['] south take-stone ;
: take-to-east  ( -- ) ['] east  take-stone ;
: take-to-west  ( -- ) ['] west  take-stone ;

: on-board? ( -- ? )
	e9 here =
	d8 here = OR
	e8 here = OR
	f8 here = OR
	c7 here = OR
	d7 here = OR
	e7 here = OR
	f7 here = OR
	g7 here = OR
	b6 here = OR
	c6 here = OR
	d6 here = OR
	e6 here = OR
	f6 here = OR
	g6 here = OR
	h6 here = OR
	a5 here = OR
	b5 here = OR
	c5 here = OR
	d5 here = OR
	e5 here = OR
	f5 here = OR
	g5 here = OR
	h5 here = OR
	i5 here = OR
	b4 here = OR
	c4 here = OR
	d4 here = OR
	e4 here = OR
	f4 here = OR
	g4 here = OR
	h4 here = OR
	c3 here = OR
	d3 here = OR
	e3 here = OR
	f3 here = OR
	g3 here = OR
	d2 here = OR
	e2 here = OR
	f2 here = OR
	e1 here = OR
;

: check-empty? ( -- ? )
	empty?
	piece-type DWARF = OR
;

: check-wizard? ( -- ? )
	piece-type WIZARD =
;

: check-edge? ( 'dir -- ? )
	here SWAP check-empty? SWAP 
	EXECUTE IF
		is-stone?
		piece-type TROLL = OR
	ELSE
		TRUE
	ENDIF
	AND
	SWAP to
;

: check-troll? ( 'dir -- ? )
	here SWAP
	BEGIN
		DUP EXECUTE IF
			check-empty? IF
				FALSE
			ELSE
				piece-type TROLL = friend? AND IF
					DROP to
					TRUE
					TRUE
				ELSE
					DROP to
					FALSE
					TRUE
				ENDIF
			ENDIF
		ELSE
			DROP to
			FALSE
			TRUE
		ENDIF
	UNTIL
;

: drop-stone ( 'opposite 'dir -- )
	check-edge? check-wizard? OR 
	on-board? AND IF
		check-troll? IF
			drop
			lock-continue
			add-move
		ENDIF
	ENDIF
;

: drop-to-north ( -- ) ['] north ['] south drop-stone ;
: drop-to-south ( -- ) ['] south ['] north drop-stone ;
: drop-to-east  ( -- ) ['] east  ['] west  drop-stone ;
: drop-to-west  ( -- ) ['] west  ['] east  drop-stone ;

: pass-move ( -- )
	Pass
	add-move
;

{moves wizard-moves
	{move} step-to-north {move-type} normal-type
	{move} step-to-south {move-type} normal-type
	{move} step-to-east  {move-type} normal-type
	{move} step-to-west  {move-type} normal-type
	{move} pass-move     {move-type} pass-type
moves}

{moves dwarf-moves
	{move} step-to-north {move-type} normal-type
	{move} step-to-south {move-type} normal-type
	{move} step-to-east  {move-type} normal-type
	{move} step-to-west  {move-type} normal-type
	{move} pass-move     {move-type} pass-type
moves}

{moves troll-moves
	{move} step-to-north {move-type} normal-type
	{move} step-to-south {move-type} normal-type
	{move} step-to-east  {move-type} normal-type
	{move} step-to-west  {move-type} normal-type
	{move} drag-to-north {move-type} normal-type
	{move} drag-to-south {move-type} normal-type
	{move} drag-to-east  {move-type} normal-type
	{move} drag-to-west  {move-type} normal-type
	{move} take-to-north {move-type} normal-type
	{move} take-to-south {move-type} normal-type
	{move} take-to-east  {move-type} normal-type
	{move} take-to-west  {move-type} normal-type
	{move} pass-move     {move-type} pass-type
moves}

{moves stone-drops
	{move} drop-to-north {move-type} continue-type
	{move} drop-to-south {move-type} continue-type
	{move} drop-to-east  {move-type} continue-type
	{move} drop-to-west  {move-type} continue-type
moves}

{move-priorities
	{move-priority} normal-type
	{move-priority} pass-type
move-priorities}

{pieces
	{piece}		lock
	{piece}		stone	{drops} stone-drops
	{piece}		wizard	{moves} wizard-moves
	{piece}		dwarf	{moves} dwarf-moves
	{piece}		troll	{moves} troll-moves
pieces}

' continue-type 	IS CONTINUE-TYPE

' lock	 		IS LOCK
' stone 		IS STONE
' wizard 		IS WIZARD
' dwarf 		IS DWARF
' troll 		IS TROLL

{turn-order
	{turn}	South
	{turn}	West
	{turn}	West
	{repeat}
	{turn}	North
	{turn}	North
	{turn}	North
	{turn}	East
	{turn}	East
	{turn}	East
	{turn}	South
	{turn}	South
	{turn}	South
	{turn}	West
	{turn}	West
	{turn}	West
turn-order}

{board-setup
	{setup}	South stone  e1
	{setup}	South wizard d2
	{setup}	South dwarf  e2
	{setup}	South troll  f2

	{setup}	West stone   a5
	{setup}	West wizard  b6
	{setup}	West dwarf   b5
	{setup}	West troll   b4

	{setup}	North stone  e9
	{setup}	North wizard f8
	{setup}	North dwarf  e8
	{setup}	North troll  d8

	{setup}	East stone   i5
	{setup}	East wizard  h4
	{setup}	East dwarf   h5
	{setup}	East troll   h6
board-setup}

