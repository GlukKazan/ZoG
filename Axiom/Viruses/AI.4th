: OnIsGameOver ( -- gameResult )
	#UnknownScore
	stalemate? IF
		DROP
		#LossScore
	ENDIF
;

: Mobility ( -- mobilityScore )
	move-count
	current-player TRUE $GenerateMoves
	move-count -
	$DeallocateMoves
;

: OnEvaluate ( -- score )
	Mobility MOBILITY-WEIGHT *
	current-player material-balance BALANCE-WEIGHT * +
;
