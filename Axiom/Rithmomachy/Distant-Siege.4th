LOAD Rithmomachy.4th

: ds-check-siege-od ( 'dir -- )
	EXECUTE IF
		predict-move
		on-board? friend? AND IF
			2 get-eruption-values
		ENDIF
		to
	ENDIF
;

: ds-check-siege-dd ( 'dir -- )
	EXECUTE IF
		predict-move
		on-board? friend? AND IF
			ROUND get-attacking-values
			ROUND check-equality-piece
		ENDIF
		to
	ENDIF
;

: ds-check-direction ( 'dir n -- )
	BEGIN
		1-
		OVER EXECUTE on-board? AND IF
			predict-move
			friend? IF
				to
				siege-counter --
				DROP 0
			ELSE
				to
				enemy? IF
					DROP 0
				ENDIF
			ENDIF
		ELSE
			siege-counter --
			DROP 0
		ENDIF
		DUP 0=
	UNTIL
	2DROP
;

: is-piece-type-equal? ( piece-type basic-type -- ? )
	SWAP
	DUP PYRAMID > IF
		DROP
		PYRAMID =
	ELSE
		DUP SQUARE > IF
			DROP
			SQUARE =
		ELSE
			TRIANGLE > IF
				TRIANGLE =
			ELSE
				ROUND =
			ENDIF
		ENDIF
	ENDIF
;

: check-siege-piece ( piece-type -- ? )
	4 siege-counter !
	here
		OVER ROUND is-piece-type-equal? IF
			DUP to ['] Northeast 1 ds-check-direction
			DUP to ['] Southeast 1 ds-check-direction
			DUP to ['] Northwest 1 ds-check-direction
			DUP to ['] Southwest 1 ds-check-direction
		ENDIF
		OVER TRIANGLE is-piece-type-equal? IF
			DUP to ['] North 2 ds-check-direction
			DUP to ['] South 2 ds-check-direction
			DUP to ['] West  2 ds-check-direction
			DUP to ['] East  2 ds-check-direction
		ENDIF
		OVER SQUARE is-piece-type-equal? IF
			DUP to ['] North 3 ds-check-direction
			DUP to ['] South 3 ds-check-direction
			DUP to ['] West  3 ds-check-direction
			DUP to ['] East  3 ds-check-direction
		ENDIF
	to DROP
	siege-counter @ 0=
;

: del-current-position ( pos -- )
	current-count @
	BEGIN
		1- DUP 0> IF
			OVER OVER current-positions[] @ = IF
				-1 OVER current-positions[] !
				TRUE
			ELSE
				FALSE
			ENDIF
		ELSE
			TRUE
		ENDIF
	UNTIL
	2DROP
;

: ds-check-siege ( pos -- )
	DUP piece-type-at PYRAMID > IF
		here a1 to
		BEGIN
			FALSE is-captured? !
			enemy-p IF
				piece-type OVER here SWAP to
				SWAP check-siege-piece IF
					TRUE is-captured? !
				ENDIF
				to
				is-captured? @ IF
					capture
					here del-current-position
				ENDIF
				FALSE
			ELSE
				TRUE
			ENDIF
		UNTIL
		to
		FALSE is-captured? !
	ELSE
		DUP piece-type-at check-siege-piece IF
			TRUE is-captured? !
		ENDIF
	ENDIF
	DUP to ['] North     ds-check-siege-od
	DUP to ['] South     ds-check-siege-od
	DUP to ['] West      ds-check-siege-od
	DUP to ['] East      ds-check-siege-od
	DUP to ['] Northeast ds-check-siege-dd
	DUP to ['] Southeast ds-check-siege-dd
	DUP to ['] Northwest ds-check-siege-dd
	DUP to ['] Southwest ds-check-siege-dd
	to
;

' ds-check-siege IS check-siege
