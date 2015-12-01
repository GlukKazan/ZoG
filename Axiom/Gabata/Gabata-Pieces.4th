6 3 * 	CONSTANT	TOTAL

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

: move-p ( -- )
	next verify
	from here move
	add-move
;

: move-q ( -- )
	next verify
	from here move
	add-move
;

{move-priorities
	{move-priority} high-type
	{move-priority} normal-type
	{move-priority} pass-type
move-priorities}

{moves p-moves
	{move} move-p	{move-type} normal-type
	{move} Pass	{move-type} pass-type
moves}

{moves q-moves
	{move} move-q	{move-type} high-type
moves}

{pieces
	{piece}		q54	{moves}	q-moves	54	{value}
	{piece}		q53	{moves}	q-moves	53	{value}
	{piece}		q52	{moves}	q-moves	52	{value}
	{piece}		q51	{moves}	q-moves	51	{value}
	{piece}		q50	{moves}	q-moves	50	{value}
	{piece}		q49	{moves}	q-moves	49	{value}
	{piece}		q48	{moves}	q-moves	48	{value}
	{piece}		q47	{moves}	q-moves	47	{value}
	{piece}		q46	{moves}	q-moves	46	{value}
	{piece}		q45	{moves}	q-moves	45	{value}
	{piece}		q44	{moves}	q-moves	44	{value}
	{piece}		q43	{moves}	q-moves	43	{value}
	{piece}		q42	{moves}	q-moves	42	{value}
	{piece}		q41	{moves}	q-moves	41	{value}
	{piece}		q40	{moves}	q-moves	40	{value}
	{piece}		q39	{moves}	q-moves	39	{value}
	{piece}		q38	{moves}	q-moves	38	{value}
	{piece}		q37	{moves}	q-moves	37	{value}
	{piece}		q36	{moves}	q-moves	36	{value}
	{piece}		q35	{moves}	q-moves	35	{value}
	{piece}		q34	{moves}	q-moves	34	{value}
	{piece}		q33	{moves}	q-moves	33	{value}
	{piece}		q32	{moves}	q-moves	32	{value}
	{piece}		q31	{moves}	q-moves	31	{value}
	{piece}		q30	{moves}	q-moves	30	{value}
	{piece}		q29	{moves}	q-moves	29	{value}
	{piece}		q28	{moves}	q-moves	28	{value}
	{piece}		q27	{moves}	q-moves	27	{value}
	{piece}		q26	{moves}	q-moves	26	{value}
	{piece}		q25	{moves}	q-moves	25	{value}
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
pieces}

' Dummy	IS MARK
