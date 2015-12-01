: OnIsGameOver ( -- gameResult )
	#UnknownScore
	h2 get-value-at 27 > IF
		current-player First = IF
			DROP #WinScore
		ELSE
			DROP #LossScore
		ENDIF
	ENDIF
	a2 get-value-at 27 > IF
		current-player Second = IF
			DROP #WinScore
		ELSE
			DROP #LossScore
		ENDIF
	ENDIF
;


: OnEvaluate ( -- score )
	h2 get-value-at
	a2 get-value-at -
	current-player Second = IF NEGATE ENDIF
;
