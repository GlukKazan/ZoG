LOAD	constants.4th

13	CONSTANT	ROWS
19	CONSTANT	COLS

{board
	ROWS COLS	{grid}
	{variable}	WhiteEnergy
	{variable}	BlackEnergy
	{variable}	WhiteLimit
	{variable}	BlackLimit
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

	 {ulink} East p1
	 {ulink} East p2
	 {ulink} East p3
	 {ulink} East p4
	 {ulink} East p5
	 {ulink} East p6
	 {ulink} East p7
	 {ulink} East p8
	 {ulink} East p9
	 {ulink} East p10
	 {ulink} East p11
	 {ulink} East p12
	 {ulink} East p13

	 {ulink} Northeast p1
	 {ulink} Northeast p2
	 {ulink} Northeast p3
	 {ulink} Northeast p4
	 {ulink} Northeast p5
	 {ulink} Northeast p6
	 {ulink} Northeast p7
	 {ulink} Northeast p8
	 {ulink} Northeast p9
	 {ulink} Northeast p10
	 {ulink} Northeast p11
	 {ulink} Northeast p12

	 {ulink} Southeast p2
	 {ulink} Southeast p3
	 {ulink} Southeast p4
	 {ulink} Southeast p5
	 {ulink} Southeast p6
	 {ulink} Southeast p7
	 {ulink} Southeast p8
	 {ulink} Southeast p9
	 {ulink} Southeast p10
	 {ulink} Southeast p11
	 {ulink} Southeast p12
	 {ulink} Southeast p13

	 {ulink} East-around p1
	 {ulink} East-around p2
	 {ulink} East-around p3
	 {ulink} East-around p4
	 {ulink} East-around p5
	 {ulink} East-around p6
	 {ulink} East-around p7
	 {ulink} East-around p8
	 {ulink} East-around p9
	 {ulink} East-around p10
	 {ulink} East-around p11
	 {ulink} East-around p12
	 {ulink} East-around p13

	 {ulink} Northeast-around p1
	 {ulink} Northeast-around p2
	 {ulink} Northeast-around p3
	 {ulink} Northeast-around p4
	 {ulink} Northeast-around p5
	 {ulink} Northeast-around p6
	 {ulink} Northeast-around p7
	 {ulink} Northeast-around p8
	 {ulink} Northeast-around p9
	 {ulink} Northeast-around p10
	 {ulink} Northeast-around p11
	 {ulink} Northeast-around p12

	 {ulink} Southeast-around p2
	 {ulink} Southeast-around p3
	 {ulink} Southeast-around p4
	 {ulink} Southeast-around p5
	 {ulink} Southeast-around p6
	 {ulink} Southeast-around p7
	 {ulink} Southeast-around p8
	 {ulink} Southeast-around p9
	 {ulink} Southeast-around p10
	 {ulink} Southeast-around p11
	 {ulink} Southeast-around p12
	 {ulink} Southeast-around p13

	 {ulink} West d1
	 {ulink} West d2
	 {ulink} West d3
	 {ulink} West d4
	 {ulink} West d5
	 {ulink} West d6
	 {ulink} West d7
	 {ulink} West d8
	 {ulink} West d9
	 {ulink} West d10
	 {ulink} West d11
	 {ulink} West d12
	 {ulink} West d13

	 {ulink} Northwest d1
	 {ulink} Northwest d2
	 {ulink} Northwest d3
	 {ulink} Northwest d4
	 {ulink} Northwest d5
	 {ulink} Northwest d6
	 {ulink} Northwest d7
	 {ulink} Northwest d8
	 {ulink} Northwest d9
	 {ulink} Northwest d10
	 {ulink} Northwest d11
	 {ulink} Northwest d12

	 {ulink} Southwest d2
	 {ulink} Southwest d3
	 {ulink} Southwest d4
	 {ulink} Southwest d5
	 {ulink} Southwest d6
	 {ulink} Southwest d7
	 {ulink} Southwest d8
	 {ulink} Southwest d9
	 {ulink} Southwest d10
	 {ulink} Southwest d11
	 {ulink} Southwest d12
	 {ulink} Southwest d13

	 {ulink} West-around d1
	 {ulink} West-around d2
	 {ulink} West-around d3
	 {ulink} West-around d4
	 {ulink} West-around d5
	 {ulink} West-around d6
	 {ulink} West-around d7
	 {ulink} West-around d8
	 {ulink} West-around d9
	 {ulink} West-around d10
	 {ulink} West-around d11
	 {ulink} West-around d12
	 {ulink} West-around d13

	 {ulink} Northwest-around d1
	 {ulink} Northwest-around d2
	 {ulink} Northwest-around d3
	 {ulink} Northwest-around d4
	 {ulink} Northwest-around d5
	 {ulink} Northwest-around d6
	 {ulink} Northwest-around d7
	 {ulink} Northwest-around d8
	 {ulink} Northwest-around d9
	 {ulink} Northwest-around d10
	 {ulink} Northwest-around d11
	 {ulink} Northwest-around d12

	 {ulink} Southwest-around d2
	 {ulink} Southwest-around d3
	 {ulink} Southwest-around d4
	 {ulink} Southwest-around d5
	 {ulink} Southwest-around d6
	 {ulink} Southwest-around d7
	 {ulink} Southwest-around d8
	 {ulink} Southwest-around d9
	 {ulink} Southwest-around d10
	 {ulink} Southwest-around d11
	 {ulink} Southwest-around d12
	 {ulink} Southwest-around d13

	 {link} North-around d13 d1
	 {link} North-around e13 e1
	 {link} North-around f13 f1
	 {link} North-around g13 g1
	 {link} North-around h13 h1
	 {link} North-around i13 i1
	 {link} North-around j13 j1
	 {link} North-around k13 k1
	 {link} North-around l13 l1
	 {link} North-around m13 m1
	 {link} North-around n13 n1
	 {link} North-around o13 o1
	 {link} North-around p13 p1

	 {link} South-around d1 d13
	 {link} South-around e1 e13
	 {link} South-around f1 f13
	 {link} South-around g1 g13
	 {link} South-around h1 h13
	 {link} South-around i1 i13
	 {link} South-around j1 j13
	 {link} South-around k1 k13
	 {link} South-around l1 l13
	 {link} South-around m1 m13
	 {link} South-around n1 n13
	 {link} South-around o1 o13
	 {link} South-around p1 p13

	 {link} East-around p1  d1
	 {link} East-around p2  d2
	 {link} East-around p3  d3
	 {link} East-around p4  d4
	 {link} East-around p5  d5
	 {link} East-around p6  d6
	 {link} East-around p7  d7
	 {link} East-around p8  d8
	 {link} East-around p9  d9
	 {link} East-around p10 d10
	 {link} East-around p11 d11
	 {link} East-around p12 d12
	 {link} East-around p13 d13

	 {link} West-around d1  p1
	 {link} West-around d2  p2
	 {link} West-around d3  p3
	 {link} West-around d4  p4
	 {link} West-around d5  p5
	 {link} West-around d6  p6
	 {link} West-around d7  p7
	 {link} West-around d8  p8
	 {link} West-around d9  p9
	 {link} West-around d10 p10
	 {link} West-around d11 p11
	 {link} West-around d12 p12
	 {link} West-around d13 p13

	 {link} Northeast-around p1  d2
	 {link} Northeast-around p2  d3
	 {link} Northeast-around p3  d4
	 {link} Northeast-around p4  d5
	 {link} Northeast-around p5  d6
	 {link} Northeast-around p6  d7
	 {link} Northeast-around p7  d8
	 {link} Northeast-around p8  d9
	 {link} Northeast-around p9  d10
	 {link} Northeast-around p10 d11
	 {link} Northeast-around p11 d12
	 {link} Northeast-around p12 d13
	 {link} Northeast-around p13 d1
	 {link} Northeast-around o13 p1
	 {link} Northeast-around n13 o1
	 {link} Northeast-around m13 n1
	 {link} Northeast-around l13 m1
	 {link} Northeast-around k13 l1
	 {link} Northeast-around j13 k1
	 {link} Northeast-around i13 j1
	 {link} Northeast-around h13 i1
	 {link} Northeast-around g13 h1
	 {link} Northeast-around f13 g1
	 {link} Northeast-around e13 f1
	 {link} Northeast-around d13 e1

	 {link} Southeast-around d1  e13
	 {link} Southeast-around e1  f13
	 {link} Southeast-around f1  g13
	 {link} Southeast-around g1  h13
	 {link} Southeast-around h1  i13
	 {link} Southeast-around i1  j13
	 {link} Southeast-around j1  k13
	 {link} Southeast-around k1  l13
	 {link} Southeast-around l1  m13
	 {link} Southeast-around m1  n13
	 {link} Southeast-around n1  o13
	 {link} Southeast-around o1  p13
	 {link} Southeast-around p1  d13
	 {link} Southeast-around p2  d1
	 {link} Southeast-around p3  d2
	 {link} Southeast-around p4  d3
	 {link} Southeast-around p5  d4
	 {link} Southeast-around p6  d5
	 {link} Southeast-around p7  d6
	 {link} Southeast-around p8  d7
	 {link} Southeast-around p9  d8
	 {link} Southeast-around p10 d9
	 {link} Southeast-around p11 d10
	 {link} Southeast-around p12 d11
	 {link} Southeast-around p13 d12

	 {link} Northwest-around d1  p2
	 {link} Northwest-around d2  p3
	 {link} Northwest-around d3  p4
	 {link} Northwest-around d4  p5
	 {link} Northwest-around d5  p6
	 {link} Northwest-around d6  p7
	 {link} Northwest-around d7  p8
	 {link} Northwest-around d8  p9
	 {link} Northwest-around d9  p10
	 {link} Northwest-around d10 p11
	 {link} Northwest-around d11 p12
	 {link} Northwest-around d12 p13
	 {link} Northwest-around d13 p1
	 {link} Northwest-around e13 d1
	 {link} Northwest-around f13 e1
	 {link} Northwest-around g13 f1
	 {link} Northwest-around h13 g1
	 {link} Northwest-around i13 h1
	 {link} Northwest-around j13 i1
	 {link} Northwest-around k13 j1
	 {link} Northwest-around l13 k1
	 {link} Northwest-around m13 l1
	 {link} Northwest-around n13 m1
	 {link} Northwest-around o13 n1
	 {link} Northwest-around p13 o1

	 {link} Southwest-around p1  o13
	 {link} Southwest-around o1  n13
	 {link} Southwest-around n1  m13
	 {link} Southwest-around m1  l13
	 {link} Southwest-around l1  k13
	 {link} Southwest-around k1  j13
	 {link} Southwest-around j1  i13
	 {link} Southwest-around i1  h13
	 {link} Southwest-around h1  g13
	 {link} Southwest-around g1  f13
	 {link} Southwest-around f1  e13
	 {link} Southwest-around e1  d13
	 {link} Southwest-around d1  p13
	 {link} Southwest-around d2  p1
	 {link} Southwest-around d3  p2
	 {link} Southwest-around d4  p3
	 {link} Southwest-around d5  p4
	 {link} Southwest-around d6  p5
	 {link} Southwest-around d7  p6
	 {link} Southwest-around d8  p7
	 {link} Southwest-around d9  p8
	 {link} Southwest-around d10 p9
	 {link} Southwest-around d11 p10
	 {link} Southwest-around d12 p11
	 {link} Southwest-around d13 p12

	 {link} Next c1  s13
	 {link} Next s13 s12
	 {link} Next s12 s11
	 {link} Next s11 s10
	 {link} Next s10 s9
	 {link} Next s9  s8
	 {link} Next s8  s7
	 {link} Next s7  s6
	 {link} Next s6  s5
	 {link} Next s5  s4
	 {link} Next s4  s3
	 {link} Next s3  s2
	 {link} Next s2  s1
	 {link} Next s1  r13
	 {link} Next r13 r12
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
	 {link} Next o6  p6
	 {link} Next p6  d5
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
	 {link} Next o5  p5
	 {link} Next p5  d4
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
	 {link} Next o4  p4
	 {link} Next p4  d3
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
	 {link} Next o3  p3
	 {link} Next p3  d2
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
	 {link} Next o2  p2
	 {link} Next p2  d1
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
	 {link} Next o1  p1

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
	 {link} Next-black a12 a13
	 {link} Next-black a13 b1
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
	 {link} Next-black b12 b13

	 {link} Next-black c2  d8
	 {link} Next-black d8  e8
	 {link} Next-black e8  f8
	 {link} Next-black f8  g8
	 {link} Next-black g8  h8
	 {link} Next-black h8  i8
	 {link} Next-black i8  j8
	 {link} Next-black j8  k8
	 {link} Next-black k8  l8
	 {link} Next-black l9  m8
	 {link} Next-black m8  n8
	 {link} Next-black n8  o8
	 {link} Next-black o8  p8
	 {link} Next-black p8  d9
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
	 {link} Next-black o9  p9
	 {link} Next-black p9  d10
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
	 {link} Next-black o10 p10
	 {link} Next-black p10 d11
	 {link} Next-black d11 e11
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
	 {link} Next-black o11 p11
	 {link} Next-black p11 d12
	 {link} Next-black d12 e12
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
	 {link} Next-black o12 p12
	 {link} Next-black p12 d13
	 {link} Next-black d13 e13
	 {link} Next-black e13 f13
	 {link} Next-black f13 g13
	 {link} Next-black g13 h13
	 {link} Next-black h13 i13
	 {link} Next-black i13 j13
	 {link} Next-black j13 k13
	 {link} Next-black k13 l13
	 {link} Next-black l13 m13
	 {link} Next-black m13 n13
	 {link} Next-black n13 o13
	 {link} Next-black o13 p13
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

: OnNewGame ( -- )
	RANDOMIZE
	0 WhiteLimit !
	0 BlackLimit !
	VALUE-START WhiteEnergy !
	VALUE-START BlackEnergy !
;
