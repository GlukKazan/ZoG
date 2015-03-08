10		CONSTANT	MK
1		CONSTANT	BK

: OnNewGame ( -- )
	RANDOMIZE
;

: get-row ( pos - n )
	DUP COLS /
	SWAP player-at Light = IF
		ROWS 1- SWAP -
	ENDIF 1+
;

: check-win ( gameResult -- gameResult )
	0 BEGIN
		DUP not-empty-at? IF
			DUP friend-at? OVER get-row ROWS = AND IF
				2DROP #WinScore SIZE
			ENDIF
			DUP enemy-at? OVER get-row ROWS = AND IF
				2DROP #LossScore SIZE
			ENDIF
		ENDIF
		1+ DUP SIZE >=
	UNTIL DROP
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	stalemate? IF
		DROP #LossScore
	ELSE
		check-win
	ENDIF
;

: mobility ( -- score )
	move-count
	current-player TRUE 0 $GenerateMoves
	move-count -
	$DeallocateMoves	
;

: OnEvaluate ( -- score )
	mobility MK *
	current-player material-balance BK * +
;
