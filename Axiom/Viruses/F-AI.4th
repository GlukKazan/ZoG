VARIABLE	cnt

: calc-pieces ( -- )
	0 cnt !
	0 BEGIN
		DUP TOTAL >= IF
			TRUE
		ELSE
			DUP friend-at? IF
				cnt ++
			ENDIF
			1+ FALSE
		ENDIF
	UNTIL DROP
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	passed @ 1 > IF
		DROP calc-pieces
		cnt @ TOTAL 2 / > IF
			#WinScore
		ELSE
			#LossScore
		ENDIF
	ENDIF
;

: Mobility ( -- mobilityScore )
	move-count
	current-player TRUE 0 $GenerateMoves
	move-count -
	$DeallocateMoves
;

: OnEvaluate ( -- score )
	Mobility MOBILITY-WEIGHT *
	current-player material-balance BALANCE-WEIGHT * +
;
