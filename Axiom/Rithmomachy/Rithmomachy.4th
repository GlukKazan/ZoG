16	CONSTANT	ROWS
12	CONSTANT	COLS
34	CONSTANT	MAXV
8	CONSTANT	MAXS
30	CONSTANT	MAXE
15	CONSTANT	WINC
1315	CONSTANT	WINW
984	CONSTANT	WINB

{board
	ROWS 	COLS	{grid}
	{variable}	WhitePieces
	{variable}	BlackPieces
	{variable}	WhiteValues
	{variable}	BlackValues
board}

{directions
	 ( common )
	-1  0  {direction} North
	 1  0  {direction} South
	 0  1  {direction} East
	 0 -1  {direction} West
	-1  1  {direction} Northeast
	 1  1  {direction} Southeast
	-1 -1  {direction} Northwest
	 1 -1  {direction} Southwest

	 ( friend-p )
	 {link} friend-p a1  l1	{link} friend-p l1  l2	{link} friend-p l2  l3
	 {link} friend-p l3  l4	{link} friend-p l4  l5	{link} friend-p l5  l6

	 ( enemy-p )
	 {link} enemy-p a1  a16	{link} enemy-p a16 a15	{link} enemy-p a15 a14
	 {link} enemy-p a14 a13	{link} enemy-p a13 a12	{link} enemy-p a12 a11
directions}

{players
	{player}	White
	{player}	Black
players}

{turn-order
	{turn}		White
	{turn}		Black
turn-order}

{symmetries
	Black		{symmetry} friend-p enemy-p
symmetries}

DEFER		ROUND
DEFER		TRIANGLE
DEFER		SQUARE
DEFER		PYRAMID

VARIABLE	is-friend?
VARIABLE	is-captured?
VARIABLE	is-diagonal-checking?
VARIABLE	siege-counter
VARIABLE	attacking-sum
VARIABLE	attacked-cnt
VARIABLE	value-1
VARIABLE	value-2
VARIABLE	attacking-count
VARIABLE	current-count
VARIABLE	eruption-count

MAXV []		attacking-values[]
MAXS []		current-positions[]
MAXS []		current-values[]
MAXS []		eruption-values[]

: WhitePieces++ WhitePieces ++ ;
: BlackPieces++ BlackPieces ++ ;
: WhiteValues++ WhiteValues ++ ;
: BlackValues++ BlackValues ++ ;

: ChangePieces ( pos -- )
	DUP piece piece-value SWAP
	player-at White = IF
		COMPILE WhitePieces++
		BEGIN
			1-
			COMPILE WhiteValues++
			DUP 0> NOT
		UNTIL
		DROP
	ELSE
		COMPILE BlackPieces++
		BEGIN
			1-
			COMPILE BlackValues++
			DUP 0> NOT
		UNTIL
		DROP
	ENDIF
;

: get-x ( pos -- x )
	COLS MOD
;

: on-board-at? ( pos -- ? )
	get-x DUP
	1 > SWAP 10 < AND
;

: on-board? ( -- ? )
	here on-board-at?
;

: is-pyramid-at? ( pos -- ? )
	DUP not-empty-at? IF
		DUP friend-at? is-friend? !
		piece PYRAMID >
	ELSE
		DROP FALSE
	ENDIF
;

: is-piece-type? ( piece-type -- ? )
	not-empty? IF
		piece-type PYRAMID > IF
			PYRAMID =
		ELSE
			piece-type SQUARE > IF
				SQUARE =
			ELSE
				piece-type TRIANGLE > IF
					TRIANGLE =
				ELSE
					ROUND =
				ENDIF
			ENDIF
		ENDIF
	ELSE
		DROP FALSE
	ENDIF
;

: sum-pyramid-values ( -- sum )
	here
	DUP is-pyramid-at? IF
		a1 to 0
		BEGIN
			is-friend? @ IF
				friend-p
			ELSE
				enemy-p
			ENDIF
			IF
				not-empty? IF
					piece piece-value +
				ENDIF
				FALSE
			ELSE
				TRUE
			ENDIF
		UNTIL
		SWAP to
	ELSE
		DROP 0
	ENDIF
;

: capture-piece ( -- )
	current-count @
	BEGIN
		1- DUP 0> IF
			DUP current-positions[] @
			DUP 0> IF
				DUP enemy-at? IF
					DUP ChangePieces
					capture-at
				ELSE
					DROP
				ENDIF
			ELSE
				DROP
			ENDIF
			FALSE
		ELSE
			DUP current-positions[] @
			DUP enemy-at? IF
				current-count @ 1 = IF
					DUP ChangePieces
				ENDIF
				capture-at
			ELSE
				DROP
			ENDIF
			TRUE
		ENDIF
	UNTIL
	DROP
;

: get-eruption-values ( n -- )
	PYRAMID is-piece-type? IF
		eruption-count @ MAXE < IF
			DUP sum-pyramid-values *
			eruption-count @ eruption-values[] !
			eruption-count ++
		ENDIF
		here a1 to
		BEGIN
			friend-p IF
				not-empty? eruption-count @ MAXE < AND IF
					DUP piece piece-value *
					eruption-count @ eruption-values[] !
					eruption-count ++
				ENDIF				         
				FALSE
			ELSE
				TRUE
			ENDIF
		UNTIL
		to
		DROP
	ELSE
		eruption-count @ MAXE < IF
			piece piece-value *
			eruption-count @ eruption-values[] !
			eruption-count ++
		ENDIF
	ENDIF
;

: get-attacking-values ( piece-type -- )
	PYRAMID is-piece-type? IF
		attacking-count @ MAXV < IF
			sum-pyramid-values
			attacking-count @ attacking-values[] !
			attacking-count ++
		ENDIF
		here a1 to
		BEGIN
			friend-p IF
				not-empty? attacking-count @ MAXV < AND IF
					OVER is-piece-type? IF
						piece piece-value
						attacking-count @ attacking-values[] !
						attacking-count ++
					ENDIF
				ENDIF				         
				FALSE
			ELSE
				TRUE
			ENDIF
		UNTIL
		to
	ELSE
		is-piece-type? attacking-count @ MAXV < AND IF
			piece piece-value
			attacking-count @ attacking-values[] !
			attacking-count ++
		ENDIF
	ENDIF
;

: capture-equality-pieces ( value -- )
	current-count 1 > IF
		0 attacked-cnt !
	ELSE
		1 attacked-cnt !
	ENDIF
	current-count @
	BEGIN
		1- DUP 0> IF
			OVER OVER current-values[] @ = IF
				DUP current-positions[] @
				DUP 0= IF
					DROP
				ELSE
					DUP enemy-at? IF
						DUP ChangePieces
						capture-at
					ELSE
						DROP
					ENDIF
					0 OVER current-positions[] !
				ENDIF
			ELSE
				attacked-cnt ++
			ENDIF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
	DROP
	IF current-count 0> IF
		0 current-values[] @ = IF
			TRUE is-captured? !
		ENDIF
	ELSE
		DROP
	ENDIF
	attacked-cnt @ 0= IF
		TRUE is-captured? !
	ENDIF
;

: check-equality-piece ( piece-type -- )
	0 attacking-sum !
	PYRAMID is-piece-type? IF
		here a1 to
		BEGIN
			friend-p IF
				not-empty? IF
					piece piece-value
					DUP attacking-sum @ + attacking-sum !
					capture-equality-pieces
				ENDIF
				FALSE
			ELSE
				TRUE
			ENDIF
		UNTIL
		to
		attacking-sum @ 0> IF
			attacking-sum @
			capture-equality-pieces
		ENDIF
	ELSE
		is-piece-type? IF
			piece piece-value
			capture-equality-pieces
		ENDIF
	ENDIF
;

: check-siege-od ( 'dir -- )
	EXECUTE IF
		on-board? NOT friend? OR IF
			siege-counter --
		ENDIF
		on-board? friend? AND IF
			2 get-eruption-values
		ENDIF
	ELSE
		siege-counter --
	ENDIF
;

: check-siege-dd ( 'dir -- )
	EXECUTE IF
		on-board? NOT friend? OR IF
			siege-counter --
		ENDIF
                on-board? friend? AND IF
			ROUND get-attacking-values
			ROUND check-equality-piece
			is-diagonal-checking? @ IF
				2 get-eruption-values
			ENDIF
		ENDIF
	ELSE
		siege-counter --
	ENDIF
;

: check-siege ( pos -- )
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

: count-to-piece-type ( count -- piece-type )
	0= IF
		SQUARE
	ELSE
		TRIANGLE
	ENDIF
;

: count-to-factor ( count -- n )
	0= IF
		4
	ELSE
		3
	ENDIF
;

: check-equality-dd ( 'second-dir count 'first-dir -- )
	EXECUTE on-board? AND IF
		BEGIN
			1- 0< IF
				TRUE			
			ELSE
				OVER EXECUTE on-board? AND IF
					enemy? IF
						DUP count-to-factor get-eruption-values
						DUP count-to-piece-type
						DUP get-attacking-values
						check-equality-piece
					ENDIF
	                                FALSE
				ELSE
					TRUE
				ENDIF
			ENDIF
		UNTIL
		2DROP
	ENDIF
;

: check-equality-od ( 'second-dir count 'first-dir -- )
	EXECUTE on-board? AND empty? AND IF
		BEGIN
			1- 0< IF
				TRUE			
			ELSE
				OVER EXECUTE on-board? AND IF
					enemy? IF
						is-diagonal-checking? @ IF
							DUP count-to-factor get-eruption-values
						ENDIF
						DUP count-to-piece-type
						DUP get-attacking-values
						check-equality-piece
						TRUE
					ELSE
						not-empty?
					ENDIF
				ELSE
					TRUE
				ENDIF
			ENDIF
		UNTIL
		2DROP
	ENDIF
;

: check-equality ( pos -- )
	DUP to ['] North 2 ['] North     check-equality-od
	DUP to ['] North 2 ['] Northwest check-equality-dd
	DUP to ['] North 2 ['] Northeast check-equality-dd
	DUP to ['] South 2 ['] South     check-equality-od
	DUP to ['] South 2 ['] Southwest check-equality-dd
	DUP to ['] South 2 ['] Southeast check-equality-dd
	DUP to ['] West  2 ['] West      check-equality-od
	DUP to ['] West  2 ['] Northwest check-equality-dd
	DUP to ['] West  2 ['] Southwest check-equality-dd
	DUP to ['] East  2 ['] East      check-equality-od
	DUP to ['] East  2 ['] Northeast check-equality-dd
	DUP to ['] East  2 ['] Southeast check-equality-dd
	to
;

: check-ambush-prod ( value -- ? )
	value-1 @ value-2 @ * OVER = IF
		DROP TRUE
	ELSE
		DUP value-1 @ * value-2 @ = IF
			DROP TRUE
		ELSE
			value-2 @ * value-1 @ = IF
				TRUE
			ELSE
				FALSE
			ENDIF
		ENDIF
	ENDIF
;

: check-ambush-cond ( value -- ? )
	value-1 @ value-2 @ + OVER = IF
		DROP TRUE
	ELSE
		DUP value-1 @ + value-2 @ = IF
			DROP TRUE
		ELSE
			DUP value-2 @ + value-1 @ = IF
				DROP TRUE
			ELSE
				check-ambush-prod
			ENDIF
		ENDIF
	ENDIF
;

: check-ambush-pair ( -- )
	current-count @
	BEGIN
		1-
		DUP current-positions[] @ 0<> IF
			DUP current-values[] @ check-ambush-cond IF
				DUP 0> IF
					DUP current-positions[] @ 
					DUP enemy-at? IF
						DUP ChangePieces
						capture-at
					ELSE
						DROP
					ENDIF
					0 OVER current-positions[] !
				ELSE
					TRUE is-captured? !
				ENDIF
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	DROP
;

: check-ambush ( -- )
	attacking-count @
	BEGIN
		1-
		attacking-count @
		BEGIN
			1-
			2DUP < IF
				2DUP 
				attacking-values[] @ value-1 !
				attacking-values[] @ value-2 !
				check-ambush-pair
			ENDIF
			DUP 0> NOT
		UNTIL
		DROP
		DUP 0> NOT
	UNTIL
	DROP
;

: fill-eruption-values ( 'dir pos n -- )
	value-1 ! to 1
	BEGIN
		1+ OVER EXECUTE IF
			on-board? friend? AND DUP value-1 @ > AND IF
				DUP get-eruption-values
			ENDIF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
	2DROP
;

: check-eruption-pair ( -- )
	current-count @
	BEGIN
		1-
		DUP current-positions[] @ 0<> IF
			DUP current-values[] @ value-1 @ = IF
				DUP 0> IF
					DUP current-positions[] @ 
					DUP enemy-at? IF
						DUP ChangePieces
						capture-at
					ELSE
						DROP
					ENDIF
					0 OVER current-positions[] !
				ELSE
					TRUE is-captured? !
				ENDIF
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	DROP
;

: check-eruption-values ( -- )
	eruption-count @
	BEGIN
		1-
		DUP eruption-values[] @ value-1 !
		check-eruption-pair
		DUP 0> NOT
	UNTIL
	DROP
;

: check-eruption ( pos -- )
	['] North OVER 4 fill-eruption-values
	['] South OVER 4 fill-eruption-values
	['] West  OVER 4 fill-eruption-values
	['] East  OVER 4 fill-eruption-values
	is-diagonal-checking? @ IF
		['] Northeast OVER 2 fill-eruption-values
		['] Southeast OVER 2 fill-eruption-values
		['] Northwest OVER 2 fill-eruption-values
		['] Southwest OVER 2 fill-eruption-values
	ENDIF
	to check-eruption-values
;

: fill-current ( pos -- )
	1 current-count !
	DUP 0 current-positions[] !
	DUP piece-type-at PYRAMID > IF
		a1 to 0
		BEGIN
			enemy-p IF
				not-empty? IF
					piece piece-value
					current-count MAXS < IF
						here current-count @ current-positions[] !
						DUP  current-count @ current-values[] !
						current-count ++
					ENDIF
					+
				ENDIF
				FALSE
			ELSE
				TRUE
			ENDIF
		UNTIL
	ELSE
		DUP piece piece-value
	ENDIF
	0 current-values[] !
	to
;

: capture-all ( -- )
	here ROWS COLS *
	BEGIN
		1-
		DUP on-board-at? enemy? AND IF
			0 attacking-count  !
			0 eruption-count   !
			FALSE is-captured? !
			fill-current
			DUP check-siege
			is-captured? @ NOT IF
				DUP check-equality
			ENDIF
			is-captured? @ NOT IF
				check-ambush
			ENDIF
			is-captured? @ NOT IF
				DUP check-eruption
			ENDIF
			is-captured? @ IF
				DUP to capture-piece
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL
	DROP to
;

: leap-0 ( 'leap-dir ? -- )
	IF
		EXECUTE IF
			on-board? empty? AND IF
				from
				here
				move
				capture-all
				add-move
			ENDIF
		ENDIF
	ELSE
		DROP
	ENDIF
;

: leap-n ( 'leap-dir 'shift-dir count ? -- )
	IF
		BEGIN
			OVER EXECUTE IF
				on-board? IF
					1- DUP 0> IF
						FALSE
					ELSE
						2DROP TRUE TRUE
					ENDIF
				ELSE
					2DROP FALSE TRUE
				ENDIF
			ELSE
				2DROP FALSE TRUE
			ENDIF
		UNTIL
		IF
			EXECUTE IF
				on-board? empty? AND IF
					from
					here
					move
					capture-all
					add-move
				ENDIF
			ENDIF
		ELSE
			DROP
		ENDIF
	ELSE
		2DROP DROP
	ENDIF
;

: shift-n ( 'shift-dir count ? -- )
	IF
		BEGIN
			OVER EXECUTE IF
				on-board? empty? AND IF
					1- DUP 0> IF
						FALSE
					ELSE
						2DROP TRUE TRUE
					ENDIF
				ELSE
					2DROP FALSE TRUE
				ENDIF
			ELSE
				2DROP FALSE TRUE
			ENDIF
		UNTIL
		IF
			from
			here
			move
			capture-all
			add-move
		ENDIF
	ELSE
		2DROP
	ENDIF
;

: is-correct-type? ( piece-type -- ? )
	not-empty? IF
		piece PYRAMID > IF
			here SWAP a1 to
			BEGIN
				friend-p IF
					DUP is-piece-type? IF
						DROP TRUE TRUE
					ELSE
						FALSE
					ENDIF
				ELSE
					DROP FALSE TRUE
				ENDIF
			UNTIL
			SWAP to
		ELSE
			DROP FALSE
		ENDIF
	ELSE
		DROP FALSE
	ENDIF
;

: OnNewGame ( -- )
	TRUE is-diagonal-checking? !
	RANDOMIZE
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	current-player White = IF
		WhitePieces @ WINC >= IF
			DROP
			#LossScore
		ENDIF
		WhiteValues @ WINW >= IF
			DROP
			#LossScore
		ENDIF
	ENDIF
	current-player Black = IF
		BlackPieces @ WINC >= IF
			DROP
			#LossScore
		ENDIF
		BlackValues @ WINB >= IF
			DROP
			#LossScore
		ENDIF
	ENDIF
;

: r-move-ne ( -- ) ['] Northeast TRUE leap-0 ;
: r-move-se ( -- ) ['] Southeast TRUE leap-0 ;
: r-move-nw ( -- ) ['] Northwest TRUE leap-0 ;
: r-move-sw ( -- ) ['] Southeast TRUE leap-0 ;

: pr-move-ne ( -- ) ['] Northeast ROUND is-correct-type? leap-0 ;
: pr-move-se ( -- ) ['] Southeast ROUND is-correct-type? leap-0 ;
: pr-move-nw ( -- ) ['] Northwest ROUND is-correct-type? leap-0 ;
: pr-move-sw ( -- ) ['] Southeast ROUND is-correct-type? leap-0 ;

: t-move-n ( -- ) ['] North 2 TRUE shift-n ;
: t-move-s ( -- ) ['] South 2 TRUE shift-n ;
: t-move-w ( -- ) ['] West  2 TRUE shift-n ;
: t-move-e ( -- ) ['] East  2 TRUE shift-n ;

: pt-move-n ( -- ) ['] North 2 TRIANGLE is-correct-type? shift-n ;
: pt-move-s ( -- ) ['] South 2 TRIANGLE is-correct-type? shift-n ;
: pt-move-w ( -- ) ['] West  2 TRIANGLE is-correct-type? shift-n ;
: pt-move-e ( -- ) ['] East  2 TRIANGLE is-correct-type? shift-n ;

: t-move-nw ( -- ) ['] Northwest ['] North 1 TRUE leap-n ;
: t-move-ne ( -- ) ['] Northeast ['] North 1 TRUE leap-n ;
: t-move-sw ( -- ) ['] Southwest ['] South 1 TRUE leap-n ;
: t-move-se ( -- ) ['] Southeast ['] South 1 TRUE leap-n ;
: t-move-wn ( -- ) ['] Northwest ['] West  1 TRUE leap-n ;
: t-move-ws ( -- ) ['] Southwest ['] West  1 TRUE leap-n ;
: t-move-en ( -- ) ['] Northeast ['] East  1 TRUE leap-n ;
: t-move-es ( -- ) ['] Southeast ['] East  1 TRUE leap-n ;

: pt-move-nw ( -- ) ['] Northwest ['] North 1 TRIANGLE is-correct-type? leap-n ;
: pt-move-ne ( -- ) ['] Northeast ['] North 1 TRIANGLE is-correct-type? leap-n ;
: pt-move-sw ( -- ) ['] Southwest ['] South 1 TRIANGLE is-correct-type? leap-n ;
: pt-move-se ( -- ) ['] Southeast ['] South 1 TRIANGLE is-correct-type? leap-n ;
: pt-move-wn ( -- ) ['] Northwest ['] West  1 TRIANGLE is-correct-type? leap-n ;
: pt-move-ws ( -- ) ['] Southwest ['] West  1 TRIANGLE is-correct-type? leap-n ;
: pt-move-en ( -- ) ['] Northeast ['] East  1 TRIANGLE is-correct-type? leap-n ;
: pt-move-es ( -- ) ['] Southeast ['] East  1 TRIANGLE is-correct-type? leap-n ;

: s-move-n ( -- ) ['] North 3 TRUE shift ;
: s-move-s ( -- ) ['] South 3 TRUE shift ;
: s-move-w ( -- ) ['] West  3 TRUE shift ;
: s-move-e ( -- ) ['] East  3 TRUE shift ;

: ps-move-n ( -- ) ['] North 3 SQUARE is-correct-type? shift ;
: ps-move-s ( -- ) ['] South 3 SQUARE is-correct-type? shift ;
: ps-move-w ( -- ) ['] West  3 SQUARE is-correct-type? shift ;
: ps-move-e ( -- ) ['] East  3 SQUARE is-correct-type? shift ;

: s-move-nw ( -- ) ['] Northwest ['] North 2 TRUE leap-n ;
: s-move-ne ( -- ) ['] Northeast ['] North 2 TRUE leap-n ;
: s-move-sw ( -- ) ['] Southwest ['] South 2 TRUE leap-n ;
: s-move-se ( -- ) ['] Southeast ['] South 2 TRUE leap-n ;
: s-move-wn ( -- ) ['] Northwest ['] West  2 TRUE leap-n ;
: s-move-ws ( -- ) ['] Southwest ['] West  2 TRUE leap-n ;
: s-move-en ( -- ) ['] Northeast ['] East  2 TRUE leap-n ;
: s-move-es ( -- ) ['] Southeast ['] East  2 TRUE leap-n ;

: ps-move-nw ( -- ) ['] Northwest ['] North 2 SQUARE is-correct-type? leap-n ;
: ps-move-ne ( -- ) ['] Northeast ['] North 2 SQUARE is-correct-type? leap-n ;
: ps-move-sw ( -- ) ['] Southwest ['] South 2 SQUARE is-correct-type? leap-n ;
: ps-move-se ( -- ) ['] Southeast ['] South 2 SQUARE is-correct-type? leap-n ;
: ps-move-wn ( -- ) ['] Northwest ['] West  2 SQUARE is-correct-type? leap-n ;
: ps-move-ws ( -- ) ['] Southwest ['] West  2 SQUARE is-correct-type? leap-n ;
: ps-move-en ( -- ) ['] Northeast ['] East  2 SQUARE is-correct-type? leap-n ;
: ps-move-es ( -- ) ['] Southeast ['] East  2 SQUARE is-correct-type? leap-n ;

{moves r-moves
	{move} r-move-ne
	{move} r-move-se
	{move} r-move-nw
	{move} r-move-sw
moves}

{moves t-moves
	{move} t-move-n
	{move} t-move-s
	{move} t-move-w
	{move} t-move-e
	{move} t-move-nw
	{move} t-move-ne
	{move} t-move-sw
	{move} t-move-se
	{move} t-move-wn
	{move} t-move-ws
	{move} t-move-en
	{move} t-move-es
moves}

{moves s-moves
	{move} s-move-n
	{move} s-move-s
	{move} s-move-w
	{move} s-move-e
	{move} s-move-nw
	{move} s-move-ne
	{move} s-move-sw
	{move} s-move-se
	{move} s-move-wn
	{move} s-move-ws
	{move} s-move-en
	{move} s-move-es
moves}

{moves p-moves
	{move} pr-move-ne
	{move} pr-move-se
	{move} pr-move-nw
	{move} pr-move-sw
	{move} pt-move-n
	{move} pt-move-s
	{move} pt-move-w
	{move} pt-move-e
	{move} pt-move-nw
	{move} pt-move-ne
	{move} pt-move-sw
	{move} pt-move-se
	{move} pt-move-wn
	{move} pt-move-ws
	{move} pt-move-en
	{move} pt-move-es
	{move} ps-move-n
	{move} ps-move-s
	{move} ps-move-w
	{move} ps-move-e
	{move} ps-move-nw
	{move} ps-move-ne
	{move} ps-move-sw
	{move} ps-move-se
	{move} ps-move-wn
	{move} ps-move-ws
	{move} ps-move-en
	{move} ps-move-es
moves}

{pieces
	{piece}		R0	{moves} r-moves	0   {value}
	{piece}		R1	{moves} r-moves	1   {value}
	{piece}		R2	{moves} r-moves	2   {value}
	{piece}		R3	{moves} r-moves	3   {value}
	{piece}		R4	{moves} r-moves	4   {value}
	{piece}		R5	{moves} r-moves	5   {value}
	{piece}		R6	{moves} r-moves	6   {value}
	{piece}		R7	{moves} r-moves	7   {value}
	{piece}		R8	{moves} r-moves	8   {value}
	{piece}		R9	{moves} r-moves	9   {value}
	{piece}		R16	{moves} r-moves	16  {value}
	{piece}		R25	{moves} r-moves	25  {value}
	{piece}		R36	{moves} r-moves	36  {value}
	{piece}		R49	{moves} r-moves	49  {value}
	{piece}		R64	{moves} r-moves	64  {value}
	{piece}		R81	{moves} r-moves	81  {value}
	{piece}		T0	{moves} t-moves	0   {value}
	{piece}		T6	{moves} t-moves	6   {value}
	{piece}		T9	{moves} t-moves	9   {value}
	{piece}		T12	{moves} t-moves	12  {value}
	{piece}		T16	{moves} t-moves	16  {value}
	{piece}		T20	{moves} t-moves	20  {value}
	{piece}		T25	{moves} t-moves	25  {value}
	{piece}		T30	{moves} t-moves	30  {value}
	{piece}		T36	{moves} t-moves	36  {value}
	{piece}		T42	{moves} t-moves	42  {value}
	{piece}		T49	{moves} t-moves	49  {value}
	{piece}		T56	{moves} t-moves	56  {value}
	{piece}		T64	{moves} t-moves	64  {value}
	{piece}		T72	{moves} t-moves	72  {value}
	{piece}		T81	{moves} t-moves	81  {value}
	{piece}		T90	{moves} t-moves	90  {value}
	{piece}		T100	{moves} t-moves	100 {value}
	{piece}		S0	{moves} s-moves	0   {value}
	{piece}		S15	{moves} s-moves	15  {value}
	{piece}		S25	{moves} s-moves	25  {value}
	{piece}		S28	{moves} s-moves	28  {value}
	{piece}		S36	{moves} s-moves	36  {value}
	{piece}		S45	{moves} s-moves	45  {value}
	{piece}		S49	{moves} s-moves	49  {value}
	{piece}		S64	{moves} s-moves	64  {value}
	{piece}		S66	{moves} s-moves	66  {value}
	{piece}		S81	{moves} s-moves	81  {value}
	{piece}		S120	{moves} s-moves	120 {value}
	{piece}		S121	{moves} s-moves	121 {value}
	{piece}		S153	{moves} s-moves	153 {value}
	{piece}		S169	{moves} s-moves	169 {value}
	{piece}		S225	{moves} s-moves	225 {value}
	{piece}		S289	{moves} s-moves	289 {value}
	{piece}		S361	{moves} s-moves	361 {value}
	{piece}		P0	{moves} p-moves	0   {value}
	{piece}		P91	{moves} p-moves	91  {value}
	{piece}		P190	{moves} p-moves	190 {value}
pieces}

' R0	IS ROUND
' T0	IS TRIANGLE
' S0	IS SQUARE
' P0	IS PYRAMID

{board-setup
	{setup}	White	S15	c2
	{setup}	White	S25	c1
	{setup}	White	T9	c3
	{setup}	White	S81	d1
	{setup}	White	S45	d2
	{setup}	White	T6	d3
	{setup}	White	T25	e2
	{setup}	White	R4	e3
	{setup}	White	R2	e4
	{setup}	White	T20	f2
	{setup}	White	R16	f3
	{setup}	White	R4	f4
	{setup}	White	T42	g2
	{setup}	White	R36	g3
	{setup}	White	R6	g4
	{setup}	White	T49	h2
	{setup}	White	R64	h3
	{setup}	White	R8	h4
	{setup}	White	S169	i1
	{setup}	White	P91	i2
	{setup}	White	T72	i3
	{setup}	White	S289	j1
	{setup}	White	S153	j2
	{setup}	White	T81	j3

	{setup}	White	S36	l1
	{setup}	White	S25	l2
	{setup}	White	T16	l3
	{setup}	White	T9	l4
	{setup}	White	R4	l5
	{setup}	White	R1	l6

	{setup}	Black	S361	c16
	{setup}	Black	P190	c15
	{setup}	Black	T100	c14
	{setup}	Black	S225	d16
	{setup}	Black	S120	d15
	{setup}	Black	T90	d14
	{setup}	Black	T64	e15
	{setup}	Black	R81	e14
	{setup}	Black	R9	e13
	{setup}	Black	T56	f15
	{setup}	Black	R49	f14
	{setup}	Black	R7	f13
	{setup}	Black	T30	g15
	{setup}	Black	R25	g14
	{setup}	Black	R5	g13
	{setup}	Black	T36	h15
	{setup}	Black	R9	h14
	{setup}	Black	R3	h13
	{setup}	Black	S121	i16
	{setup}	Black	S66	i15
	{setup}	Black	T12	i14
	{setup}	Black	S49	j16
	{setup}	Black	S28	j15
	{setup}	Black	T16	j14

	{setup}	Black	S64	a16
	{setup}	Black	S49	a15
	{setup}	Black	T36	a14
	{setup}	Black	T25	a13
	{setup}	Black	R16	a12
board-setup}
