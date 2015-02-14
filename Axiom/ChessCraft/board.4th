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
