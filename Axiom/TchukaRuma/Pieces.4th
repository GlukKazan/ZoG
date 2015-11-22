DEFER	MARK

: move-p ( -- )
	here home <> verify
	next verify
	from here move
	add-move
;

{moves p-moves
	{move} move-p
moves}

{pieces
	{piece}		m
	{piece}		p1	1	{value}
	{piece}		p2	2	{value}
	{piece}		p3	3	{value}
	{piece}		p4	4	{value}
	{piece}		p5	5	{value}
	{piece}		p6	6	{value}
	{piece}		p7	7	{value}
	{piece}		p8	8	{value}
	{piece}		p9	9	{value}
	{piece}		p10	10	{value}
	{piece}		p11	11	{value}
	{piece}		p12	12	{value}
	{piece}		p13	13	{value}
	{piece}		p14	14	{value}
	{piece}		p15	15	{value}
	{piece}		p16	16	{value}
	{piece}		p17	17	{value}
	{piece}		p18	18	{value}
	{piece}		p19	19	{value}
	{piece}		p20	20	{value}
	{piece}		p21	21	{value}
	{piece}		p22	22	{value}
	{piece}		p23	23	{value}
	{piece}		p24	24	{value}

	{piece}		q1	{moves}	p-moves	1	{value}
	{piece}		q2	{moves}	p-moves	2	{value}
	{piece}		q3	{moves}	p-moves	3	{value}
	{piece}		q4	{moves}	p-moves	4	{value}
	{piece}		q5	{moves}	p-moves	5	{value}
	{piece}		q6	{moves}	p-moves	6	{value}
	{piece}		q7	{moves}	p-moves	7	{value}
	{piece}		q8	{moves}	p-moves	8	{value}
	{piece}		q9	{moves}	p-moves	9	{value}
	{piece}		q10	{moves}	p-moves	10	{value}
	{piece}		q11	{moves}	p-moves	11	{value}
	{piece}		q12	{moves}	p-moves	12	{value}
	{piece}		q13	{moves}	p-moves	13	{value}
	{piece}		q14	{moves}	p-moves	14	{value}
	{piece}		q15	{moves}	p-moves	15	{value}
	{piece}		q16	{moves}	p-moves	16	{value}
	{piece}		q17	{moves}	p-moves	17	{value}
	{piece}		q18	{moves}	p-moves	18	{value}
	{piece}		q19	{moves}	p-moves	19	{value}
	{piece}		q20	{moves}	p-moves	20	{value}
	{piece}		q21	{moves}	p-moves	21	{value}
	{piece}		q22	{moves}	p-moves	22	{value}
	{piece}		q23	{moves}	p-moves	23	{value}
	{piece}		q24	{moves}	p-moves	24	{value}
pieces}

' m	IS MARK
