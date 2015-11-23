: OnIsGameOver ( -- gameResult )
	#UnknownScore
	stalemate? IF
		0 stone-count !
		0 BEGIN
			DUP empty-at? NOT IF
				stone-count ++
			ENDIF
			1+ DUP home =
		UNTIL DROP
		stone-count @ 0> IF
			DROP #LossScore
		ELSE
			DROP #WinScore
		ENDIF
	ENDIF
;
