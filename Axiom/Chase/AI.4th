: mobility ( -- score )
	move-count
	current-player TRUE 0 $GenerateMoves
	move-count -
	$DeallocateMoves
;

: OnEvaluate ( -- score ) 
	mobility
	current-player material-balance 3 * +
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	0 0 BEGIN
		DUP friend-at? IF
			SWAP OVER val-at + SWAP
		ENDIF
		1+ DUP A9 >
	UNTIL DROP
	25 < IF
		DROP
		#LossScore
	ENDIF
	0 0 BEGIN
		DUP enemy-at? IF
			SWAP OVER val-at + SWAP
		ENDIF
		1+ DUP A9 >
	UNTIL DROP
	25 < IF
		DROP
		#WinScore
	ENDIF
;
