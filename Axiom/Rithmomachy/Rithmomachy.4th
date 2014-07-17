{board
	16 	12	{grid}
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

	 ( white-p )
	 {link} white-p a1  l1	{link} white-p l1  l2	{link} white-p l2  l3
	 {link} white-p l3  l4	{link} white-p l4  l5	{link} white-p l5  l6

	 ( black-p )
	 {link} black-p a1  a16	{link} black-p a16 a15	{link} black-p a15 a14
	 {link} black-p a14 a13	{link} black-p a13 a12	{link} black-p a12 a11
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
	Black		{symmetry} white-p black-p
symmetries}

DEFER	ROUND
DEFER	TRIANGLE
DEFER	SQUARE
DEFER	PYRAMID

: get-x ( pos -- x )
	12 MOD
;

: on-board-at? ( pos -- ? )
	get-x DUP
	1 > SWAP 10 < AND
;

: on-board? ( -- ? )
	here on-board-at?
;

: capture-all ( -- )
	\ TODO:

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
						DROP DROP TRUE TRUE
					ENDIF
				ELSE
					DROP DROP FALSE TRUE
				ENDIF
			ELSE
				DROP DROP FALSE TRUE
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
		DROP DROP DROP
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
						DROP DROP TRUE TRUE
					ENDIF
				ELSE
					DROP DROP FALSE TRUE
				ENDIF
			ELSE
				DROP DROP FALSE TRUE
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
		DROP DROP
	ENDIF
;

: is-piece-type? ( piece-type -- ? )
	not-empty? IF
		piece-type SQUARE > IF
			SQUARE =
		ELSE
			piece-type TRIANGLE > IF
				TRIANGLE =
			ELSE
				ROUND =
			ENDIF
		ENDIF
	ELSE
		DROP FALSE
	ENDIF
;

: is-correct-type? ( piece-type -- ? )
	not-empty? IF
		piece PYRAMID > IF
			here SWAP a1 to
			BEGIN
				white-p IF
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
