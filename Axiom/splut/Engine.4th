LOAD Board.4th ( Load the Board Definitions )

\ $gameLog	ON

81 CONSTANT	BoardSize
5  CONSTANT	MaxDepth

VARIABLE	BestScore
VARIABLE	Nodes
VARIABLE	Depth
VARIABLE	CurrEval
VARIABLE	CurrPos
VARIABLE	CurrFlag
VARIABLE	EvalCount

MaxDepth []	CurrMove[]
MaxDepth []	CurrTurn[]
MaxDepth []	CurrScore[]

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

: CheckPiece ( pos value -- pos ? )
	OVER piece-at piece-value =
;

: AddValue ( value -- )
	CurrEval @ + CurrEval !
;

: CheckStones ( pos ? -- )
	CurrFlag !
	CurrPos !
	BoardSize BEGIN
		1-
		DUP not-empty-at? IF
			1 CheckPiece IF
				DUP CurrPos @ delta-x OVER CurrPos @ delta-y
				MIN 0= IF
					CurrFlag @ IF
						-500 AddValue
					ELSE
						100 AddValue
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		DUP 0> IF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
	DROP
;

: CalcDelta ( pos ? -- )
	CurrFlag !
	CurrPos !
	BoardSize BEGIN
		1-
		DUP not-empty-at? IF
			1 CheckPiece IF
				DUP CurrPos @ delta-x OVER CurrPos @ delta-y +
				CurrFlag @ IF
					-30 * AddValue
				ELSE
					10 * AddValue
				ENDIF				
			ENDIF
		ENDIF
		DUP 0> IF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
	DROP
;

: Eval ( -- score )
	0 CurrEval !
	BoardSize BEGIN
		1-
		DUP not-empty-at? IF
			2 CheckPiece IF
				DUP DUP friend-at? CalcDelta
			ENDIF			
			3 CheckPiece IF
				DUP friend-at? IF 300 ELSE -100 ENDIF
				AddValue
			ENDIF
			4 CheckPiece IF
				DUP friend-at? IF 
					9000 AddValue
					TRUE
				ELSE 
					-3000 AddValue
					FALSE
				ENDIF
				OVER CheckStones
			ENDIF
		ENDIF
		DUP 0> IF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
	DROP
	CurrEval @
;

: Score ( alpha beta turn -- score )
	Depth -- Depth @
	0< IF
		SWAP DROP SWAP DROP
		Eval
		SWAP turn-offset-to-player
		current-player <> IF
			NEGATE
		ENDIF
		EvalCount ++
	ELSE
		DUP turn-offset-to-player FALSE 0 $GenerateMoves 
                Depth @ CurrTurn[] !
		$FirstMove Depth @ CurrMove[] !
		-10000 Depth @ CurrScore[] !
		BEGIN
			$CloneBoard
			Depth @ CurrMove[] @
			.moveCFA EXECUTE
			2DUP
			Depth @ CurrTurn[] @ next-turn-offset
			RECURSE
			$DeallocateBoard
			$Yield
			DUP Depth @ CurrScore[] @ > IF
				Depth @ CurrScore[] !
			ELSE
				DROP
			ENDIF
			Depth @ CurrTurn[] @ turn-offset-to-player
			current-player <> IF
				NEGATE SWAP NEGATE
			ENDIF
			OVER Depth @ CurrScore[] @ < IF
				SWAP DROP
				Depth @ CurrScore[] @
				SWAP
			ENDIF
			2DUP >= IF
				OVER Depth @ CurrScore[] !
				TRUE
			ELSE
				Depth @ CurrTurn[] @ turn-offset-to-player
				current-player <> IF
					NEGATE SWAP NEGATE
				ENDIF
				Depth @ CurrMove[] @
				$NextMove
				DUP Depth @ CurrMove[] !
				NOT
			ENDIF
		UNTIL
		$DeallocateMoves
		DROP DROP
		Depth @ CurrScore[] @
		Depth @ CurrTurn[] @
		turn-offset-to-player
		current-player <> IF
			NEGATE
		ENDIF
	ENDIF
	Depth ++
;

: Custom-Engine ( -- )
	-10000 BestScore !
	0 Nodes !
	$FirstMove
	BEGIN
		$CloneBoard
		DUP $MoveString 
		CurrentMove!
		DUP .moveCFA EXECUTE
		MaxDepth Depth !
		0 EvalCount !
		BestScore @ 10000 turn-offset next-turn-offset Score
		0 5 $RAND-WITHIN +
		BestScore @ OVER <
		IF
			DUP BestScore !
			Score!
			0 Depth!
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
