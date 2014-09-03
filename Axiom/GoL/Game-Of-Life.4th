19	CONSTANT	R
19	CONSTANT	C
R C *	CONSTANT	SIZE
SIZE	CONSTANT	MAXS

VARIABLE		w-neighbors
VARIABLE		b-neighbors
VARIABLE		new-cnt
VARIABLE		curr-pos

SIZE	[]		new-pos[]
SIZE	[]		new-player[]

DEFER			STONE

{board
	R C {grid}
board}

{directions
	-1  0  {direction} North
	 1  0  {direction} South
	 0  1  {direction} East
	 0 -1  {direction} West
	-1  1  {direction} Northeast
	 1  1  {direction} Southeast
	-1 -1  {direction} Northwest
	 1 -1  {direction} Southwest
directions}

{players
	{neutral}	?E
	{player}	B	{random}
	{player}	W	{random}
players}

: my-empty? ( -- ? )
	here curr-pos @ = IF
		FALSE
	ELSE
		empty?
	ENDIF
;

: my-player ( -- player )
	here curr-pos @ = IF
		current-player
	ELSE
		player
	ENDIF
;

: calc-direction ( 'dir -- )
	EXECUTE IF
		my-empty? NOT IF
			my-player B = IF
				b-neighbors ++
			ENDIF
			my-player W = IF
				w-neighbors ++
			ENDIF
		ENDIF
	ENDIF
;

: calc-neighbors ( pos -- )
	0 w-neighbors !
	0 b-neighbors !
	DUP to ['] North     calc-direction
	DUP to ['] South     calc-direction
	DUP to ['] West      calc-direction
	DUP to ['] East	     calc-direction
	DUP to ['] Northeast calc-direction
	DUP to ['] Southeast calc-direction
	DUP to ['] Northwest calc-direction
	DUP to ['] Southwest calc-direction
	to
;

: gen-move ( pos player -- )
	new-cnt @ MAXS < IF
		new-cnt @ new-player[] !
		new-cnt @ new-pos[] !
		new-cnt ++
	ELSE
		2DROP
	ENDIF
;

: life-tick ( -- )
	here
	SIZE
	BEGIN
		1-
		DUP calc-neighbors
		w-neighbors @ b-neighbors @ +
		my-empty? IF
			DUP 3 = IF
				here
				w-neighbors @ b-neighbors @ > IF W ELSE	B ENDIF
				gen-move
			ENDIF
		ELSE
			DUP 2 < OVER 3 > OR IF
				here ?E gen-move
			ELSE
				w-neighbors @ b-neighbors @ > IF
					my-player W <> IF
						here W gen-move
					ENDIF
				ENDIF
				b-neighbors @ w-neighbors @ > IF
					my-player B <> IF
						here B gen-move
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		DROP
		DUP 0=
	UNTIL
	DROP
	to
;

: exec-moves ( -- )
	BEGIN
		new-cnt --
		new-cnt @ new-player[] @
		DUP ?E = IF
			DROP
			new-cnt @ new-pos[] @
			capture-at
		ELSE
			STONE
			new-cnt @ new-pos[] @
			create-player-piece-type-at
		ENDIF
		new-cnt @ 0=
	UNTIL
;

: drop-stone ( -- )
	empty? IF
		SIZE curr-pos !
		here calc-neighbors
		w-neighbors @ b-neighbors @ + 0> IF
			0 new-cnt !
			here curr-pos !
			drop
			life-tick
			new-cnt @ 0> IF
				exec-moves
			ENDIF
			add-move
		ENDIF
	ENDIF
;

: OnNewGame ( -- )
	RANDOMIZE
;

: OnIsGameOver ( -- gameResult )
	#WinScore
	SIZE
	BEGIN
		1-
		DUP enemy-at? IF
			SWAP DROP
			#LossScore
			SWAP
		ENDIF
		DUP 0=
	UNTIL
	DROP
	SIZE
	BEGIN
		1-
		DUP friend-at? IF
			SWAP DROP
			#UnknownScore
			SWAP
		ENDIF
		DUP 0=
	UNTIL
	DROP
;

{moves drop-moves
	{move} drop-stone
moves}

{pieces
	{piece}	S {drops} drop-moves
pieces}

' S	IS STONE

{turn-order
	{turn}	B
	{turn}	W
turn-order}

{board-setup
	{setup}	B S d3
	{setup}	B S c5
	{setup}	B S e5
	{setup}	B S i10
	{setup}	B S k10
	{setup}	B S o4
	{setup}	B S p4
	{setup}	B S q4
	{setup}	B S o15
	{setup}	B S p17
	{setup}	B S q15

	{setup}	W S c4
	{setup}	W S d15
	{setup}	W S d16
	{setup}	W S d17
	{setup}	W S e4
	{setup}	W S d6
	{setup}	W S j9
	{setup}	W S j11
	{setup}	W S p14
	{setup}	W S o16
	{setup}	W S q16
board-setup}
