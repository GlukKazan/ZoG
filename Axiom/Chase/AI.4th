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

: for-friend-at? ( pos -- ? )
	DUP empty-at? IF
		DROP FALSE
	ELSE
		player-at for-player =
	ENDIF
;

: for-enemy-at? ( pos -- ? )
	DUP empty-at? IF
		DROP FALSE
	ELSE
		player-at for-player <>
	ENDIF
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	0 0 BEGIN
		DUP for-friend-at? IF
			SWAP OVER val-at + SWAP
		ENDIF
		1+ DUP A9 >
	UNTIL DROP
	25 < IF
		DROP
		#LossScore
	ENDIF
	0 0 BEGIN
		DUP for-enemy-at? IF
			SWAP OVER val-at + SWAP
		ENDIF
		1+ DUP A9 >
	UNTIL DROP
	25 < IF
		DROP
		#WinScore
	ENDIF
;
