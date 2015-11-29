: OnIsGameOver ( -- gameResult )
	#UnknownScore
	east get-value-at 64 > IF
		current-player Second = IF
			DROP #WinScore
		ELSE
			DROP #LossScore
		ENDIF
	ENDIF
	west get-value-at 64 > IF
		current-player First = IF
			DROP #WinScore
		ELSE
			DROP #LossScore
		ENDIF
	ENDIF
;


: OnEvaluate ( -- score )
	east get-value-at
	west get-value-at -
	current-player First = IF ENDIF
;
