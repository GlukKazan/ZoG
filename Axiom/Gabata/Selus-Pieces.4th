: move-p ( -- )
	check-normal
	piece piece-value stone-count !
	next verify
	from here move
	build-trace
	from to use-trace
	h3 friend-at? target-pos @ empty-at? AND IF
		h3 capture-at
	ENDIF
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
	{move} move-p	{move-type} high-type
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

	{piece}		t0	0	{value}
	{piece}		t1	1	{value}
	{piece}		t2	2	{value}
	{piece}		t3	3	{value}
	{piece}		t4	4	{value}
	{piece}		t5	5	{value}
	{piece}		t6	6	{value}
	{piece}		t7	7	{value}
	{piece}		t8	8	{value}
	{piece}		t9	9	{value}
	{piece}		t10	10	{value}
	{piece}		t11	11	{value}
	{piece}		t12	12	{value}
	{piece}		t13	13	{value}
	{piece}		t14	14	{value}
	{piece}		t15	15	{value}
	{piece}		t16	16	{value}
	{piece}		t17	17	{value}
	{piece}		t18	18	{value}
	{piece}		t19	19	{value}
	{piece}		t20	20	{value}
	{piece}		t21	21	{value}
	{piece}		t22	22	{value}
	{piece}		t23	23	{value}
	{piece}		t24	24	{value}
	{piece}		t25	25	{value}
	{piece}		t26	26	{value}
	{piece}		t27	27	{value}
	{piece}		t28	28	{value}
	{piece}		t29	29	{value}
	{piece}		t30	30	{value}
	{piece}		t31	31	{value}
	{piece}		t32	32	{value}
	{piece}		t33	33	{value}
	{piece}		t34	34	{value}
	{piece}		t35	35	{value}
	{piece}		t36	36	{value}
	{piece}		t37	37	{value}
	{piece}		t38	38	{value}
	{piece}		t39	39	{value}
	{piece}		t40	40	{value}
	{piece}		t41	41	{value}
	{piece}		t42	42	{value}
	{piece}		t43	43	{value}
	{piece}		t44	44	{value}
	{piece}		t45	45	{value}
	{piece}		t46	46	{value}
	{piece}		t47	47	{value}
	{piece}		t48	48	{value}
	{piece}		t49	49	{value}
	{piece}		t50	50	{value}
	{piece}		t51	51	{value}
	{piece}		t52	52	{value}
	{piece}		t53	53	{value}
	{piece}		t54	54	{value}
pieces}

' m	IS MARK
' t0	IS TRAP
