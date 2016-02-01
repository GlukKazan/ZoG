LOAD AI-Common.4th

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	opponent-score?
	my-score?
	2DUP + 0> IF
		SWAP
		DUP 0= IF
			DROP 100
		ENDIF
		SWAP
		DUP 0= IF
			DROP 100
		ENDIF
		2DUP < IF
			2DROP DROP
			DROP #WinScore
		ELSE
			> IF
				#LossScore
			ELSE
				DROP #DrawScore
			ENDIF
		ENDIF
	ELSE
		2DROP
		stalemate? IF
			DROP #DrawScore
		ENDIF
	ENDIF
;
