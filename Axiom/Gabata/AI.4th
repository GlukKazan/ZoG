VARIABLE	total-count

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
	DUP #UnknownScore = IF
		current-player First = IF
			h2 get-value-at total-count !
		ELSE
			a2 get-value-at total-count !
		ENDIF
		DROP #LossScore
		h1 BEGIN
			DUP a2 <> IF
				DUP friend-at? IF
					SWAP DROP #UnknownScore SWAP
					total-count ++
				ENDIF
			ENDIF
			DUP a3 = IF
				TRUE
			ELSE
				1- FALSE
			ENDIF
		UNTIL DROP
		DUP #LossScore = IF
			total-count @ 27 > IF
				DROP #WinScore
			ENDIF
		ENDIF
	ENDIF
;


: OnEvaluate ( -- score )
	h2 get-value-at
	a2 get-value-at -
	current-player Second = IF NEGATE ENDIF
;
