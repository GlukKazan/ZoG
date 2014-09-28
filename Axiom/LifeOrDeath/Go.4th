19		CONSTANT	R
19		CONSTANT	C
R C *		CONSTANT	SIZE

VARIABLE	move-pos
VARIABLE	curr-pos
VARIABLE	size-pos
VARIABLE	is-killed?
VARIABLE	is-safe?

SIZE []		position[]

{board
	R C {grid}
board}

{directions
	-1  0  {direction} North
	 1  0  {direction} South
	 0  1  {direction} East
	 0 -1  {direction} West
directions}

{players
	{player}	Black
	{player}	White
players}

: clear-pos ( -- )
	0 size-pos !
;

: add-pos ( pos -- )
	size-pos @
	BEGIN
		1-
		DUP 0< size-pos @ SIZE < AND IF
			OVER size-pos @ position[] !
			size-pos ++
			TRUE
		ELSE
			OVER OVER position[] @ = IF
				TRUE
			ELSE
				FALSE
			ENDIF
		ENDIF
	UNTIL
	2DROP
;

: check-pos ( -- )
	empty? IF
		here move-pos @ <> IF	
			FALSE is-killed? !
		ENDIF
	ELSE
		enemy? IF
			here add-pos
		ENDIF
	ENDIF
;

: capture-pos ( -- )
	0 BEGIN
		DUP position[] @ capture-at
		1+ DUP size-pos @ >=
	UNTIL
	DROP
;

: scan-pos ( pos -- )
	TRUE is-killed? !
	clear-pos add-pos
	0 BEGIN
		DUP position[] @
		DUP to North IF	check-pos ENDIF
		DUP to South IF	check-pos ENDIF
		DUP to East  IF	check-pos ENDIF
		    to West  IF check-pos ENDIF
		1+ DUP size-pos @ >=
	UNTIL
	DROP
	is-killed? @ IF
		capture-pos
	ENDIF	
;

: check-dir ( -- )
	enemy? IF
		here DUP scan-pos to
		is-killed? @ IF
			TRUE is-safe? !
		ENDIF
	ELSE
		TRUE is-safe? !
	ENDIF
;

: drop-stone ( -- )
	empty? IF
		here move-pos !
		drop
		FALSE is-safe? !
		here
		DUP to North IF	check-dir ENDIF
		DUP to South IF	check-dir ENDIF
		DUP to East  IF	check-dir ENDIF
		DUP to West  IF	check-dir ENDIF
		to
		is-safe? @ IF
			add-move
		ENDIF
	ENDIF
;

{moves drop-moves
	{move} drop-stone
moves}

{pieces
	{piece}		Stone	{drops} drop-moves
pieces}

{turn-order
	{repeat}
	{turn}	Black
	{turn}	White
turn-order}
