{moves s-moves
	{move} step-n
	{move} step-s
	{move} step-w
	{move} step-e
	{move} step-nw
	{move} step-ne
	{move} step-sw
	{move} step-se
moves}

{moves r-moves
	{move} slide-n
	{move} slide-s
	{move} slide-w
	{move} slide-e
moves}

{moves b-moves
	{move} slide-nw
	{move} slide-ne
	{move} slide-sw
	{move} slide-se
moves}

{moves j-moves
	{move} jump-n
	{move} jump-s
	{move} jump-w
	{move} jump-e
	{move} jump-nw
	{move} jump-ne
	{move} jump-sw
	{move} jump-se
	{move} step-n
	{move} step-s
	{move} step-w
	{move} step-e
	{move} step-nw
	{move} step-ne
	{move} step-sw
	{move} step-se
moves}

{moves R-moves
	{move} slide-n
	{move} slide-s
	{move} slide-w
	{move} slide-e
	{move} fly-n
	{move} fly-s
	{move} fly-w
	{move} fly-e
moves}

{moves B-moves
	{move} fly-nw
	{move} fly-ne
	{move} fly-sw
	{move} fly-se
	{move} slide-nw
	{move} slide-ne
	{move} slide-sw
	{move} slide-se
moves}

{moves c-moves
	{move} Pass
moves}

{pieces
	{piece}	r	{moves} c-moves	1	{value}
	{piece}	b	{moves} c-moves	2	{value}
	{piece}	y	{moves} c-moves	5	{value}
	{piece}	z	{moves} c-moves	6	{value}
	{piece}	_f	{moves} c-moves	7	{value}
	{piece}	_s	{moves} c-moves	14	{value}
	{piece}	_y	{moves} c-moves	35	{value}
	{piece}	_z	{moves} c-moves	42	{value}
	{piece}	__v	{moves} c-moves	49	{value}
	{piece}	__y	{moves} c-moves	245	{value}
	{piece}	__z	{moves} c-moves	294	{value}

	{piece} MARK

	{piece}	B	{moves} c-moves	1	{value}
	{piece}	R	{moves} c-moves	2	{value}
	{piece}	L	{moves} s-moves	3	{value}
	{piece}	D	{moves} s-moves	4	{value}
	{piece}	Y	{moves} c-moves	5	{value}
	{piece}	Z	{moves} c-moves	6	{value}
	{piece}	_F	{moves} c-moves	7	{value}
	{piece}	BF	{moves} c-moves	8	{value}
	{piece}	RF	{moves} c-moves	9	{value}
	{piece}	LF	{moves} j-moves	10	{value}
	{piece}	DF	{moves} j-moves	11	{value}
	{piece}	YF	{moves} c-moves	12	{value}
	{piece}	ZF	{moves} c-moves	13	{value}
	{piece}	_S	{moves} c-moves	14	{value}
	{piece}	BS	{moves} c-moves	15	{value}
	{piece}	RS	{moves} c-moves	16	{value}
	{piece}	LS	{moves} s-moves	17	{value}
	{piece}	DS	{moves} s-moves	18	{value}
	{piece}	YS	{moves} c-moves	19	{value}
	{piece}	ZS	{moves} c-moves	20	{value}
	{piece}	_L	{moves} s-moves	21	{value}
	{piece}	BL	{moves} b-moves	22	{value}
	{piece}	RL	{moves} r-moves	23	{value}
	{piece}	YL	{moves} s-moves	26	{value}
	{piece}	ZL	{moves} s-moves	27	{value}
	{piece}	_D	{moves} s-moves	28	{value}
	{piece}	BD	{moves} b-moves	29	{value}
	{piece}	RD	{moves} r-moves	30	{value}
	{piece}	YD	{moves} s-moves	33	{value}
	{piece}	ZD	{moves} s-moves	34	{value}
	{piece}	_Y	{moves} c-moves	35	{value}
	{piece}	BY	{moves} c-moves	36	{value}
	{piece}	RY	{moves} c-moves	37	{value}
	{piece}	LY	{moves} s-moves	38	{value}
	{piece}	DY	{moves} s-moves	39	{value}
	{piece}	YY	{moves} c-moves	40	{value}
	{piece}	ZY	{moves} c-moves	41	{value}
	{piece}	_Z	{moves} c-moves	42	{value}
	{piece}	BZ	{moves} c-moves	43	{value}
	{piece}	RZ	{moves} c-moves	44	{value}
	{piece}	LZ	{moves} s-moves	34	{value}
	{piece}	DZ	{moves} s-moves	46	{value}
	{piece}	YZ	{moves} c-moves	47	{value}
	{piece}	ZZ	{moves} c-moves	48	{value}
	{piece}	__V	{moves} c-moves	49	{value}
	{piece}	B_V	{moves} c-moves	50	{value}
	{piece}	R_V	{moves} c-moves	51	{value}
	{piece}	L_V	{moves} s-moves	52	{value}
	{piece}	D_V	{moves} s-moves	53	{value}
	{piece}	Y_V	{moves} c-moves	54	{value}
	{piece}	Z_V	{moves} c-moves	55	{value}
	{piece}	_FV	{moves} c-moves	56	{value}
	{piece}	BFV	{moves} c-moves	57	{value}
	{piece}	RFV	{moves} c-moves	58	{value}
	{piece}	LFV	{moves} j-moves	59	{value}
	{piece}	DFV	{moves} j-moves	60	{value}
	{piece}	YFV	{moves} c-moves	61	{value}
	{piece}	ZFV	{moves} c-moves	62	{value}
	{piece}	_SV	{moves} c-moves	63	{value}
	{piece}	BSV	{moves} c-moves	64	{value}
	{piece}	RSV	{moves} c-moves	65	{value}
	{piece}	LSV	{moves} s-moves	66	{value}
	{piece}	DSV	{moves} s-moves	67	{value}
	{piece}	YSV	{moves} c-moves	68	{value}
	{piece}	ZSV	{moves} c-moves	69	{value}
	{piece}	_LV	{moves} s-moves	70	{value}
	{piece}	BLV	{moves} b-moves	71	{value}
	{piece}	RLV	{moves} r-moves	72	{value}
	{piece}	YLV	{moves} s-moves	75	{value}
	{piece}	ZLV	{moves} s-moves	76	{value}
	{piece}	_DV	{moves} s-moves	77	{value}
	{piece}	BDV	{moves} b-moves	78	{value}
	{piece}	RDV	{moves} r-moves	79	{value}
	{piece}	YDV	{moves} s-moves	82	{value}
	{piece}	ZDV	{moves} s-moves	83	{value}
	{piece}	_YV	{moves} c-moves	84	{value}
	{piece}	BYV	{moves} c-moves	85	{value}
	{piece}	RYV	{moves} c-moves	86	{value}
	{piece}	LYV	{moves} s-moves	87	{value}
	{piece}	DYV	{moves} s-moves	88	{value}
	{piece}	YYV	{moves} c-moves	89	{value}
	{piece}	ZYV	{moves} c-moves	90	{value}
	{piece}	_ZV	{moves} c-moves	91	{value}
	{piece}	BZV	{moves} c-moves	92	{value}
	{piece}	RZV	{moves} c-moves	93	{value}
	{piece}	LZV	{moves} s-moves	94	{value}
	{piece}	DZV	{moves} s-moves	95	{value}
	{piece}	YZV	{moves} c-moves	96	{value}
	{piece}	ZZV	{moves} c-moves	97	{value}
	{piece}	__L	{moves} s-moves	147	{value}
	{piece}	B_L	{moves} b-moves	148	{value}
	{piece}	R_L	{moves} r-moves	149	{value}
	{piece}	Y_L	{moves} s-moves	152	{value}
	{piece}	Z_L	{moves} s-moves	153	{value}
	{piece}	_FL	{moves} j-moves	154	{value}
	{piece}	BFL	{moves} j-moves	155	{value}
	{piece}	RFL	{moves} R-moves	156	{value}
	{piece}	YFL	{moves} j-moves	159	{value}
	{piece}	ZFL	{moves} j-moves	160	{value}
	{piece}	_SL	{moves} s-moves	161	{value}
	{piece}	BSL	{moves} b-moves	162	{value}
	{piece}	RSL	{moves} r-moves	163	{value}
	{piece}	YSL	{moves} s-moves	166	{value}
	{piece}	ZSL	{moves} s-moves	167	{value}
	{piece}	_YL	{moves} s-moves	182	{value}
	{piece}	BYL	{moves} b-moves	183	{value}
	{piece}	RYL	{moves} r-moves	184	{value}
	{piece}	YYL	{moves} s-moves	187	{value}
	{piece}	ZYL	{moves} s-moves	188	{value}
	{piece}	_ZL	{moves} s-moves	189	{value}
	{piece}	BZL	{moves} b-moves	190	{value}
	{piece}	RZL	{moves} r-moves	191	{value}
	{piece}	YZL	{moves} s-moves	194	{value}
	{piece}	ZZL	{moves} s-moves	195	{value}
	{piece}	__D	{moves} s-moves	196	{value}
	{piece}	B_D	{moves} b-moves	197	{value}
	{piece}	R_D	{moves} r-moves	198	{value}
	{piece}	Y_D	{moves} s-moves	201	{value}
	{piece}	Z_D	{moves} s-moves	202	{value}
	{piece}	_FD	{moves} j-moves	203	{value}
	{piece}	BFD	{moves} j-moves	204	{value}
	{piece}	RFD	{moves} R-moves	205	{value}
	{piece}	YFD	{moves} j-moves	208	{value}
	{piece}	ZFD	{moves} j-moves	209	{value}
	{piece}	_SD	{moves} s-moves	210	{value}
	{piece}	BSD	{moves} b-moves	211	{value}
	{piece}	RSD	{moves} r-moves	212	{value}
	{piece}	YSD	{moves} s-moves	215	{value}
	{piece}	ZSD	{moves} s-moves	216	{value}
	{piece}	_YD	{moves} s-moves	231	{value}
	{piece}	BYD	{moves} b-moves	232	{value}
	{piece}	RYD	{moves} r-moves	233	{value}
	{piece}	YYD	{moves} s-moves	236	{value}
	{piece}	ZYD	{moves} s-moves	237	{value}
	{piece}	_ZD	{moves} s-moves	238	{value}
	{piece}	BZD	{moves} b-moves	239	{value}
	{piece}	RZD	{moves} r-moves	240	{value}
	{piece}	YZD	{moves} s-moves	243	{value}
	{piece}	ZZD	{moves} s-moves	244	{value}
	{piece}	__Y	{moves} c-moves	245	{value}
	{piece}	B_Y	{moves} c-moves	246	{value}
	{piece}	R_Y	{moves} c-moves	247	{value}
	{piece}	L_Y	{moves} s-moves	248	{value}
	{piece}	D_Y	{moves} s-moves	249	{value}
	{piece}	Y_Y	{moves} c-moves	250	{value}
	{piece}	Z_Y	{moves} c-moves	251	{value}
	{piece}	_FY	{moves} c-moves	252	{value}
	{piece}	BFY	{moves} c-moves	253	{value}
	{piece}	RFY	{moves} c-moves	254	{value}
	{piece}	LFY	{moves} j-moves	255	{value}
	{piece}	DFY	{moves} j-moves	256	{value}
	{piece}	YFY	{moves} c-moves	257	{value}
	{piece}	ZFY	{moves} c-moves	258	{value}
	{piece}	_SY	{moves} c-moves	259	{value}
	{piece}	BSY	{moves} c-moves	260	{value}
	{piece}	RSY	{moves} c-moves	261	{value}
	{piece}	LSY	{moves} s-moves	262	{value}
	{piece}	DSY	{moves} s-moves	263	{value}
	{piece}	YSY	{moves} c-moves	264	{value}
	{piece}	ZSY	{moves} c-moves	265	{value}
	{piece}	_LY	{moves} s-moves	266	{value}
	{piece}	BLY	{moves} b-moves	267	{value}
	{piece}	RLY	{moves} r-moves	268	{value}
	{piece}	YLY	{moves} s-moves	271	{value}
	{piece}	ZLY	{moves} s-moves	272	{value}
	{piece}	_DY	{moves} s-moves	273	{value}
	{piece}	BDY	{moves} b-moves	274	{value}
	{piece}	RDY	{moves} r-moves	275	{value}
	{piece}	YDY	{moves} s-moves	278	{value}
	{piece}	ZDY	{moves} s-moves	279	{value}
	{piece}	_YY	{moves} c-moves	280	{value}
	{piece}	BYY	{moves} c-moves	281	{value}
	{piece}	RYY	{moves} c-moves	282	{value}
	{piece}	LYY	{moves} s-moves	283	{value}
	{piece}	DYY	{moves} s-moves	284	{value}
	{piece}	YYY	{moves} c-moves	285	{value}
	{piece}	ZYY	{moves} c-moves	286	{value}
	{piece}	_ZY	{moves} c-moves	287	{value}
	{piece}	BZY	{moves} c-moves	288	{value}
	{piece}	RZY	{moves} c-moves	289	{value}
	{piece}	LZY	{moves} s-moves	290	{value}
	{piece}	DZY	{moves} s-moves	291	{value}
	{piece}	YZY	{moves} c-moves	292	{value}
	{piece}	ZZY	{moves} c-moves	293	{value}
	{piece}	__Z	{moves} c-moves	294	{value}
	{piece}	B_Z	{moves} c-moves	295	{value}
	{piece}	R_Z	{moves} c-moves	296	{value}
	{piece}	L_Z	{moves} s-moves	297	{value}
	{piece}	D_Z	{moves} s-moves	298	{value}
	{piece}	Y_Z	{moves} c-moves	299	{value}
	{piece}	Z_Z	{moves} c-moves	300	{value}
	{piece}	_FZ	{moves} c-moves	301	{value}
	{piece}	BFZ	{moves} c-moves	302	{value}
	{piece}	RFZ	{moves} c-moves	303	{value}
	{piece}	LFZ	{moves} j-moves	304	{value}
	{piece}	DFZ	{moves} j-moves	305	{value}
	{piece}	YFZ	{moves} c-moves	306	{value}
	{piece}	ZFZ	{moves} c-moves	307	{value}
	{piece}	_SZ	{moves} c-moves	308	{value}
	{piece}	BSZ	{moves} c-moves	309	{value}
	{piece}	RSZ	{moves} c-moves	310	{value}
	{piece}	LSZ	{moves} s-moves	311	{value}
	{piece}	DSZ	{moves} s-moves	312	{value}
	{piece}	YSZ	{moves} c-moves	313	{value}
	{piece}	ZSZ	{moves} c-moves	314	{value}
	{piece}	_LZ	{moves} s-moves	315	{value}
	{piece}	BLZ	{moves} b-moves	316	{value}
	{piece}	RLZ	{moves} r-moves	317	{value}
	{piece}	YLZ	{moves} s-moves	320	{value}
	{piece}	ZLZ	{moves} s-moves	321	{value}
	{piece}	_DZ	{moves} s-moves	322	{value}
	{piece}	BDZ	{moves} b-moves	323	{value}
	{piece}	RDZ	{moves} r-moves	324	{value}
	{piece}	YDZ	{moves} s-moves	327	{value}
	{piece}	ZDZ	{moves} s-moves	328	{value}
	{piece}	_YZ	{moves} c-moves	329	{value}
	{piece}	BYZ	{moves} c-moves	330	{value}
	{piece}	RYZ	{moves} c-moves	331	{value}
	{piece}	LYZ	{moves} s-moves	332	{value}
	{piece}	DYZ	{moves} s-moves	333	{value}
	{piece}	YYZ	{moves} c-moves	334	{value}
	{piece}	ZYZ	{moves} c-moves	335	{value}
	{piece}	_ZZ	{moves} c-moves	336	{value}
	{piece}	BZZ	{moves} c-moves	337	{value}
	{piece}	RZZ	{moves} c-moves	338	{value}
	{piece}	LZZ	{moves} s-moves	339	{value}
	{piece}	DZZ	{moves} s-moves	340	{value}
	{piece}	YZZ	{moves} c-moves	341	{value}
	{piece}	ZZZ	{moves} c-moves	342	{value}
pieces}
