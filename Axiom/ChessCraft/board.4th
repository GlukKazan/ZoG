LOAD	constants.4th

12	CONSTANT	ROWS
18	CONSTANT	COLS

{board
	ROWS COLS	{grid}
	{variable}	WhiteEnergy
	{variable}	BlackEnergy
	{variable}	WhiteLimit
	{variable}	BlackLimit
	{variable}	WhiteSupport
	{variable}	BlackSupport
	{variable}	WhiteMinProduce
	{variable}	BlackMinProduce
	{variable}	WhiteMaxProduce
	{variable}	BlackMaxProduce
board}

{directions
	-1  0  {direction} North
	 1  0  {direction} South
	 0  1  {direction} East
	 0 -1  {direction} West
	-1  1  {direction} Northeast
	 1  1  {direction} Southeast
	-1 -1  {direction} Northwest
	 1 -1  {direction} Southwest

	-1  0  {direction} North-around
	 1  0  {direction} South-around
	 0  1  {direction} East-around
	 0 -1  {direction} West-around
	-1  1  {direction} Northeast-around
	 1  1  {direction} Southeast-around
	-1 -1  {direction} Northwest-around
	 1 -1  {direction} Southwest-around

	 {unlink} East o1
	 {unlink} East o2
	 {unlink} East o3
	 {unlink} East o4
	 {unlink} East o5
	 {unlink} East o6
	 {unlink} East o7
	 {unlink} East o8
	 {unlink} East o9
	 {unlink} East o10
	 {unlink} East o11
	 {unlink} East o12

	 {unlink} Northeast o1
	 {unlink} Northeast o2
	 {unlink} Northeast o3
	 {unlink} Northeast o4
	 {unlink} Northeast o5
	 {unlink} Northeast o6
	 {unlink} Northeast o7
	 {unlink} Northeast o8
	 {unlink} Northeast o9
	 {unlink} Northeast o10
	 {unlink} Northeast o11

	 {unlink} Southeast o2
	 {unlink} Southeast o3
	 {unlink} Southeast o4
	 {unlink} Southeast o5
	 {unlink} Southeast o6
	 {unlink} Southeast o7
	 {unlink} Southeast o8
	 {unlink} Southeast o9
	 {unlink} Southeast o10
	 {unlink} Southeast o11
	 {unlink} Southeast o12

	 {unlink} East-around o1
	 {unlink} East-around o2
	 {unlink} East-around o3
	 {unlink} East-around o4
	 {unlink} East-around o5
	 {unlink} East-around o6
	 {unlink} East-around o7
	 {unlink} East-around o8
	 {unlink} East-around o9
	 {unlink} East-around o10
	 {unlink} East-around o11
	 {unlink} East-around o12

	 {unlink} Northeast-around o1
	 {unlink} Northeast-around o2
	 {unlink} Northeast-around o3
	 {unlink} Northeast-around o4
	 {unlink} Northeast-around o5
	 {unlink} Northeast-around o6
	 {unlink} Northeast-around o7
	 {unlink} Northeast-around o8
	 {unlink} Northeast-around o9
	 {unlink} Northeast-around o10
	 {unlink} Northeast-around o11

	 {unlink} Southeast-around o2
	 {unlink} Southeast-around o3
	 {unlink} Southeast-around o4
	 {unlink} Southeast-around o5
	 {unlink} Southeast-around o6
	 {unlink} Southeast-around o7
	 {unlink} Southeast-around o8
	 {unlink} Southeast-around o9
	 {unlink} Southeast-around o10
	 {unlink} Southeast-around o11
	 {unlink} Southeast-around o12

	 {unlink} West d1
	 {unlink} West d2
	 {unlink} West d3
	 {unlink} West d4
	 {unlink} West d5
	 {unlink} West d6
	 {unlink} West d7
	 {unlink} West d8
	 {unlink} West d9
	 {unlink} West d10
	 {unlink} West d11
	 {unlink} West d12

	 {unlink} Northwest d1
	 {unlink} Northwest d2
	 {unlink} Northwest d3
	 {unlink} Northwest d4
	 {unlink} Northwest d5
	 {unlink} Northwest d6
	 {unlink} Northwest d7
	 {unlink} Northwest d8
	 {unlink} Northwest d9
	 {unlink} Northwest d10
	 {unlink} Northwest d11

	 {unlink} Southwest d2
	 {unlink} Southwest d3
	 {unlink} Southwest d4
	 {unlink} Southwest d5
	 {unlink} Southwest d6
	 {unlink} Southwest d7
	 {unlink} Southwest d8
	 {unlink} Southwest d9
	 {unlink} Southwest d10
	 {unlink} Southwest d11
	 {unlink} Southwest d12

	 {unlink} West-around d1
	 {unlink} West-around d2
	 {unlink} West-around d3
	 {unlink} West-around d4
	 {unlink} West-around d5
	 {unlink} West-around d6
	 {unlink} West-around d7
	 {unlink} West-around d8
	 {unlink} West-around d9
	 {unlink} West-around d10
	 {unlink} West-around d11
	 {unlink} West-around d12

	 {unlink} Northwest-around d1
	 {unlink} Northwest-around d2
	 {unlink} Northwest-around d3
	 {unlink} Northwest-around d4
	 {unlink} Northwest-around d5
	 {unlink} Northwest-around d6
	 {unlink} Northwest-around d7
	 {unlink} Northwest-around d8
	 {unlink} Northwest-around d9
	 {unlink} Northwest-around d10
	 {unlink} Northwest-around d11

	 {unlink} Southwest-around d2
	 {unlink} Southwest-around d3
	 {unlink} Southwest-around d4
	 {unlink} Southwest-around d5
	 {unlink} Southwest-around d6
	 {unlink} Southwest-around d7
	 {unlink} Southwest-around d8
	 {unlink} Southwest-around d9
	 {unlink} Southwest-around d10
	 {unlink} Southwest-around d11
	 {unlink} Southwest-around d12

	 {link} North-around d12 d1
	 {link} North-around e12 e1
	 {link} North-around f12 f1
	 {link} North-around g12 g1
	 {link} North-around h12 h1
	 {link} North-around i12 i1
	 {link} North-around j12 j1
	 {link} North-around k12 k1
	 {link} North-around l12 l1
	 {link} North-around m12 m1
	 {link} North-around n12 n1
	 {link} North-around o12 o1

	 {link} South-around d1 d12
	 {link} South-around e1 e12
	 {link} South-around f1 f12
	 {link} South-around g1 g12
	 {link} South-around h1 h12
	 {link} South-around i1 i12
	 {link} South-around j1 j12
	 {link} South-around k1 k12
	 {link} South-around l1 l12
	 {link} South-around m1 m12
	 {link} South-around n1 n12
	 {link} South-around o1 o12

	 {link} East-around o1  d1
	 {link} East-around o2  d2
	 {link} East-around o3  d3
	 {link} East-around o4  d4
	 {link} East-around o5  d5
	 {link} East-around o6  d6
	 {link} East-around o7  d7
	 {link} East-around o8  d8
	 {link} East-around o9  d9
	 {link} East-around o10 d10
	 {link} East-around o11 d11
	 {link} East-around o12 d12

	 {link} West-around d1  o1
	 {link} West-around d2  o2
	 {link} West-around d3  o3
	 {link} West-around d4  o4
	 {link} West-around d5  o5
	 {link} West-around d6  o6
	 {link} West-around d7  o7
	 {link} West-around d8  o8
	 {link} West-around d9  o9
	 {link} West-around d10 o10
	 {link} West-around d11 o11
	 {link} West-around d12 o12

	 {link} Northeast-around o1  d2
	 {link} Northeast-around o2  d3
	 {link} Northeast-around o3  d4
	 {link} Northeast-around o4  d5
	 {link} Northeast-around o5  d6
	 {link} Northeast-around o6  d7
	 {link} Northeast-around o7  d8
	 {link} Northeast-around o8  d9
	 {link} Northeast-around o9  d10
	 {link} Northeast-around o10 d11
	 {link} Northeast-around o11 d12
	 {link} Northeast-around o12 d1
	 {link} Northeast-around n12 o1
	 {link} Northeast-around m12 n1
	 {link} Northeast-around l12 m1
	 {link} Northeast-around k12 l1
	 {link} Northeast-around j12 k1
	 {link} Northeast-around i12 j1
	 {link} Northeast-around h12 i1
	 {link} Northeast-around g12 h1
	 {link} Northeast-around f12 g1
	 {link} Northeast-around e12 f1
	 {link} Northeast-around d12 e1

	 {link} Southeast-around d1  e12
	 {link} Southeast-around e1  f12
	 {link} Southeast-around f1  g12
	 {link} Southeast-around g1  h12
	 {link} Southeast-around h1  i12
	 {link} Southeast-around i1  j12
	 {link} Southeast-around j1  k12
	 {link} Southeast-around k1  l12
	 {link} Southeast-around l1  m12
	 {link} Southeast-around m1  n12
	 {link} Southeast-around n1  o12
	 {link} Southeast-around o1  d12
	 {link} Southeast-around o2  d1
	 {link} Southeast-around o3  d2
	 {link} Southeast-around o4  d3
	 {link} Southeast-around o5  d4
	 {link} Southeast-around o6  d5
	 {link} Southeast-around o7  d6
	 {link} Southeast-around o8  d7
	 {link} Southeast-around o9  d8
	 {link} Southeast-around o10 d9
	 {link} Southeast-around o11 d10
	 {link} Southeast-around o12 d11

	 {link} Northwest-around d1  o2
	 {link} Northwest-around d2  o3
	 {link} Northwest-around d3  o4
	 {link} Northwest-around d4  o5
	 {link} Northwest-around d5  o6
	 {link} Northwest-around d6  o7
	 {link} Northwest-around d7  o8
	 {link} Northwest-around d8  o9
	 {link} Northwest-around d9  o10
	 {link} Northwest-around d10 o11
	 {link} Northwest-around d11 o12
	 {link} Northwest-around d12 o1
	 {link} Northwest-around e12 d1
	 {link} Northwest-around f12 e1
	 {link} Northwest-around g12 f1
	 {link} Northwest-around h12 g1
	 {link} Northwest-around i12 h1
	 {link} Northwest-around j12 i1
	 {link} Northwest-around k12 j1
	 {link} Northwest-around l12 k1
	 {link} Northwest-around m12 l1
	 {link} Northwest-around n12 m1
	 {link} Northwest-around o12 n1

	 {link} Southwest-around o1  n12
	 {link} Southwest-around n1  m12
	 {link} Southwest-around m1  l12
	 {link} Southwest-around l1  k12
	 {link} Southwest-around k1  j12
	 {link} Southwest-around j1  i12
	 {link} Southwest-around i1  h12
	 {link} Southwest-around h1  g12
	 {link} Southwest-around g1  f12
	 {link} Southwest-around f1  e12
	 {link} Southwest-around e1  d12
	 {link} Southwest-around d1  o12
	 {link} Southwest-around d2  o1
	 {link} Southwest-around d3  o2
	 {link} Southwest-around d4  o3
	 {link} Southwest-around d5  o4
	 {link} Southwest-around d6  o5
	 {link} Southwest-around d7  o6
	 {link} Southwest-around d8  o7
	 {link} Southwest-around d9  o8
	 {link} Southwest-around d10 o9
	 {link} Southwest-around d11 o10
	 {link} Southwest-around d12 o11

	 {link} Next c1  r12
	 {link} Next r12 r11
	 {link} Next r11 r10
	 {link} Next r10 r9
	 {link} Next r9  r8
	 {link} Next r8  r7
	 {link} Next r7  r6
	 {link} Next r6  r5
	 {link} Next r5  r4
	 {link} Next r4  r3
	 {link} Next r3  r2
	 {link} Next r2  r1
	 {link} Next r1  q12
	 {link} Next q12 q11
	 {link} Next q11 q10
	 {link} Next q10 q9
	 {link} Next q9  q8
	 {link} Next q8  q7
	 {link} Next q7  q6
	 {link} Next q6  q5
	 {link} Next q5  q4
	 {link} Next q4  q3
	 {link} Next q3  q2
	 {link} Next q2  q1

	 {link} Next c2  d6
	 {link} Next d6  e6
	 {link} Next e6  f6
	 {link} Next f6  g6
	 {link} Next g6  h6
	 {link} Next h6  i6
	 {link} Next i6  j6
	 {link} Next j6  k6
	 {link} Next k6  l6
	 {link} Next l6  m6
	 {link} Next m6  n6
	 {link} Next n6  o6
	 {link} Next o6  d5
	 {link} Next d5  e5
	 {link} Next e5  f5
	 {link} Next f5  g5
	 {link} Next g5  h5
	 {link} Next h5  i5
	 {link} Next i5  j5
	 {link} Next j5  k5
	 {link} Next k5  l5
	 {link} Next l5  m5
	 {link} Next m5  n5
	 {link} Next n5  o5
	 {link} Next o5  d4
	 {link} Next d4  e4
	 {link} Next e4  f4
	 {link} Next f4  g4
	 {link} Next g4  h4
	 {link} Next h4  i4
	 {link} Next i4  j4
	 {link} Next j4  k4
	 {link} Next k4  l4
	 {link} Next l4  m4
	 {link} Next m4  n4
	 {link} Next n4  o4
	 {link} Next o4  d3
	 {link} Next d3  e3
	 {link} Next e3  f3
	 {link} Next f3  g3
	 {link} Next g3  h3
	 {link} Next h3  i3
	 {link} Next i3  j3
	 {link} Next j3  k3
	 {link} Next k3  l3
	 {link} Next l3  m3
	 {link} Next m3  n3
	 {link} Next n3  o3
	 {link} Next o3  d2
	 {link} Next d2  e2
	 {link} Next e2  f2
	 {link} Next f2  g2
	 {link} Next g2  h2
	 {link} Next h2  i2
	 {link} Next i2  j2
	 {link} Next j2  k2
	 {link} Next k2  l2
	 {link} Next l2  m2
	 {link} Next m2  n2
	 {link} Next n2  o2
	 {link} Next o2  d1
	 {link} Next d1  e1
	 {link} Next e1  f1
	 {link} Next f1  g1
	 {link} Next g1  h1
	 {link} Next h1  i1
	 {link} Next i1  j1
	 {link} Next j1  k1
	 {link} Next k1  l1
	 {link} Next l1  m1
	 {link} Next m1  n1
	 {link} Next n1  o1

	 {link} Next-black c1  a1
	 {link} Next-black a1  a2
	 {link} Next-black a2  a3
	 {link} Next-black a3  a4
	 {link} Next-black a4  a5
	 {link} Next-black a5  a6
	 {link} Next-black a6  a7
	 {link} Next-black a7  a8
	 {link} Next-black a8  a9
	 {link} Next-black a9  a10
	 {link} Next-black a10 a11
	 {link} Next-black a11 a12
	 {link} Next-black a12 b1
	 {link} Next-black b1  b2
	 {link} Next-black b2  b3
	 {link} Next-black b3  b4
	 {link} Next-black b4  b5
	 {link} Next-black b5  b6
	 {link} Next-black b6  b7
	 {link} Next-black b7  b8
	 {link} Next-black b8  b9
	 {link} Next-black b9  b10
	 {link} Next-black b10 b11
	 {link} Next-black b11 b12

	 {link} Next-black c2  d7
	 {link} Next-black d7  e7
	 {link} Next-black e7  f7
	 {link} Next-black f7  g7
	 {link} Next-black g7  h7
	 {link} Next-black h7  i7
	 {link} Next-black i7  j7
	 {link} Next-black j7  k7
	 {link} Next-black k7  l7
	 {link} Next-black l9  m7
	 {link} Next-black m7  n7
	 {link} Next-black n7  o7
	 {link} Next-black o7  d8
	 {link} Next-black d8  e8
	 {link} Next-black e8  f8
	 {link} Next-black f8  g8
	 {link} Next-black g8  h8
	 {link} Next-black h8  i8
	 {link} Next-black i8  j8
	 {link} Next-black j8  k8
	 {link} Next-black k8  l8
	 {link} Next-black l8  m8
	 {link} Next-black m8  n8
	 {link} Next-black n8  o8
	 {link} Next-black o8  d9 
	 {link} Next-black d9  e9 
	 {link} Next-black e9  f9 
	 {link} Next-black f9  g9 
	 {link} Next-black g9  h9 
	 {link} Next-black h9  i9 
	 {link} Next-black i9  j9 
	 {link} Next-black j9  k9 
	 {link} Next-black k9  l9 
	 {link} Next-black l9  m9 
	 {link} Next-black m9  n9 
	 {link} Next-black n9  o9 
	 {link} Next-black o9  d10
	 {link} Next-black d10 e10
	 {link} Next-black e10 f10
	 {link} Next-black f10 g10
	 {link} Next-black g10 h10
	 {link} Next-black h10 i10
	 {link} Next-black i10 j10
	 {link} Next-black j10 k10
	 {link} Next-black k10 l10
	 {link} Next-black l10 m10
	 {link} Next-black m10 n10
	 {link} Next-black n10 o10
	 {link} Next-black o10 e11
	 {link} Next-black e11 f11
	 {link} Next-black f11 g11
	 {link} Next-black g11 h11
	 {link} Next-black h11 i11
	 {link} Next-black i11 j11
	 {link} Next-black j11 k11
	 {link} Next-black k11 l11
	 {link} Next-black l11 m11
	 {link} Next-black m11 n11
	 {link} Next-black n11 o11
	 {link} Next-black o11 e12
	 {link} Next-black e12 f12
	 {link} Next-black f12 g12
	 {link} Next-black g12 h12
	 {link} Next-black h12 i12
	 {link} Next-black i12 j12
	 {link} Next-black j12 k12
	 {link} Next-black k12 l12
	 {link} Next-black l12 m12
	 {link} Next-black m12 n12
	 {link} Next-black n12 o12
directions}

{players
	{player}	White
	{player}	Black
players}

{symmetries 
	Black	{symmetry} Next Next-black
symmetries}

{turn-order
	{turn}	White
	{turn}	Black
turn-order}

: change-energy ( v -- )
	current-player White = IF WhiteEnergy  @ ELSE BlackEnergy  @ ENDIF
	+
	current-player White = IF WhiteLimit   @ ELSE BlackLimit   @ ENDIF
	MIN DUP 0< NOT verify
	current-player White = IF WhiteEnergy  ! ELSE BlackEnergy  ! ENDIF
;

: change-limit ( v -- )
	current-player White = IF WhiteLimit   @ ELSE BlackLimit   @ ENDIF
	+
	current-player White = IF WhiteLimit   ! ELSE BlackLimit   ! ENDIF
;

: change-support ( v -- )
	current-player White = IF WhiteSupport @ ELSE BlackSupport @ ENDIF
	+
	current-player White = IF WhiteSupport ! ELSE BlackSupport ! ENDIF
;

: change-produce ( min max -- )
	current-player White = IF WhiteMaxProduce @ ELSE BlackMaxProduce @ ENDIF
	+
	current-player White = IF WhiteMaxProduce ! ELSE BlackMaxProduce ! ENDIF
	current-player White = IF WhiteMinProduce @ ELSE BlackMinProduce @ ENDIF
	+
	current-player White = IF WhiteMinProduce ! ELSE BlackMinProduce ! ENDIF
;

: support ( -- )
	current-player White = IF WhiteMinProduce @ ELSE BlackMinProduce @ ENDIF
	current-player White = IF WhiteMaxProduce @ ELSE BlackMaxProduce @ ENDIF
	RAND-WITHIN 
	current-player White = IF WhiteSupport @ ELSE BlackSupport @ ENDIF
	+ change-energy
;

: add-base	PRICE-BASE		change-energy 
		LIMIT-BASE		change-limit
		MIN-PRODUCE-BASE	MAX-PRODUCE-BASE	change-produce ;
: add-mobile	PRICE-MOBILE		change-energy
		LIMIT-MOBILE		change-limit
		MIN-PRODUCE-MOBILE	MAX-PRODUCE-MOBILE	change-produce ;
: del-base	0 LIMIT-BASE -		change-limit
		0 MIN-PRODUCE-BASE -	0 MAX-PRODUCE-BASE -	change-produce ;
: del-mobile	0 LIMIT-MOBILE -		change-limit
		0 MIN-PRODUCE-MOBILE -	0 MAX-PRODUCE-MOBILE -	change-produce ;

: add-wall	PRICE-WALL		change-energy ;
: add-swamp	PRICE-SWAMP		change-energy ;
: add-bomb	PRICE-BOMB		change-energy ;
: add-bomb-b	PRICE-BOMB-BOOST	change-energy ;
: add-bomb-w	PRICE-WALL-BOMB		change-energy ;
: add-bomb-s	PRICE-SWAMP-BOMB	change-energy ;
: add-swamp-f	PRICE-SWAMP-FREEZE	change-energy ;
: add-b		PRICE-BISHOP		change-energy ;
: add-r		PRICE-ROOK		change-energy ;
: add-k		PRICE-KNIGHT		change-energy ;
: add-rb	PRICE-QUEEN		change-energy ;
: add-bk	PRICE-ARCHBISHOP	change-energy ;
: add-rk	PRICE-CANCELOR		change-energy ;
: add-rbk	PRICE-AMAZON		change-energy ;
: add-clear	PRICE-CLEAR		change-energy ;
: add-boost	PRICE-BOOST		change-energy ;
: add-weak	PRICE-WEAK		change-energy ;
: add-freez	PRICE-FREEZE		change-energy ;
: add-kill	PRICE-KILL		change-energy ;
: add-richt	PRICE-RICOCHET		change-energy ;
: add-around	PRICE-AROUND		change-energy ;
: add-clear-m	PRICE-MASS-CLEAR	change-energy ;
: add-boost-m	PRICE-MASS-BOOST	change-energy ;
: add-weak-m	PRICE-MASS-WEAK		change-energy ;
: add-freez-m	PRICE-MASS-FREEZE	change-energy ;
: add-kill-m	PRICE-MASS-KILL		change-energy ;
: add-fix	PRICE-FIX		change-energy ;

: sup-rb	SUPPORT-QUEEN		change-support ;
: sup-bk	SUPPORT-ARCHBISHOP	change-support ;
: sup-rk	SUPPORT-CANCELOR	change-support ;
: sup-rbk	SUPPORT-AMAZON		change-support ;

: OnNewGame ( -- )
	RANDOMIZE
	0 WhiteLimit !
	0 BlackLimit !
	0 WhiteSupport !
	0 BlackSupport !
	0 WhiteMinProduce !
	0 BlackMinProduce !
	0 WhiteMaxProduce !
	0 BlackMaxProduce !
	VALUE-START WhiteEnergy !
	VALUE-START BlackEnergy !
;
