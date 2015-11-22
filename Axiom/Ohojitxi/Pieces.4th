DEFER	MARK

: drop-m ( -- )
	friend? verify
	drop
	add-move
;

{moves m-drops
	{move} drop-m {move-type} normal
moves}

{pieces
	{piece}		q	4	{value}
	{piece}		m	{drops} m-drops
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
	{piece}		p25	25	{value}
	{piece}		p26	26	{value}
	{piece}		p27	27	{value}
	{piece}		p28	28	{value}
	{piece}		p29	29	{value}
	{piece}		p30	30	{value}
	{piece}		p31	31	{value}
	{piece}		p32	32	{value}
	{piece}		p33	33	{value}
	{piece}		p34	34	{value}
	{piece}		p35	35	{value}
	{piece}		p36	36	{value}
	{piece}		p37	37	{value}
	{piece}		p38	38	{value}
	{piece}		p39	39	{value}
	{piece}		p40	40	{value}
	{piece}		p41	41	{value}
	{piece}		p42	42	{value}
	{piece}		p43	43	{value}
	{piece}		p44	44	{value}
	{piece}		p45	45	{value}
	{piece}		p46	46	{value}
	{piece}		p47	47	{value}
	{piece}		p48	48	{value}
	{piece}		p49	49	{value}
	{piece}		p50	50	{value}
	{piece}		p51	51	{value}
	{piece}		p52	52	{value}
	{piece}		p53	53	{value}
	{piece}		p54	54	{value}
	{piece}		p55	55	{value}
	{piece}		p56	56	{value}
	{piece}		p57	57	{value}
	{piece}		p58	58	{value}
	{piece}		p59	59	{value}
	{piece}		p60	60	{value}
	{piece}		p61	61	{value}
	{piece}		p62	62	{value}
	{piece}		p63	63	{value}
	{piece}		p64	64	{value}
pieces}

' m	IS MARK
