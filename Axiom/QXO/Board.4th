9		CONSTANT	DIM
DIM DUP *	CONSTANT	ALL
ALL 1+		CONSTANT	TOTAL

{board
	DIM DIM	{grid}

	{position} 3A
	{position} 3B
	{position} 3C
	{position} 2A
	{position} 2B
	{position} 2C
	{position} 1A
	{position} 1B
	{position} 1C

	{position} PF
	{position} CT
board}

{directions
	-3	 0	{direction} n-internal
	 3	 0	{direction} s-internal
	 0	 3	{direction} e-internal
	 0	-3	{direction} w-internal
	-3	-3	{direction} nw-internal
	 3	-3	{direction} sw-internal
	-3	 3	{direction} ne-internal
	 3	 3	{direction} se-internal
directions}

{directions
	{link} up a9 a8 {link} down a8 a9
	{link} up a8 a7 {link} down a7 a9
	{link} up a7 b9 {link} down b9 a9
	{link} up b9 b8 {link} down b8 a9
	{link} up b8 b7 {link} down b7 a9
	{link} up b7 c9 {link} down c9 a9
	{link} up c9 c8 {link} down c8 a9
	{link} mr a9 c7 {link} down c7 a9
	{link} bg a9 3A {link} down 3A a9

	{link} up d9 d8 {link} down d8 d9
	{link} up d8 d7 {link} down d7 d9
	{link} up d7 e9 {link} down e9 d9
	{link} up e9 e8 {link} down e8 d9
	{link} up e8 e7 {link} down e7 d9
	{link} up e7 f9 {link} down f9 d9
	{link} up f9 f8 {link} down f8 d9
	{link} mr d9 f7 {link} down f7 d9
	{link} bg d9 3B {link} down 3B d9

	{link} up g9 g8 {link} down g8 g9
	{link} up g8 g7 {link} down g7 g9
	{link} up g7 h9 {link} down h9 g9
	{link} up h9 h8 {link} down h8 g9
	{link} up h8 h7 {link} down h7 g9
	{link} up h7 i9 {link} down i9 g9
	{link} up i9 i8 {link} down i8 g9
	{link} mr g9 i7 {link} down i7 g9
	{link} bg g9 3C {link} down 3C g9

	{link} up a6 a5 {link} down a5 a6
	{link} up a5 a4 {link} down a4 a6
	{link} up a4 b6 {link} down b6 a6
	{link} up b6 b5 {link} down b5 a6
	{link} up b5 b4 {link} down b4 a6
	{link} up b4 c6 {link} down c6 a6
	{link} up c6 c5 {link} down c5 a6
	{link} mr a6 c4 {link} down c4 a6
	{link} bg a6 2A {link} down 2A a6

	{link} up d6 d5 {link} down d5 d6
	{link} up d5 d4 {link} down d4 d6
	{link} up d4 e6 {link} down e6 d6
	{link} up e6 e5 {link} down e5 d6
	{link} up e5 e4 {link} down e4 d6
	{link} up e4 f6 {link} down f6 d6
	{link} up f6 f5 {link} down f5 d6
	{link} mr d6 f4 {link} down f4 d6
	{link} bg d6 2B {link} down 2B d6

	{link} up g6 g5 {link} down g5 g6
	{link} up g5 g4 {link} down g4 g6
	{link} up g4 h6 {link} down h6 g6
	{link} up h6 h5 {link} down h5 g6
	{link} up h5 h4 {link} down h4 g6
	{link} up h4 i6 {link} down i6 g6
	{link} up i6 i5 {link} down i5 g6
	{link} mr g6 i4 {link} down i4 g6
	{link} bg g6 2C {link} down 2C g6

	{link} up a3 a2 {link} down a2 a3
	{link} up a2 a1 {link} down a1 a3
	{link} up a1 b3 {link} down b3 a3
	{link} up b3 b2 {link} down b2 a3
	{link} up b2 b1 {link} down b1 a3
	{link} up b1 c3 {link} down c3 a3
	{link} up c3 c2 {link} down c2 a3
	{link} mr a3 c1 {link} down c1 a3
	{link} bg a3 1A {link} down 1A a3

	{link} up d3 d2 {link} down d2 d3
	{link} up d2 d1 {link} down d1 d3
	{link} up d1 e3 {link} down e3 d3
	{link} up e3 e2 {link} down e2 d3
	{link} up e2 e1 {link} down e1 d3
	{link} up e1 f3 {link} down f3 d3
	{link} up f3 f2 {link} down f2 d3
	{link} mr d3 f1 {link} down f1 d3
	{link} bg d3 1B {link} down 1B d3

	{link} up g3 g2 {link} down g2 g3
	{link} up g2 g1 {link} down g1 g3
	{link} up g1 h3 {link} down h3 g3
	{link} up h3 h2 {link} down h2 g3
	{link} up h2 h1 {link} down h1 g3
	{link} up h1 i3 {link} down i3 g3
	{link} up i3 i2 {link} down i2 g3
	{link} mr g3 i1 {link} down i1 g3
	{link} bg g3 1C {link} down 1C g3
directions}
