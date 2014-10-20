8		CONSTANT	DIM
DIM DIM *	CONSTANT	SIZE
26		CONSTANT	MAXP

VARIABLE	wking-count
VARIABLE	bking-count
VARIABLE	size-p
MAXP []		pos[]

{board
	DIM DIM {grid}
	{position} Z1
board}

{directions
	-1  0  {direction} north
	 1  0  {direction} south
	 0  1  {direction} east
	 0 -1  {direction} west
directions}

{players
	{player}	White
	{player}	Black
	{player}	?Dice	{random}
players}

{turn-order
	{repeat}
	{turn}	?Dice
	{turn}	White
	{turn}	?Dice
	{turn}	Black
turn-order}

: get-value ( -- n )
	piece piece-value
	DUP 700 = IF
		DROP 3
	ENDIF
	DUP 800 = IF
		DROP 4
	ENDIF
;

: add-value ( n 'dir -- n )
	EXECUTE friend? AND IF
		get-value +
	ENDIF
;

: is-attacked? ( -- ? )
	here 0
		OVER to ['] north add-value
		OVER to ['] south add-value
		OVER to ['] east  add-value
		OVER to ['] west  add-value
	SWAP to
	get-value >
;

: check-dice? ( -- ? )
	Z1 piece-at piece-value
	get-value >=
;

: kill-step ( 'dir -- )
	check-dice? SWAP EXECUTE AND IF
		enemy? is-attacked? AND IF
			from here move
			add-move
		ENDIF
	ENDIF
;

: not-duplicate? ( -- ? )
	TRUE size-p @ BEGIN 1- 
		DUP 0 >= IF
			DUP pos[] @ here = IF
				2DROP FALSE 0
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL DROP
	IF
		here size-p @ pos[] !
		size-p ++
		TRUE
	ELSE
		FALSE
	ENDIF
;

: step-dir ( 'dir -- ? )
	EXECUTE IF
		empty? not-duplicate? AND IF
			from here move
			add-move
			TRUE
		ELSE
			FALSE
		ENDIF
	ELSE
		FALSE
	ENDIF
;

: step-r ( n -- )
	here
	DUP to ['] north step-dir IF
		OVER 1 > IF
			OVER 1- RECURSE
		ENDIF
	ENDIF
	DUP to ['] south step-dir IF
		OVER 1 > IF
			OVER 1- RECURSE
		ENDIF
	ENDIF
	DUP to ['] east step-dir IF
		OVER 1 > IF
			OVER 1- RECURSE
		ENDIF
	ENDIF
	DUP to ['] west step-dir IF
		OVER 1 > IF
			OVER 1- RECURSE
		ENDIF
	ENDIF
	to DROP
;

: step-all ( n -- )
	check-dice? IF
		0 size-p !
		step-r
	ENDIF
;

: drop-dice ( -- )
	Z1 here = current-player ?Dice = AND IF
		drop
		add-move
	ENDIF
;

: kill-n ( -- ) ['] north kill-step ;
: kill-s ( -- ) ['] south kill-step ;
: kill-e ( -- ) ['] east  kill-step ;
: kill-w ( -- ) ['] west  kill-step ;

: step-1 ( -- ) 1 step-all ;
: step-2 ( -- ) 2 step-all ;
: step-3 ( -- ) 3 step-all ;

{moves moves-1
	{move} step-1	{move-type} normal-type
	{move} kill-n	{move-type} normal-type
	{move} kill-s	{move-type} normal-type
	{move} kill-e	{move-type} normal-type
	{move} kill-w	{move-type} normal-type
	{move} Pass	{move-type} pass-type
moves}

{moves moves-2
	{move} step-2	{move-type} normal-type
	{move} kill-n	{move-type} normal-type
	{move} kill-s	{move-type} normal-type
	{move} kill-e	{move-type} normal-type
	{move} kill-w	{move-type} normal-type
moves}

{moves moves-3
	{move} step-3	{move-type} normal-type
	{move} kill-n	{move-type} normal-type
	{move} kill-s	{move-type} normal-type
	{move} kill-e	{move-type} normal-type
	{move} kill-w	{move-type} normal-type
moves}

{moves drop-d
	{move} drop-dice {move-type} normal-type
moves}

{move-priorities
	{move-priority} normal-type
	{move-priority} pass-type
move-priorities}

{pieces
	{piece}		Squire		{moves} moves-1	1   {value}
	{piece}		Knight		{moves} moves-2	2   {value}
	{piece}		King		{moves} moves-1	700 {value}
	{piece}		Champion	{moves} moves-3	3   {value}
	{piece}		Pendragon	{moves} moves-1	800 {value}
	{piece}		One		{drops} drop-d	1   {value}
	{piece}		Two		{drops} drop-d	2   {value}
	{piece}		Three		{drops} drop-d	3   {value}
	{piece}		Four		{drops} drop-d	4   {value}
	{piece}		Five		{drops} drop-d	5   {value}
	{piece}		Six		{drops} drop-d	6   {value}
pieces}

: OnNewGame ( -- )
	RANDOMIZE
;

: Mobility ( -- score )
	move-count
	current-player TRUE 0 $GenerateMoves
	move-count -
	$DeallocateMoves
;

: OnEvaluate ( -- score )
	Mobility
	current-player material-balance 3 * +
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	0 wking-count !
	0 bking-count !
	SIZE BEGIN
		1-
		DUP 0 >= IF
			DUP empty-at? NOT IF
				DUP piece-type-at King = IF
					bking-count ++
				ENDIF
				DUP piece-type-at Pendragon = IF
					wking-count ++
				ENDIF
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL DROP
	bking-count @ 0= IF
		current-player White = IF
			DROP #WinScore
		ENDIF
		current-player Black = IF
			DROP #LossScore
		ENDIF
	ENDIF
	wking-count @ 0= IF
		current-player Black = IF
			DROP #WinScore
		ENDIF
		current-player White = IF
			DROP #LossScore
		ENDIF
	ENDIF
;

{board-setup
	{setup}	White Pendragon d5
	{setup}	White Champion e4
	{setup}	White Knight d4
	{setup}	White Knight e5
	{setup}	White Squire c3
	{setup}	White Squire c4
	{setup}	White Squire c5
	{setup}	White Squire c6
	{setup}	White Squire d3
	{setup}	White Squire d6
	{setup}	White Squire e3
	{setup}	White Squire e6
	{setup}	White Squire f3
	{setup}	White Squire f4
	{setup}	White Squire f5
	{setup}	White Squire f6

	{setup}	Black King d1
	{setup}	Black King a5
	{setup}	Black King e8
	{setup}	Black King h4
	{setup}	Black Knight e1
	{setup}	Black Knight a4
	{setup}	Black Knight d8
	{setup}	Black Knight h5
	{setup}	Black Squire c1
	{setup}	Black Squire f1
	{setup}	Black Squire a3
	{setup}	Black Squire a6
	{setup}	Black Squire c8
	{setup}	Black Squire f8
	{setup}	Black Squire h3
	{setup}	Black Squire h6
board-setup}
