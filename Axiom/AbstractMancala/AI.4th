VARIABLE	Score
VARIABLE	BestScore
VARIABLE	Nodes
VARIABLE	first-pices
VARIABLE	second-pices
VARIABLE	total-pices
VARIABLE	rand-index

: calc-pices ( -- )
	0 total-pices !
	FP @ first-pices !
	SP @ second-pices !
	PLANE BEGIN
		1-
		DUP to
		not-empty? IF
			piece piece-value
			up verify
			not-empty? piece-type TRAP = AND IF
				player First = IF
					first-pices @ +
					first-pices !
				ENDIF
				player Second = IF
					second-pices @ +
					second-pices !
				ENDIF
			ELSE
				total-pices @ +
				total-pices !
			ENDIF
		ENDIF 
		DUP 0=
	UNTIL DROP
;

: OnIsGameOver ( -- gameResult )
	calc-pices
	#UnknownScore
	first-pices @ second-pices @ total-pices @ + > IF
		current-player First = IF
			DROP
			#WinScore
		ELSE
			DROP
			#LossScore
		ENDIF
	ENDIF
	second-pices @ first-pices @ total-pices @ + > IF
		current-player First = IF
			DROP
			#LossScore
		ELSE
			DROP
			#WinScore
		ENDIF
	ENDIF
;

: OnNewGame ( -- )
	RANDOMIZE
;

: pices+ ( n -- ) 
	current-player First = IF
		FP +!
	ENDIF
	current-player Second = IF
		SP +!
	ENDIF

;

: turns++ ( -- ) ;

' pices+  IS p+
' turns++ IS t++

: ai-engine ( -- )
	-1000 BestScore !
	0 Nodes !
	calc-pices
	total-pices @ 10 *
	Score !
	$FirstMove
	0 $movesList @ CELLSIZE + @ 1-
	$RAND-WITHIN
	rand-index !
	BEGIN
		$CloneBoard
		DUP $MoveString 
		CurrentMove!
		DUP .moveCFA EXECUTE
		calc-pices
		Score @ total-pices @ 10 * - 
		rand-index --
		rand-index @ 0= IF
			1+
		ENDIF
		BestScore @ OVER <
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
		0 Depth!
		$Yield
		$NextMove
		DUP NOT
	UNTIL DROP
;

' ai-engine IS AI
