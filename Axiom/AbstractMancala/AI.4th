VARIABLE	first-pices
VARIABLE	second-pices
VARIABLE	total-pices

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
			not-empty? IF
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

: OnEvaluate ( -- score )
	calc-pices
	first-pices  @
	second-pices @ - 100 *
	current-player Second = IF NEGATE ENDIF
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

: pices++ ( -- ) 
	current-player First = IF
		FP ++
	ENDIF
	current-player Second = IF
		SP ++
	ENDIF

;

: turns++ ( -- ) ;

' pices++ IS p++
' turns++ IS t++
