VARIABLE	score

: check-score ( 'op 'dir -- ? )
	EXECUTE IF
		EXECUTE IF
			score ++
			FALSE
		ELSE
			TRUE
		ENDIF
	ELSE
		DROP TRUE
	ENDIF
;

: calc-dame ( 'op -- )
	0 BEGIN
		DUP empty-at? IF
			DUP to OVER ['] n check-score IF
				DUP to OVER ['] s check-score IF
					DUP to OVER ['] w check-score IF
						DUP to OVER ['] e check-score
						DROP
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		1+ DUP PLANE >=
	UNTIL 2DROP
;

: calc-captured ( -- )
	WC @ BC @ -
	for-player W = current-player W = OR IF
		NEGATE
	ENDIF
	10 * score +!
;

: OnEvaluate ( -- score )
	0 score !
	['] my-enemy? calc-dame
	score @ NEGATE score !
	['] my-friend? calc-dame
	calc-captured
	score @
;
