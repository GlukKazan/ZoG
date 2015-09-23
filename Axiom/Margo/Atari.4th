: OnIsGameOver ( -- gameResult )
	#UnknownScore
	current-player W = IF
		BC @ 0> IF
			DROP
			#LossScore
		ENDIF
		WC @ 0> IF
			DROP
			#WinScore
		ENDIF
	ENDIF
	current-player B = IF
		WC @ 0> IF
			DROP
			#LossScore
		ENDIF
		BC @ 0> IF
			DROP
			#WinScore
		ENDIF
	ENDIF
;
