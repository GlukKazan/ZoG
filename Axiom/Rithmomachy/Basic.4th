LOAD Rithmomachy.4th

: basic-check-siege ( pos -- )
	4 siege-counter !
	DUP to ['] North check-siege-od
	DUP to ['] South check-siege-od
	DUP to ['] West  check-siege-od
	DUP to ['] East  check-siege-od
	siege-counter @ 0= IF
		TRUE is-captured? !
	ENDIF
	4 siege-counter !
	DUP to ['] Northeast check-siege-dd
	DUP to ['] Southeast check-siege-dd
	DUP to ['] Northwest check-siege-dd
	DUP to ['] Southwest check-siege-dd
	siege-counter @ 0= IF
		TRUE is-captured? !
	ENDIF
	to
;

' basic-check-siege IS check-siege
