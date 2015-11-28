ROWS COLS * 	CONSTANT	TOTAL
24		CONSTANT	MAXQ
74		CONSTANT	MAXP

TOTAL []	positions[]
TOTAL []	trace[]
VARIABLE	trace-count
VARIABLE	stone-count
VARIABLE	min-target

DEFER	MARK

: get-value ( -- value )
	empty? here from = OR IF
		0
	ELSE
		piece piece-value
	ENDIF
;

: get-value-at ( pos -- value )
	DUP empty-at? IF
		DROP 0
	ELSE
		piece-at piece-value
	ENDIF
;

: build-trace ( -- )
	0 trace-count !
	0 BEGIN
		DUP TOTAL >= IF
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
		here OVER positions[] !
		stone-count --
		stone-count @ 0= IF
			TRUE
		ELSE
			1+ next verify
			FALSE
		ENDIF
	UNTIL DROP
;

: get-player ( -- )
	here COLS < IF
		current-player First = IF
			next-player
		ELSE
			current-player
		ENDIF
	ELSE
		current-player Second = IF
			next-player
		ELSE
			current-player
		ENDIF
	ENDIF
;

: not-in-positions? ( -- ? )
	TRUE trace-count @ 
	DUP 0> IF
		BEGIN
			1-
			DUP positions[] @ here = IF
				2DROP FALSE 0
				TRUE
			ELSE
				DUP 0=
			ENDIF
		UNTIL DROP
	ELSE
		DROP
	ENDIF
;

: check-target ( n -- n )
	DUP 0> IF
		here north verify
		empty? here from = OR IF
			not-in-positions? IF
				SWAP NEGATE SWAP
			ENDIF
		ENDIF to
	ENDIF
;

: change-min-target ( n -- )
	DUP 0< IF
		NEGATE
		DUP min-target @ < IF
			min-target !
		ELSE
			DROP
		ENDIF
	ELSE
		DROP
	ENDIF
;

: get-min-target ( -- )
	10 min-target !
	0 BEGIN
		next verify
		DUP trace[] @
		get-player current-player = IF
			check-target
		ENDIF
		change-min-target
		1+ DUP trace-count @ >=
	UNTIL DROP
	BEGIN
		next verify
		here from = IF
			TRUE
		ELSE
			get-player current-player = IF
				get-value DUP 0> IF
					check-target
				ENDIF
				change-min-target
			ENDIF
			FALSE
		ENDIF
	UNTIL
;

: use-trace ( -- )
	0 BEGIN
		next verify
		get-player
		OVER trace[] @
		DUP min-target @ = IF
			OVER current-player = IF
				check-target
			ENDIF
		ENDIF
		DUP 0< IF
			SWAP DROP next-player SWAP
		ENDIF
		DUP 0> IF
			DUP MAXP <= verify
		ELSE
			DUP NEGATE MAXQ <= verify
		ENDIF
		DUP 0 <> IF
			MARK + create-player-piece-type
		ELSE
			2DROP
		ENDIF
		1+ DUP trace-count @ >=
	UNTIL DROP
	BEGIN
		next verify
		here from = IF
			TRUE
		ELSE
			empty? NOT IF
				get-player current-player = IF
					get-value check-target
					DUP 0< IF
						DUP NEGATE MAXQ <= verify
						next-player SWAP MARK + create-player-piece-type
					ENDIF
				ELSE
					piece-type MARK < IF
						get-player get-value MARK + create-player-piece-type
					ENDIF
				ENDIF
			ENDIF
			FALSE
		ENDIF
	UNTIL
;

: move-p ( -- )
	friend? verify
	piece piece-value stone-count !
	next verify
	from here move
	build-trace
	from to get-min-target
	from to use-trace
	add-move
;

: move-q ( -- )
	friend? verify
	piece piece-value stone-count !
	current-player First = IF
		east to
	ELSE
		west to
	ENDIF
	from here move
	current-player get-value stone-count @ +
	DUP MAXP > IF
		DROP MAXP
	ENDIF
	MARK + create-player-piece-type
	add-move
;

{move-priorities
	{move-priority} high
	{move-priority} normal
move-priorities}

{moves p-moves
	{move} move-p {move-type} normal
moves}

{moves q-moves
	{move} move-q {move-type} high
moves}

{pieces
	{piece}		q24	{moves}	q-moves	24	{value}
	{piece}		q23	{moves}	q-moves	23	{value}
	{piece}		q22	{moves}	q-moves	22	{value}
	{piece}		q21	{moves}	q-moves	21	{value}
	{piece}		q20	{moves}	q-moves	20	{value}
	{piece}		q19	{moves}	q-moves	19	{value}
	{piece}		q18	{moves}	q-moves	18	{value}
	{piece}		q17	{moves}	q-moves	17	{value}
	{piece}		q16	{moves}	q-moves	16	{value}
	{piece}		q15	{moves}	q-moves	15	{value}
	{piece}		q14	{moves}	q-moves	14	{value}
	{piece}		q13	{moves}	q-moves	13	{value}
	{piece}		q12	{moves}	q-moves	12	{value}
	{piece}		q11	{moves}	q-moves	11	{value}
	{piece}		q10	{moves}	q-moves	10	{value}
	{piece}		q9	{moves}	q-moves	9	{value}
	{piece}		q8	{moves}	q-moves	8	{value}
	{piece}		q7	{moves}	q-moves	7	{value}
	{piece}		q6	{moves}	q-moves	6	{value}
	{piece}		q5	{moves}	q-moves	5	{value}
	{piece}		q4	{moves}	q-moves	4	{value}
	{piece}		q3	{moves}	q-moves	3	{value}
	{piece}		q2	{moves}	q-moves	2	{value}
	{piece}		q1	{moves}	q-moves	1	{value}
	{piece}		Dummy
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
	{piece}		p65	{moves}	p-moves	65	{value}
	{piece}		p66	{moves}	p-moves	66	{value}
	{piece}		p67	{moves}	p-moves	67	{value}
	{piece}		p68	{moves}	p-moves	68	{value}
	{piece}		p69	{moves}	p-moves	69	{value}
	{piece}		p70	{moves}	p-moves	70	{value}
	{piece}		p71	{moves}	p-moves	71	{value}
	{piece}		p72	{moves}	p-moves	72	{value}
	{piece}		p73	{moves}	p-moves	73	{value}
	{piece}		p74	{moves}	p-moves	74	{value}
pieces}

' Dummy	IS MARK
