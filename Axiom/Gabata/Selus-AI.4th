VARIABLE	first-count
VARIABLE	second-count
VARIABLE	no-moves?

: count-pieces ( -- )
	TRUE no-moves? !
	h2 get-value-at first-count !
	a2 get-value-at second-count !
	h1 BEGIN
		1-
		DUP on-board-at? OVER empty-at? NOT AND IF
			DUP piece-type-at TRAP >= IF
				DUP player-at First = IF
					DUP get-value-at
					first-count @ +
					first-count !
				ENDIF
				DUP player-at Second = IF
					DUP get-value-at
					second-count @ +
					second-count !
				ENDIF
			ELSE
				FALSE no-moves? !
			ENDIF
		ENDIF
		DUP 0=
	UNTIL DROP
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	count-pieces no-moves? @ IF
		first-count @ second-count @ > IF
			current-player First = IF
				DROP #WinScore
			ELSE
				DROP #LossScore
			ENDIF
		ELSE
			first-count @ second-count @ < IF
				current-player Second = IF
					DROP #WinScore
				ELSE
					DROP #LossScore
				ENDIF
			ELSE
				DROP #DrawScore
			ENDIF
		ENDIF
	ENDIF
;


: OnEvaluate ( -- score )
	count-pieces
	first-count @ second-count @ -
	current-player Second = IF NEGATE ENDIF
;
