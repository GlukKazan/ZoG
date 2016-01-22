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
