LOAD Ur.4th ( Load the base Ur game )

: OnEvaluate ( -- score )
	 7 	whiteScored !
	 7 	blackScored !

	 0	1 White i1 Score
	 0	1 White j1 Score +
	 0	1 White k1 Score +
	 0	1 White l1 Score +
	 0	1 White m1 Score +
	 0	1 White n1 Score +
	 0	1 White o1 Score +

	 0	1 Black i5 Score +
	 0	1 Black j5 Score +
	 0	1 Black k5 Score +
	 0	1 Black l5 Score +
	 0	1 Black m5 Score +
	 0	1 Black n5 Score +
	 0	1 Black o5 Score +

	 1	1 White l2 Score +
	-1	1 Black l4 Score +
	 2	1 White k2 Score +
	-2	1 Black k4 Score +
	 3	1 White j2 Score +
	-3	1 Black j4 Score +
	 4  2 *	1 White i2 Score +
	-4  2 *	1 Black i4 Score +
	 5	1 White i3 Score +
	-5	1 Black i3 Score +
	 6	1 White j3 Score +
	-6	1 Black j3 Score +
	 7  2 *	1 White k3 Score +
	-7  2 *	1 Black k3 Score +
	 8	1 White l3 Score +
	-8	1 Black l3 Score +
	 9	1 White m3 Score +
	-9	1 Black m3 Score +
	 10 2 *	1 White n3 Score +
	-10 2 *	1 Black n3 Score +
	 11 3 *	1 White o3 Score +
	-11 3 *	1 Black o3 Score +
	 12	1 White o2 Score +
	-12	1 Black o4 Score +
	 13 2 *	1 White p2 Score +
	-13 2 *	1 Black p4 Score +
	 14	2 White p3 Score +
	-14	2 Black p3 Score +
	 15	2 White p4 Score +
	-15	2 Black p2 Score +
	 16 2 *	2 White o4 Score +
	-16 2 *	2 Black o2 Score +
	 17 4 *	2 White o3 Score +
	-17 4 *	2 Black o3 Score +
	 18 2 *	2 White n3 Score +
	-18 2 *	2 Black n3 Score +
	 19	2 White m3 Score +
	-19	2 Black m3 Score +
	 20	2 White l3 Score +
	-20	2 Black l3 Score +
	 21 2 *	2 White k3 Score +
	-21 2 *	2 Black k3 Score +
	 22	2 White j3 Score +
	-22	2 Black j3 Score +
	 23 4 *	2 White i3 Score +
	-23 4 *	2 Black i3 Score +

	 1	1 White c2 Score +
	 1	1 White c3 Score +
	 1	1 White c4 Score +
	-1	1 Black d2 Score +
	-1	1 Black d3 Score +
	-1	1 Black d4 Score +

	 3	1 White a2 Score +
	 3	1 White a3 Score +
	 3	1 White a4 Score +
	-3	1 Black b2 Score +
	-3	1 Black b3 Score +
	-3	1 Black b4 Score +

	 7	1 White f2 Score +
	 7	1 White f3 Score +
	 7	1 White f4 Score +
	-7	1 Black f2 Score +
	-7	1 Black f3 Score +
	-7	1 Black f4 Score +

	 10	1 White g2 Score +
	 10	1 White g3 Score +
	 10	1 White g4 Score +
	-10	1 Black g2 Score +
	-10	1 Black g3 Score +
	-10	1 Black g4 Score +

	 11 3 *	1 White e2 Score +
	 11 3 *	1 White e3 Score +
	 11 3 *	1 White e4 Score +
	-11 3 *	1 Black e2 Score +
	-11 3 *	1 Black e3 Score +
	-11 3 *	1 Black e4 Score +

	 17 4 *	2 White e2 Score +
	 17 4 *	2 White e3 Score +
	 17 4 *	2 White e4 Score +
	-17 4 *	2 Black e2 Score +
	-17 4 *	2 Black e3 Score +
	-17 4 *	2 Black e4 Score +

	 18	2 White g2 Score +
	 18	2 White g3 Score +
	 18	2 White g4 Score +
	-18	2 Black g2 Score +
	-18	2 Black g3 Score +
	-18	2 Black g4 Score +

	 21	2 White f2 Score +
	 21	2 White f3 Score +
	 21	2 White f4 Score +
	-21	2 Black f2 Score +
	-21	2 Black f3 Score +
	-21	2 Black f4 Score +

	 whiteScored @ 100 * +
	 blackScored @ 100 * -

	 current-player Black = IF NEGATE ENDIF
;
