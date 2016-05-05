: my-enemy? ( n -- ? )
	current-player Light = IF 
		3 
	ELSE 
		4 
	ENDIF
	SWAP is-player?
;

: OnEvaluate ( -- score )
	0 ALL BEGIN
		1-
		DUP empty-at? NOT OVER piece-at piece-value 0> AND IF
			DUP piece-at piece-value
			DUP calc-rang
			SWAP my-enemy? IF
				NEGATE
			ENDIF
			ROT + SWAP
		ENDIF
		DUP 0=
	UNTIL DROP
;

: OnNewGame ( -- )
	RANDOMIZE
;
