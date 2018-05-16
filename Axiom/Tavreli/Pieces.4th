{moves pawn-i-moves
	{move}		pawn-shift
	{move}		pawn-nw-step
	{move}		pawn-ne-step
	{move}		pawn-jump
moves}

{moves pawn-moves
	{move}		pawn-shift
	{move}		pawn-nw-step
	{move}		pawn-ne-step
moves}

{moves king-i-moves
	{move}		king-n-step
	{move}		king-e-step
	{move}		king-w-step
	{move}		king-s-step
	{move}		king-nw-step
	{move}		king-se-step
	{move}		king-sw-step
	{move}		king-ne-step
	{move}		O-O
	{move}		O-O-O
moves}

{moves king-moves
	{move}		n-step
	{move}		e-step
	{move}		w-step
	{move}		s-step
	{move}		nw-step
	{move}		se-step
	{move}		sw-step
	{move}		ne-step
moves}

{moves knight-moves
	{move}		nnw-leap
	{move}		nne-leap
	{move}		ssw-leap
	{move}		sse-leap
	{move}		wnw-leap
	{move}		wsw-leap
	{move}		ene-leap
	{move}		ese-leap
moves}

{moves bishop-moves
	{move}		nw-slide
	{move}		se-slide
	{move}		sw-slide
	{move}		ne-slide
moves}

{moves rook-i-moves
	{move}		rook-n-slide
	{move}		rook-e-slide
	{move}		rook-w-slide
	{move}		rook-s-slide
moves}

{moves rook-moves
	{move}		n-slide
	{move}		e-slide
	{move}		w-slide
	{move}		s-slide
moves}

{moves queen-moves
	{move}		n-slide
	{move}		e-slide
	{move}		w-slide
	{move}		s-slide
	{move}		nw-slide
	{move}		se-slide
	{move}		sw-slide
	{move}		ne-slide
moves}

{moves helgi-moves
	{move}		n-slide
	{move}		e-slide
	{move}		w-slide
	{move}		s-slide
	{move}		nw-slide
	{move}		se-slide
	{move}		sw-slide
	{move}		ne-slide
	{move}		nnw-leap
	{move}		nne-leap
	{move}		ssw-leap
	{move}		sse-leap
	{move}		wnw-leap
	{move}		wsw-leap
	{move}		ene-leap
	{move}		ese-leap
moves}

{pieces
	{piece}		PawnI		{moves} pawn-i-moves	1	{value}
	{piece}		PawnRook	{moves} pawn-moves	1	{value}
	{piece}		PawnRookE
	{piece}		PawnKnight	{moves} pawn-moves	1	{value}
	{piece}		PawnKnightE
	{piece}		PawnBishop	{moves} pawn-moves	1	{value}
	{piece}		PawnBishopE
	{piece}		PawnQueen	{moves} pawn-moves	1	{value}
	{piece}		PawnQueenE
	{piece}		PawnHelgi	{moves} pawn-moves	1	{value}
	{piece}		PawnHelgiE
	{piece}		KingI		{moves} king-i-moves	1000	{value}
	{piece}		King		{moves} king-moves	1000	{value}
	{piece}		KingE
	{piece}		RookI		{moves} rook-i-moves	5	{value}
	{piece}		Rook		{moves} rook-moves	5	{value}
	{piece}		RookP		{moves} rook-moves	5	{value}
	{piece}		RookE
	{piece}		Knight		{moves} knight-moves	3	{value}
	{piece}		KnightP		{moves} knight-moves	3	{value}
	{piece}		KnightE
	{piece}		Bishop		{moves} bishop-moves	3	{value}
	{piece}		BishopP		{moves} bishop-moves	3	{value}
	{piece}		BishopE
	{piece}		Queen		{moves} queen-moves	9	{value}
	{piece}		QueenP		{moves} queen-moves	9	{value}
	{piece}		QueenE
	{piece}		Helgi		{moves} helgi-moves	12	{value}
	{piece}		Mark
pieces}

{board-setup
	{setup}	Blue	RookI	a8
	{setup}	Blue	RookI	h8
	{setup}	Blue	Knight	b8
	{setup}	Blue	Knight	g8
	{setup}	Blue	Bishop	c8
	{setup}	Blue	Bishop	f8
	{setup}	Blue	Queen	d8
	{setup}	Blue	KingI	e8
	{setup}	Blue	PawnI	a7
	{setup}	Blue	PawnI	b7
	{setup}	Blue	PawnI	c7
	{setup}	Blue	PawnI	d7
	{setup}	Blue	PawnI	e7
	{setup}	Blue	PawnI	f7
	{setup}	Blue	PawnI	g7
	{setup}	Blue	PawnI	h7

	{setup}	Red	RookI	a1
	{setup}	Red	RookI	h1
	{setup}	Red	Knight	b1
	{setup}	Red	Knight	g1
	{setup}	Red	Bishop	c1
	{setup}	Red	Bishop	f1
	{setup}	Red	Queen	d1
	{setup}	Red	KingI	e1
	{setup}	Red	PawnI	a2
	{setup}	Red	PawnI	b2
	{setup}	Red	PawnI	c2
	{setup}	Red	PawnI	d2
	{setup}	Red	PawnI	e2
	{setup}	Red	PawnI	f2
	{setup}	Red	PawnI	g2
	{setup}	Red	PawnI	h2
board-setup}

' PawnI		IS PI
' RookI		IS RI
' KingI		IS KI
' PawnRook	IS PR
' PawnKnight	IS PK
' PawnBishop	IS PB
' PawnQueen	IS PQ
' PawnHelgi	IS PH
' Rook		IS ROOK
' Knight	IS KNIGHT
' Bishop	IS BISHOP
' Queen		IS QUEEN
' Helgi		IS HELGI
' Mark		IS MARK
