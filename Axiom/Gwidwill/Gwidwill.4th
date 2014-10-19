8		CONSTANT	DIM
DIM DIM *	CONSTANT	SIZE
26		CONSTANT	MAXP

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
	{turn}	White
	{turn}	Black
turn-order}

: get-value ( -- n )
	piece piece-value
	DUP 100 = IF
		DROP 3
	ENDIF
	DUP 400 = IF
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

: kill-step ( 'dir -- )
	EXECUTE IF
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
	0 size-p !
	step-r
;

: kill-n ( -- ) ['] north kill-step ;
: kill-s ( -- ) ['] south kill-step ;
: kill-e ( -- ) ['] east  kill-step ;
: kill-w ( -- ) ['] west  kill-step ;

: step-1 ( -- ) 1 step-all ;
: step-2 ( -- ) 2 step-all ;
: step-3 ( -- ) 3 step-all ;

{moves moves-1
	{move} step-1
	{move} kill-n
	{move} kill-s
	{move} kill-e
	{move} kill-w
moves}

{moves moves-2
	{move} step-2
	{move} kill-n
	{move} kill-s
	{move} kill-e
	{move} kill-w
moves}

{moves moves-3
	{move} step-3
	{move} kill-n
	{move} kill-s
	{move} kill-e
	{move} kill-w
moves}

{pieces
	{piece}		Squire		{moves} moves-1	1   {value}
	{piece}		Knight		{moves} moves-2	2   {value}
	{piece}		King		{moves} moves-1	100 {value}
	{piece}		Champion	{moves} moves-3	3   {value}
	{piece}		Pendragon	{moves} moves-1	400 {value}
	{piece}		One				1   {value}
	{piece}		Two				2   {value}
	{piece}		Three				3   {value}
	{piece}		Four				4   {value}
	{piece}		Five				5   {value}
	{piece}		Six				6   {value}
pieces}

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
