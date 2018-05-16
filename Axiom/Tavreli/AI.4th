VARIABLE friend-kings
VARIABLE enemy-kings

: OnIsGameOver ( -- gameResult )
	0 friend-kings !
        0 enemy-kings  !
	SZ DUP * 
	BEGIN
		DUP 0> IF
			1- DUP piece-type-at DUP
			KingI = SWAP King = OR IF
				DUP friend-at? IF
					friend-kings ++
				ELSE
					enemy-kings ++
				ENDIF
			ENDIF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	#UnknownScore
	enemy-kings @ 0= IF
		DROP #WinScore
	ELSE
		friend-kings @ 0= IF
			DROP #LossScore
		ENDIF
	ENDIF
;
