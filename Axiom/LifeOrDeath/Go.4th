19		CONSTANT	R
19		CONSTANT	C
R C *		CONSTANT	SIZE

VARIABLE	move-pos
VARIABLE	curr-pos
VARIABLE	size-pos
VARIABLE	size-start
VARIABLE	size-captured
VARIABLE	is-killed?
VARIABLE	is-safe?
VARIABLE	is-ko?

SIZE []		position[]
SIZE []		captured[]
4    []		starts[]

DEFER		KO
DEFER		CHECK-MOVE

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

: my-empty? ( -- ? )
	empty? DUP NOT IF
		DROP
		piece-type KO =
	ENDIF
;

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

: check-starts ( pos -- )
	size-start @
	BEGIN
		1-
		DUP 0 >= IF
			OVER OVER starts[] @ = IF
				-1 OVER starts[] !
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	2DROP
;

: check-pos ( -- )
	my-empty? IF
		here move-pos @ <> IF	
			FALSE is-killed? !
		ENDIF
	ELSE
		enemy? IF
			here DUP check-starts add-pos
		ENDIF
	ENDIF
;

: capture-pos ( -- )
	0 BEGIN
		size-captured @ SIZE < IF
			DUP position[] @ size-captured @ captured[] !
			size-captured ++
		ENDIF
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
		here size-start @ starts[] !
		size-start ++
	ELSE
		TRUE is-safe? !
		FALSE is-ko? !
	ENDIF
;

: scan-starts ( -- )
	size-start @
	BEGIN
		1-
		DUP 0 >= IF
			DUP starts[] @ DUP 0< IF
				DROP
			ELSE
				scan-pos
				is-killed? @ IF
					TRUE is-safe? !
				ENDIF
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	DROP
;

: capture-all ( -- )
	size-captured @
	BEGIN
		1-
		DUP 0 >= IF
			DUP captured[] @ 
			size-captured @ 1 = is-ko? @ AND IF
				KO SWAP create-piece-type-at
			ELSE
				capture-at
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	DROP
;

: clear-ko ( -- )
	SIZE BEGIN
		1-
		DUP 0 >= IF
			DUP empty-at? NOT IF
				DUP piece-type-at KO = IF
					DUP capture-at
				ENDIF
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	DROP
;

: drop-stone ( -- )
	empty? CHECK-MOVE AND IF
		here move-pos !
		drop
		clear-ko
		0 size-start !
		FALSE is-safe? !
		TRUE is-ko? !
		here
		DUP to North IF	check-dir ENDIF
		DUP to South IF	check-dir ENDIF
		DUP to East  IF	check-dir ENDIF
		DUP to West  IF	check-dir ENDIF
		0 size-captured !
		scan-starts
		capture-all
		to
		is-safe? @ IF
			add-move
		ENDIF
	ENDIF
;

: check-move ( -- ? )
	TRUE
;

{moves drop-moves
	{move} drop-stone
moves}

{pieces
	{piece}		Stone	{drops} drop-moves
	{piece}		Ko
pieces}

' Ko	 		IS KO
' check-move		IS CHECK-MOVE

{turn-order
	{repeat}
	{turn}	Black
	{turn}	White
turn-order}
