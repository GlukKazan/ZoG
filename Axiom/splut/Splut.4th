LOAD CustomEngine.4th ( Load the Custom Engine )

{players
	{player}	South	{search-engine} Custom-Engine
	{player}	West	{search-engine} Custom-Engine
	{player}	North	{search-engine} Custom-Engine
	{player}	East	{search-engine} Custom-Engine
players}

DEFER		CONTINUE-TYPE
DEFER		LOCK
DEFER		SSTONE
DEFER		NSTONE
DEFER		WSTONE
DEFER		ESTONE
DEFER		WIZARD
DEFER		DWARF
DEFER		TROLL

VARIABLE	forward
VARIABLE	backward
VARIABLE	step-count
VARIABLE	here-pos

: piece-is-not-present? ( -- ? )
	here a5 to
	BEGIN
		piece-type current-piece-type = IF
			to
			FALSE
			TRUE
		ELSE
			next IF
				FALSE
			ELSE
				to
				TRUE
				TRUE
			ENDIF
		ENDIF
	UNTIL
;

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
	piece-type SSTONE =
	piece-type NSTONE = OR
	piece-type WSTONE = OR
	piece-type ESTONE = OR
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

: drop-team ( player -- )
	here SWAP a5 to
	BEGIN
		DUP player = IF
			is-stone? NOT 
                        piece-type WIZARD = NOT AND IF
				capture
			ENDIF
		ENDIF
		next IF
			FALSE
		ELSE
			DROP
			TRUE
		ENDIF
	UNTIL
	to
;

: drop-stone ( 'opposite 'dir -- )
	check-edge? check-wizard? OR 
	on-board? AND IF
		check-troll? piece-is-not-present? AND IF
			player piece-type
			drop
			WIZARD = IF
				drop-team
			ELSE
				DROP
			ENDIF
			lock-continue
			add-move
		ENDIF
	ENDIF
;

: drop-to-north ( -- ) ['] north ['] south drop-stone ;
: drop-to-south ( -- ) ['] south ['] north drop-stone ;
: drop-to-east  ( -- ) ['] east  ['] west  drop-stone ;
: drop-to-west  ( -- ) ['] west  ['] east  drop-stone ;

: push-step ( 'opposite 'dir -- )
	check-continue? IF
		0 step-count ! forward ! backward !
		forward @ EXECUTE verify not-empty? verify
		step-count ++
		player piece-type
		here here-pos !
		BEGIN
			forward @ EXECUTE IF
				empty? IF
					TRUE
				ELSE
					step-count ++
					player piece-type
					FALSE
				ENDIF
			ELSE
				BEGIN
					step-count @ 0> IF
						step-count --
						DROP DROP
						FALSE
					ELSE
						TRUE
					ENDIF
				UNTIL
				TRUE
			ENDIF
		UNTIL
		step-count @ 0> verify
		from here-pos @ move
		BEGIN
			step-count @ 0> IF
				step-count --
				create-player-piece-type
				backward @ EXECUTE DROP
				FALSE
			ELSE
				TRUE
			ENDIF		
		UNTIL
		add-move
	ELSE
		DROP DROP
	ENDIF
;

: push-to-north ( -- ) ['] north ['] south push-step ;
: push-to-south ( -- ) ['] south ['] north push-step ;
: push-to-east  ( -- ) ['] east  ['] west  push-step ;
: push-to-west  ( -- ) ['] west  ['] east  push-step ;

: can-fly? ( -- ? )
	here from = empty? OR
;

: fly-stone ( 'dir -- )
	DUP EXECUTE empty? AND IF
		a5 to
		BEGIN
			is-stone? IF
				here here-pos !
				DUP EXECUTE can-fly? AND IF
					from to
					DUP EXECUTE DROP
					from
					here
					move
					here-pos @ to
					DUP piece-type SWAP
					capture
					EXECUTE DROP
					create-piece-type
					add-move
				ENDIF
				here-pos @ to
			ENDIF
			DUP next NOT
		UNTIL
	ENDIF
	DROP
;

: fly-to-north ( -- ) ['] north fly-stone ;
: fly-to-south ( -- ) ['] south fly-stone ;
: fly-to-east  ( -- ) ['] east  fly-stone ;
: fly-to-west  ( -- ) ['] west  fly-stone ;

: pass-move ( -- )
	Pass
	add-move
;

: check-wizard ( pos -- ? )
	DUP not-empty-at? IF
		DUP piece-type-at WIZARD = IF
			friend-at?
		ELSE
			DROP
			TRUE
		ENDIF
	ELSE
		DROP
		TRUE
	ENDIF
;

: is-alone? ( -- ? )
	a5 check-wizard
	b4 check-wizard AND
	b5 check-wizard AND
	b6 check-wizard AND
	c3 check-wizard AND
	c4 check-wizard AND
	c5 check-wizard AND
	c6 check-wizard AND
	c7 check-wizard AND
	d2 check-wizard AND
	d3 check-wizard AND
	d4 check-wizard AND
	d5 check-wizard AND
	d6 check-wizard AND
	d7 check-wizard AND
	d8 check-wizard AND
	e1 check-wizard AND
	e2 check-wizard AND
	e3 check-wizard AND
	e4 check-wizard AND
	e5 check-wizard AND
	e6 check-wizard AND
	e7 check-wizard AND
	e8 check-wizard AND
	e9 check-wizard AND
	f2 check-wizard AND
	f3 check-wizard AND
	f4 check-wizard AND
	f5 check-wizard AND
	f6 check-wizard AND
	f7 check-wizard AND
	f8 check-wizard AND
	g3 check-wizard AND
	g4 check-wizard AND
	g5 check-wizard AND
	g6 check-wizard AND
	g7 check-wizard AND
	h4 check-wizard AND
	h5 check-wizard AND
	h6 check-wizard AND
	i5 check-wizard AND
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	is-alone? IF
		DROP #WinScore
	ENDIF
;

{moves wizard-moves
	{move} step-to-north {move-type} normal-type
	{move} step-to-south {move-type} normal-type
	{move} step-to-east  {move-type} normal-type
	{move} step-to-west  {move-type} normal-type
	{move} fly-to-north  {move-type} normal-type
	{move} fly-to-south  {move-type} normal-type
	{move} fly-to-east   {move-type} normal-type
	{move} fly-to-west   {move-type} normal-type
moves}

{moves dwarf-moves
	{move} step-to-north {move-type} normal-type
	{move} step-to-south {move-type} normal-type
	{move} step-to-east  {move-type} normal-type
	{move} step-to-west  {move-type} normal-type
	{move} push-to-north {move-type} normal-type
	{move} push-to-south {move-type} normal-type
	{move} push-to-east  {move-type} normal-type
	{move} push-to-west  {move-type} normal-type
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
moves}

{moves stone-drops
	{move} drop-to-north {move-type} continue-type
	{move} drop-to-south {move-type} continue-type
	{move} drop-to-east  {move-type} continue-type
	{move} drop-to-west  {move-type} continue-type
moves}

{moves pass-moves
	{move} pass-move     {move-type} pass-type
moves}

{move-priorities
	{move-priority} normal-type
	{move-priority} pass-type
move-priorities}

{pieces
	{piece}		lock    {moves} pass-moves
	{piece}		sstone	{drops} stone-drops
	{piece}		nstone	{drops} stone-drops
	{piece}		wstone	{drops} stone-drops
	{piece}		estone	{drops} stone-drops
	{piece}		wizard	{moves} wizard-moves	100 {value}
	{piece}		dwarf	{moves} dwarf-moves	50  {value}
	{piece}		troll	{moves} troll-moves
pieces}

' continue-type 	IS CONTINUE-TYPE

' lock	 		IS LOCK
' sstone 		IS SSTONE
' nstone 		IS NSTONE
' wstone 		IS WSTONE
' estone 		IS ESTONE
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
	{setup}	South sstone e1
	{setup}	South wizard f2
	{setup}	South dwarf  e2
	{setup}	South troll  d2
	{setup}	South lock   f1

	{setup}	West wstone  a5
	{setup}	West wizard  b6
	{setup}	West dwarf   b5
	{setup}	West troll   b4
	{setup}	West lock    g1

	{setup}	North nstone e9
	{setup}	North wizard f8
	{setup}	North dwarf  e8
	{setup}	North troll  d8
	{setup}	North lock   h1

	{setup}	East estone  i5
	{setup}	East wizard  h4
	{setup}	East dwarf   h5
	{setup}	East troll   h6
	{setup}	East lock    i1
board-setup}
