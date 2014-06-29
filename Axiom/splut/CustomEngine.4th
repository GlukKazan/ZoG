LOAD Board.4th ( Load the Board Definitions )

VARIABLE	BestScore
VARIABLE	Nodes

VARIABLE	start-enemy-wizards
VARIABLE	curr-enemy-wizards
VARIABLE	start-enemy-dwarfs
VARIABLE	curr-enemy-dwarfs
VARIABLE	start-friend-wizards
VARIABLE	curr-friend-wizards
VARIABLE	start-friend-dwarfs
VARIABLE	curr-friend-dwarfs
VARIABLE	start-friend-delta-troll
VARIABLE	curr-friend-delta-troll
VARIABLE	start-enemy-delta-troll
VARIABLE	curr-enemy-delta-troll
VARIABLE	start-friend-delta-wizard
VARIABLE	curr-friend-delta-wizard
VARIABLE	start-enemy-delta-wizard
VARIABLE	curr-enemy-delta-wizard

VARIABLE	curr-pos
VARIABLE	curr-delta

: get-x ( pos -- x )
	9 MOD
;

: get-y ( pos -- y )
	9 /
;

: delta-x ( pos1 pos2 -- delta )
	get-x SWAP get-x - ABS
;

: delta-y ( pos1 pos2 -- delta )
	get-y SWAP get-y - ABS
;

: delta-square ( pos1 pos2 -- delta )
	2DUP delta-x ROT ROT delta-y +
;

: delta-min ( pos1 pos2 -- delta )
	2DUP delta-x ROT ROT delta-y MIN
;

: enemy-piece? ( value pos -- ? )
	DUP enemy-at? IF
		piece-at piece-value =
	ELSE
		DROP DROP FALSE
	ENDIF
;

: friend-piece? ( value pos -- ? )
	DUP friend-at? IF
		piece-at piece-value =
	ELSE
		DROP DROP FALSE
	ENDIF
;

: not-empty-piece? ( value pos -- ? )
	DUP not-empty-at? IF
		piece-at piece-value =
	ELSE
		DROP DROP FALSE
	ENDIF
;

: sum-delta-troll ( addr pos -- )
	curr-pos !
	0 curr-delta !
	81 BEGIN
		1-
		DUP 0 SWAP not-empty-piece? IF
			DUP curr-pos @ delta-min
			curr-delta @ + curr-delta !
		ENDIF
		DUP 0> IF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
	DROP DUP @ curr-delta @ + SWAP !
;

: sum-delta-wizard ( addr pos -- )
	curr-pos !
	0 curr-delta !
	81 BEGIN
		1-
		DUP 0 SWAP not-empty-piece? IF
			DUP curr-pos @ delta-square
			curr-delta @ + curr-delta !
		ENDIF
		DUP 0> IF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
	DROP DUP @ curr-delta @ + SWAP !
;

: check-position ( -- )
	0 curr-enemy-wizards       !
	0 curr-enemy-dwarfs        !
	0 curr-friend-wizards      !
	0 curr-friend-dwarfs       !
	0 curr-friend-delta-troll  !
	0 curr-enemy-delta-troll   !
	0 curr-friend-delta-wizard !
	0 curr-enemy-delta-wizard  !
	81 BEGIN
		1-
		DUP 3 SWAP enemy-piece?  IF curr-enemy-dwarfs   ++ ENDIF
		DUP 3 SWAP friend-piece? IF curr-friend-dwarfs  ++ ENDIF
		DUP 4 SWAP enemy-piece?  IF 
			curr-enemy-wizards  ++ 
			DUP curr-enemy-delta-wizard SWAP sum-delta-wizard
		ENDIF
		DUP 4 SWAP friend-piece? IF 
			curr-friend-wizards ++ 
			DUP curr-friend-delta-wizard SWAP sum-delta-wizard
		ENDIF
		DUP 2 SWAP friend-piece? IF 
			DUP curr-friend-delta-troll SWAP sum-delta-troll
		ENDIF
		DUP 2 SWAP enemy-piece? IF 
			DUP curr-enemy-delta-troll SWAP sum-delta-troll
		ENDIF
		DUP 0> IF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
	DROP
;

: Score ( -- score )
	check-position
	0 100 $RAND-WITHIN
	start-enemy-wizards @ curr-enemy-wizards @ > IF
		1000 +
	ENDIF
	start-friend-wizards @ curr-friend-wizards @ > IF
		1000 -
	ENDIF
	start-enemy-dwarfs @ curr-enemy-dwarfs @ > IF
		300 +
	ENDIF
	start-friend-dwarfs @ curr-friend-dwarfs @ > IF
		300 -
	ENDIF
	start-enemy-delta-wizard @ curr-enemy-delta-wizard @ > IF
		700 +
	ELSE
		700 -
	ENDIF
	start-friend-delta-wizard @ curr-friend-delta-wizard @ > IF
		400 -
	ELSE
		400 +
	ENDIF
	start-friend-delta-troll @ curr-friend-delta-troll @ > IF
		500 -
	ELSE
		500 +
	ENDIF
	start-enemy-delta-troll @ curr-enemy-delta-troll @ > IF
		100 +
	ELSE
		100 -
	ENDIF
;

: Custom-Engine ( -- )
	-1000 BestScore !
	0 Nodes !
	check-position
	curr-enemy-wizards         @ start-enemy-wizards        !
	curr-enemy-dwarfs          @ start-enemy-dwarfs         !
	curr-friend-wizards        @ start-friend-wizards       !
	curr-friend-dwarfs         @ start-friend-dwarfs        !
	curr-friend-delta-troll    @ start-friend-delta-troll   !
	curr-enemy-delta-troll     @ start-enemy-delta-troll    !
	curr-friend-delta-wizard   @ start-friend-delta-wizard  !
	curr-enemy-delta-wizard    @ start-enemy-delta-wizard   !
	$FirstMove
	BEGIN
		$CloneBoard
		DUP $MoveString CurrentMove!
		DUP .moveCFA EXECUTE
		Score BestScore @ OVER <
		IF
			DUP BestScore !
			Score!
			DUP $MoveString BestMove!
		ELSE
			DROP
		ENDIF
		$DeallocateBoard
		Nodes ++
		Nodes @ Nodes!
		$Yield
		$NextMove
		DUP NOT
	UNTIL
	DROP
;
