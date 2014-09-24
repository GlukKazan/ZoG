: OnIsGameOver ( -- gameResult )
	#UnknownScore result-value !
	CheckGameOver result-value !
	result-value @ #UnknownScore = IF
		here load-halfs to
		black-pyramid-is-missing? @ IF
			TRUE white-half-count @ iterate-a
		ENDIF
		white-pyramid-is-missing? @ IF		
			FALSE black-half-count @ iterate-a
		ENDIF
	ENDIF
	result-value @
;
