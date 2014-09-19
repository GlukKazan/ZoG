16	CONSTANT	ROWS
12	CONSTANT	COLS
34	CONSTANT	MAXV
10	CONSTANT	MAXS
100	CONSTANT	MAXE
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

DEFER		check-siege

VARIABLE	is-friend?
VARIABLE	is-captured?
VARIABLE	siege-counter
VARIABLE	attacking-sum
VARIABLE	attacked-cnt
VARIABLE	value-1
VARIABLE	value-2
VARIABLE	attacking-count
VARIABLE	current-count
VARIABLE	eruption-count
VARIABLE	last-position
VARIABLE	sum-value
VARIABLE	sum-flag

MAXV []		attacking-values[]
MAXS []		current-positions[]
MAXS []		current-values[]
MAXE []		eruption-values[]

: WhitePieces++ ( -- ) WhitePieces ++ ;
: BlackPieces++ ( -- ) BlackPieces ++ ;
: WhiteValues++ ( -- ) WhiteValues ++ ;
: BlackValues++ ( -- ) BlackValues ++ ;

: ChangePieces ( pos -- )
	DUP piece-at piece-value SWAP
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
		piece-type PYRAMID >
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

: capture-piece ( -- )
	current-count @
	BEGIN
		1- DUP 0> IF
			DUP current-positions[] @
			DUP 0< NOT IF
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
				DUP ChangePieces
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
	0 sum-value !
	PYRAMID is-piece-type? IF
		here a1 to
		BEGIN
			friend-p IF
				not-empty? eruption-count @ MAXE < AND IF
					OVER piece piece-value 
					DUP sum-value @ + sum-value !
					*
					eruption-count @ eruption-values[] !
					eruption-count ++
				ENDIF				         
				FALSE
			ELSE
				TRUE
			ENDIF
		UNTIL
		to
		sum-value @
	ELSE
		piece piece-value
	ENDIF
	eruption-count @ MAXE < IF
		*
		eruption-count @ eruption-values[] !
		eruption-count ++
	ELSE
		2DROP
	ENDIF
;

: get-attacking-values ( piece-type -- )
	0 sum-value    !
	FALSE sum-flag !
	PYRAMID is-piece-type? IF
		here a1 to
		BEGIN
			friend-p IF
				not-empty? attacking-count @ MAXV < AND IF
					piece piece-value
					sum-value @ + sum-value !
					OVER is-piece-type? IF
						TRUE sum-flag !
						piece piece-value
						attacking-count @ attacking-values[] !
						attacking-count ++
					ELSE
					ENDIF
				ENDIF				         
				FALSE
			ELSE
				TRUE
			ENDIF
		UNTIL
		to DROP
		sum-flag @ attacking-count @ MAXV < AND IF
			sum-value @
			attacking-count @ attacking-values[] !
			attacking-count ++
		ENDIF
	ELSE
		is-piece-type? attacking-count @ MAXV < AND IF
			piece piece-value
			attacking-count @ attacking-values[] !
			attacking-count ++
		ENDIF
	ENDIF
;

: capture-equality-pieces ( value -- )
	current-count @ 1 > IF
		0 attacked-cnt !
	ELSE
		1 attacked-cnt !
	ENDIF
	current-count @
	BEGIN
		1- DUP 0> IF
			OVER OVER current-values[] @ = IF
				DUP current-positions[] @
				DUP 0< IF
					DROP
				ELSE
					DUP enemy-at? IF
						DUP ChangePieces
						capture-at
					ELSE
						DROP
					ENDIF
					-1 OVER current-positions[] !
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
	current-count @ 0> IF
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
		DROP
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

: predict-move ( -- pos )
	here 
	DUP from = IF
		last-position @ to
	ELSE
		DUP last-position @ = IF
			from to
		ENDIF
	ENDIF
;

: check-siege-od ( 'dir -- )
	EXECUTE IF
		predict-move
		on-board? NOT friend? OR IF
			siege-counter --
		ENDIF
		on-board? friend? AND IF
			2 get-eruption-values
		ENDIF
		to
	ELSE
		siege-counter --
	ENDIF
;

: check-siege-dd ( 'dir -- )
	EXECUTE IF
		predict-move
		on-board? NOT friend? OR IF
			siege-counter --
		ENDIF
		on-board? friend? AND IF
			ROUND get-attacking-values
			ROUND check-equality-piece
		ENDIF
		to
	ELSE
		siege-counter --
	ENDIF
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
			1- DUP 0< IF
				TRUE			
			ELSE
				OVER EXECUTE on-board? AND IF
					predict-move
					friend? IF
						OVER count-to-piece-type
						DUP get-attacking-values
						check-equality-piece
					ENDIF
					to
	                                FALSE
				ELSE
					TRUE
				ENDIF
			ENDIF
		UNTIL
		2DROP
	ELSE
		2DROP
	ENDIF
;

: check-equality-od ( 'second-dir count 'first-dir -- )
	EXECUTE on-board? AND empty? AND IF
		BEGIN
			1- DUP 0< IF
				TRUE			
			ELSE
				OVER EXECUTE on-board? AND IF
					predict-move
					friend? IF
						OVER count-to-factor get-eruption-values
						OVER count-to-piece-type
						DUP get-attacking-values
						check-equality-piece
						TRUE
					ELSE
						not-empty?
					ENDIF
					SWAP to
				ELSE
					TRUE
				ENDIF
			ENDIF
		UNTIL
		2DROP
	ELSE
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
		DUP current-positions[] @ 0< NOT IF
			DUP current-values[] @ check-ambush-cond IF
				DUP 0> IF
					DUP current-positions[] @ 
					DUP enemy-at? IF
						DUP ChangePieces
						capture-at
					ELSE
						DROP
					ENDIF
					-1 OVER current-positions[] !
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
			predict-move
			OVER value-1 @ > on-board? friend? AND AND IF
				OVER get-eruption-values
			ENDIF
			to
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
		DUP current-positions[] @ 0< NOT IF
			DUP current-values[] @ value-1 @ = IF
				DUP 0> IF
					DUP current-positions[] @ 
					DUP enemy-at? IF
						DUP ChangePieces
						capture-at
					ELSE
						DROP
					ENDIF
					-1 OVER current-positions[] !
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
	to
	check-eruption-values
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
					current-count @ MAXS < IF
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
		DUP piece-at piece-value
	ENDIF
	0 current-values[] !
	to
;

: check-all-captured ( -- )
	current-count @ 1 > IF
		current-count @
		BEGIN
			1-
			DUP current-positions[] @ 0> OVER 0> AND IF
				TRUE
			ELSE
				DUP 0= IF
					TRUE is-captured? !
				ENDIF
				DUP 0> NOT
			ENDIF
		UNTIL
		DROP
	ENDIF
;

: capture-all ( -- )
	here ROWS COLS *
	BEGIN
		1-
		DUP on-board-at? OVER enemy-at? AND IF
			0 attacking-count  !
			0 eruption-count   !
			FALSE is-captured? !
			DUP fill-current
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
                        check-all-captured
			is-captured? @ IF
				capture-piece
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
				here DUP last-position !
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
					here DUP last-position !
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
			here DUP last-position !
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
		piece-type PYRAMID > IF
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

: OnEvaluate ( -- score )
	current-player material-balance
;

: OnNewGame ( -- )
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
: r-move-sw ( -- ) ['] Southwest TRUE leap-0 ;

: pr-move-ne ( -- ) ['] Northeast ROUND is-correct-type? leap-0 ;
: pr-move-se ( -- ) ['] Southeast ROUND is-correct-type? leap-0 ;
: pr-move-nw ( -- ) ['] Northwest ROUND is-correct-type? leap-0 ;
: pr-move-sw ( -- ) ['] Southwest ROUND is-correct-type? leap-0 ;

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

: s-move-n ( -- ) ['] North 3 TRUE shift-n ;
: s-move-s ( -- ) ['] South 3 TRUE shift-n ;
: s-move-w ( -- ) ['] West  3 TRUE shift-n ;
: s-move-e ( -- ) ['] East  3 TRUE shift-n ;

: ps-move-n ( -- ) ['] North 3 SQUARE is-correct-type? shift-n ;
: ps-move-s ( -- ) ['] South 3 SQUARE is-correct-type? shift-n ;
: ps-move-w ( -- ) ['] West  3 SQUARE is-correct-type? shift-n ;
: ps-move-e ( -- ) ['] East  3 SQUARE is-correct-type? shift-n ;

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
	{setup}	White	S25	c3
	{setup}	White	S15	c4
	{setup}	White	T9	c5
	{setup}	White	S81	d3
	{setup}	White	S45	d4
	{setup}	White	T6	d5
	{setup}	White	T25	e4
	{setup}	White	R4	e5
	{setup}	White	R2	e6
	{setup}	White	T20	f4
	{setup}	White	R16	f5
	{setup}	White	R4	f6
	{setup}	White	T42	g4
	{setup}	White	R36	g5
	{setup}	White	R6	g6
	{setup}	White	T49	h4
	{setup}	White	R64	h5
	{setup}	White	R8	h6
	{setup}	White	S169	i3
	{setup}	White	P91	i4
	{setup}	White	T72	i5
	{setup}	White	S289	j3
	{setup}	White	S153	j4
	{setup}	White	T81	j5

	{setup}	White	S36	l1
	{setup}	White	S25	l2
	{setup}	White	T16	l3
	{setup}	White	T9	l4
	{setup}	White	R4	l5
	{setup}	White	R1	l6

	{setup}	Black	S361	c14
	{setup}	Black	P190	c13
	{setup}	Black	T100	c12
	{setup}	Black	S225	d14
	{setup}	Black	S120	d13
	{setup}	Black	T90	d12
	{setup}	Black	T64	e13
	{setup}	Black	R81	e12
	{setup}	Black	R9	e11
	{setup}	Black	T56	f13
	{setup}	Black	R49	f12
	{setup}	Black	R7	f11
	{setup}	Black	T30	g13
	{setup}	Black	R25	g12
	{setup}	Black	R5	g11
	{setup}	Black	T36	h13
	{setup}	Black	R9	h12
	{setup}	Black	R3	h11
	{setup}	Black	S121	i14
	{setup}	Black	S66	i13
	{setup}	Black	T12	i12
	{setup}	Black	S49	j14
	{setup}	Black	S28	j13
	{setup}	Black	T16	j12

	{setup}	Black	S64	a16
	{setup}	Black	S49	a15
	{setup}	Black	T36	a14
	{setup}	Black	T25	a13
	{setup}	Black	R16	a12
board-setup}
