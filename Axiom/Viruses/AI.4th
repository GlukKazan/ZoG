: OnIsGameOver ( -- gameResult )
	#UnknownScore
	stalemate? IF
		DROP
		#LossScore
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
