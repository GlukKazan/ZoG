$passTurnForced ON

ROWS []		trace[]
VARIABLE	trace-count
VARIABLE	stone-count
VARIABLE	target-pos

DEFER	MARK

: get-value ( -- value )
	empty? IF
		0
	ELSE
		piece piece-value
	ENDIF
;

: build-trace ( -- )
	0 trace-count !
	0 BEGIN
		DUP ROWS >= IF
			DROP 0
		ENDIF
		DUP trace-count @ < IF
			DUP trace[] @
		ELSE
			trace-count ++
			from here = IF
				0
			ELSE
				get-value
			ENDIF
		ENDIF
		1+ OVER trace[] !
		stone-count --
		stone-count @ 0= IF
			TRUE
		ELSE
			1+ next verify
			FALSE
		ENDIF
	UNTIL
	trace-count @ 0> verify
	DUP trace[] @ 4 = IF
		-1 OVER trace[] !
	ENDIF
	DROP
;

: use-trace ( -- )
	0 BEGIN
		next verify
		DUP trace[] @
		DUP 0< IF
			DROP MARK 1- create-piece-type
		ELSE
			MARK + create-piece-type
		ENDIF
		1+ DUP trace-count @ >=
	UNTIL DROP
;

: move-p ( -- )
	friend? verify
	piece piece-value stone-count !
	next verify
	from here move
	build-trace
	from to use-trace
	add-move
;

: build-drop ( -- )
	0 stone-count !
	from to
	BEGIN
		get-value 4 = IF
			capture
			stone-count @ 4 + stone-count !
			prev verify
			from here =
		ELSE
			TRUE
		ENDIF
	UNTIL
;

: use-drop ( -- )
	target-pos @ to
	next-player
	get-value stone-count @ +
	MARK + create-player-piece-type
;

: move-q ( n -- )
	DUP ROWS < verify
	a1 to to-s verify
	BEGIN
		DUP 0> IF
			1- next verify
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	from here move
	here target-pos !
	build-drop 
	use-drop
	add-move
;

: move-q-0 ( -- ) 0 move-q ;
: move-q-1 ( -- ) 1 move-q ;
: move-q-2 ( -- ) 2 move-q ;
: move-q-3 ( -- ) 3 move-q ;
: move-q-4 ( -- ) 4 move-q ;
: move-q-5 ( -- ) 5 move-q ;
: move-q-6 ( -- ) 6 move-q ;
: move-q-7 ( -- ) 7 move-q ;

{move-priorities
	{move-priority} normal
	{move-priority} pass
move-priorities}

{moves p-moves
	{move} move-p {move-type} normal
	{move} Pass   {move-type} pass
moves}

{moves q-moves
	{move} move-q-0 {move-type} additional
	{move} move-q-1 {move-type} additional
	{move} move-q-2 {move-type} additional
	{move} move-q-3 {move-type} additional
	{move} move-q-4 {move-type} additional
	{move} move-q-5 {move-type} additional
	{move} move-q-6 {move-type} additional
	{move} move-q-7 {move-type} additional
moves}

{pieces
	{piece}		q	{moves}	q-moves	4	{value}
	{piece}		m
	{piece}		p1	{moves}	p-moves	1	{value}
	{piece}		p2	{moves}	p-moves	2	{value}
	{piece}		p3	{moves}	p-moves	3	{value}
	{piece}		p4	{moves}	p-moves	4	{value}
	{piece}		p5	{moves}	p-moves	5	{value}
	{piece}		p6	{moves}	p-moves	6	{value}
	{piece}		p7	{moves}	p-moves	7	{value}
	{piece}		p8	{moves}	p-moves	8	{value}
	{piece}		p9	{moves}	p-moves	9	{value}
	{piece}		p10	{moves}	p-moves	10	{value}
	{piece}		p11	{moves}	p-moves	11	{value}
	{piece}		p12	{moves}	p-moves	12	{value}
	{piece}		p13	{moves}	p-moves	13	{value}
	{piece}		p14	{moves}	p-moves	14	{value}
	{piece}		p15	{moves}	p-moves	15	{value}
	{piece}		p16	{moves}	p-moves	16	{value}
	{piece}		p17	{moves}	p-moves	17	{value}
	{piece}		p18	{moves}	p-moves	18	{value}
	{piece}		p19	{moves}	p-moves	19	{value}
	{piece}		p20	{moves}	p-moves	20	{value}
	{piece}		p21	{moves}	p-moves	21	{value}
	{piece}		p22	{moves}	p-moves	22	{value}
	{piece}		p23	{moves}	p-moves	23	{value}
	{piece}		p24	{moves}	p-moves	24	{value}
	{piece}		p25	{moves}	p-moves	25	{value}
	{piece}		p26	{moves}	p-moves	26	{value}
	{piece}		p27	{moves}	p-moves	27	{value}
	{piece}		p28	{moves}	p-moves	28	{value}
	{piece}		p29	{moves}	p-moves	29	{value}
	{piece}		p30	{moves}	p-moves	30	{value}
	{piece}		p31	{moves}	p-moves	31	{value}
	{piece}		p32	{moves}	p-moves	32	{value}
	{piece}		p33	{moves}	p-moves	33	{value}
	{piece}		p34	{moves}	p-moves	34	{value}
	{piece}		p35	{moves}	p-moves	35	{value}
	{piece}		p36	{moves}	p-moves	36	{value}
	{piece}		p37	{moves}	p-moves	37	{value}
	{piece}		p38	{moves}	p-moves	38	{value}
	{piece}		p39	{moves}	p-moves	39	{value}
	{piece}		p40	{moves}	p-moves	40	{value}
	{piece}		p41	{moves}	p-moves	41	{value}
	{piece}		p42	{moves}	p-moves	42	{value}
	{piece}		p43	{moves}	p-moves	43	{value}
	{piece}		p44	{moves}	p-moves	44	{value}
	{piece}		p45	{moves}	p-moves	45	{value}
	{piece}		p46	{moves}	p-moves	46	{value}
	{piece}		p47	{moves}	p-moves	47	{value}
	{piece}		p48	{moves}	p-moves	48	{value}
	{piece}		p49	{moves}	p-moves	49	{value}
	{piece}		p50	{moves}	p-moves	50	{value}
	{piece}		p51	{moves}	p-moves	51	{value}
	{piece}		p52	{moves}	p-moves	52	{value}
	{piece}		p53	{moves}	p-moves	53	{value}
	{piece}		p54	{moves}	p-moves	54	{value}
	{piece}		p55	{moves}	p-moves	55	{value}
	{piece}		p56	{moves}	p-moves	56	{value}
	{piece}		p57	{moves}	p-moves	57	{value}
	{piece}		p58	{moves}	p-moves	58	{value}
	{piece}		p59	{moves}	p-moves	59	{value}
	{piece}		p60	{moves}	p-moves	60	{value}
	{piece}		p61	{moves}	p-moves	61	{value}
	{piece}		p62	{moves}	p-moves	62	{value}
	{piece}		p63	{moves}	p-moves	63	{value}
	{piece}		p64	{moves}	p-moves	64	{value}
pieces}

' m	IS MARK
