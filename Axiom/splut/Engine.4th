LOAD Board.4th ( Load the Board Definitions )

\ $gameLog	OFF

81 CONSTANT	BoardSize
5  CONSTANT	MaxDepth

VARIABLE	BestScore
VARIABLE	Nodes
VARIABLE	Depth
VARIABLE	CurrEval
VARIABLE	CurrPlayer

MaxDepth []	CurrMove[]
MaxDepth []	CurrTurn[]
MaxDepth []	CurrScore[]

: Eval ( player -- score )
	CurrPlayer !
	0 CurrEval !
	BoardSize BEGIN
		1-
		DUP not-empty-at? IF
			DUP piece-at piece-value
			OVER player-at CurrPlayer @ = IF
				3 *
			ELSE
				NEGATE
			ENDIF
			CurrEval @ + CurrEval !
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
		turn-offset-to-player Eval
	ELSE
		DUP turn-offset-to-player FALSE 0 $GenerateMoves 
                Depth @ CurrTurn[] !
		$FirstMove Depth @ CurrMove[] !
		-1000 Depth @ CurrScore[] !
		BEGIN
			$CloneBoard
			Depth @ CurrMove[] @
			.moveCFA EXECUTE
			2DUP
			Depth @ CurrTurn[] @ next-turn-offset
			RECURSE
			$DeallocateBoard
			$Yield
			Depth @ CurrTurn[] @ turn-offset-to-player
			current-player <> IF
				NEGATE
			ENDIF
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
				Depth @ CurrMove[] @
				$NextMove
				DUP Depth @ CurrMove[] !
				NOT
			ENDIF
		UNTIL
		$DeallocateMoves
		DROP DROP
		Depth @ CurrScore[] @
	ENDIF
	Depth ++
;

: Custom-Engine ( -- )
	-1000 BestScore !
	0 Nodes !
	$FirstMove
	BEGIN
		$CloneBoard
		DUP $MoveString 
\		DUP TYPE
		CurrentMove!
		DUP .moveCFA EXECUTE
		MaxDepth Depth !
		BestScore @ 1000 turn-offset next-turn-offset Score
		0 10 $RAND-WITHIN +
\		BL EMIT DUP . CR
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
\	CR
;
