VARIABLE	fox-cnt
VARIABLE	is-fox?

DEFER		ZERO
DEFER		FOX

: calc-dir ( 'dir -- )
	BEGIN
		DUP EXECUTE IF
			piece-type FOX = IF
				fox-cnt ++
				transparent? IF
					FALSE
				ELSE
					TRUE
				ENDIF
			ELSE
				FALSE
			ENDIF
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: calc-foxes ( -- n )
	0 fox-cnt !
	here ['] n  calc-dir to
	here ['] s  calc-dir to
	here ['] w  calc-dir to
	here ['] e  calc-dir to
	here ['] nw calc-dir to
	here ['] sw calc-dir to
	here ['] ne calc-dir to
	here ['] se calc-dir to
	fox-cnt @
;

: setup-drop ( -- )
	empty? verify
	drop
	add-move
;

: normal-drop ( -- )
	friend? NOT verify
	enemy? is-fox? !
	drop
	is-fox? @ IF
		FOX
	ELSE
		calc-foxes
		ZERO +
	ENDIF
	create-piece-type
	add-move
;

{moves fox-moves
	{move} setup-drop	{move-type} setup
	{move} normal-drop	{move-type} normal
moves}

{pieces
	{piece}		d0
	{piece}		d1
	{piece}		d2
	{piece}		d3
	{piece}		d4
	{piece}		d5
	{piece}		d6
	{piece}		d7
	{piece}		d8

	{piece}		fox	{drops} fox-moves
pieces}

' d0	IS ZERO
' fox	IS FOX
