VARIABLE	your-pices
VARIABLE	total-pices

: is-trap? ( -- ? )
	here up IF
		FALSE
		not-empty? IF
			piece-type TRAP = IF
				DROP TRUE
			ENDIF
		ENDIF
		SWAP to
	ELSE
		DROP FALSE
	ENDIF
;

: is-win? ( -- ? )
	0 your-pices  !
	0 total-pices !
	PLANE BEGIN
		DUP to
		not-empty? IF
			piece piece-value
			is-trap? IF
				your-pices @ +
				your-pices !
			ELSE
				total-pices @ +
				total-pices !
			ENDIF
		ENDIF 
		DUP 0= IF
			TRUE
		ELSE
			1-
			FALSE
		ENDIF
	UNTIL DROP
	FP @ your-pices @ +
	total-pices @ >
;

: is-loss? ( -- ? )
	SP @ MAX-TURN >=
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	is-win? IF
		DROP
		#WinScore
	ELSE
		is-loss? IF
			DROP
			#LossScore
		ENDIF
	ENDIF
;

: pices++ ( -- )
	FP ++
;

: turns++ ( -- )
	SP ++
;

' pices++ IS p++
' turns++ IS t++
