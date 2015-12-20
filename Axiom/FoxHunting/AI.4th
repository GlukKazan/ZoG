: OnNewGame ( -- )
	RANDOMIZE
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	SZ SZ * BEGIN
		1-
		DUP empty-at? NOT IF
			DUP player-at You <> IF
				SWAP DROP
				#LossScore
				SWAP
			ENDIF
			SWAP
			DUP #UnknownScore = IF
				DROP #WinScore
			ENDIF SWAP
		ENDIF
		DUP 0=
	UNTIL DROP
	DUP #LossScore = IF
		DROP #UnknownScore
	ENDIF
;
