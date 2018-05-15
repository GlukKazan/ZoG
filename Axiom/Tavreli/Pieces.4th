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
	{move}		O-O
	{move}		O-O-O
moves}

{pieces
	{piece}		PawnI		{moves} pawn-i-moves
	{piece}		PawnRook	{moves} pawn-moves
	{piece}		PawnRookE
	{piece}		PawnKnight	{moves} pawn-moves
	{piece}		PawnKnightE
	{piece}		PawnBishop	{moves} pawn-moves
	{piece}		PawnBishopE
	{piece}		PawnQueen	{moves} pawn-moves
	{piece}		PawnQueenE
	{piece}		PawnHelgi	{moves} pawn-moves
	{piece}		PawnHelgiE
	{piece}		KingI		{moves} king-i-moves
	{piece}		King
	{piece}		KingE
	{piece}		RookI
	{piece}		Rook
	{piece}		RookP
	{piece}		RookE
	{piece}		Knight
	{piece}		KnightP
	{piece}		KnightE
	{piece}		Bishop
	{piece}		BishopP
	{piece}		BishopE
	{piece}		Queen
	{piece}		QueenP
	{piece}		QueenE
	{piece}		Helgi
	{piece}		HelgiP
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

' PawnI IS PI
' RookI IS RI
