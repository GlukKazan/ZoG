4	CONSTANT	COLS
8	CONSTANT	ROWS

{board
	ROWS COLS	{grid}
board}

{directions
	 0 2 {direction} up

	{link} next a1 b1 {link} prev b1 a1
	{link} next b1 b2 {link} prev b2 b1
	{link} next b2 b3 {link} prev b3 b2
	{link} next b3 b4 {link} prev b4 b3
	{link} next b4 a4 {link} prev a4 b4
	{link} next a4 a3 {link} prev a3 a4
	{link} next a3 a2 {link} prev a2 a3
	{link} next a2 a1 {link} prev a1 a2

	{link} next c1 d1
	{link} next d1 d2
	{link} next d2 d3
	{link} next d3 d4
	{link} next d4 c4
	{link} next c4 c3
	{link} next c3 c2
	{link} next c2 c1

	{link} next b8 a8 {link} prev a8 b8
	{link} next a8 a7 {link} prev a8 a7
	{link} next a7 a6 {link} prev a6 a7
	{link} next a6 a5 {link} prev a5 a6
	{link} next a5 b5 {link} prev b5 a5
	{link} next b5 b6 {link} prev b6 b5
	{link} next b6 b7 {link} prev b7 b6
	{link} next b7 b8 {link} prev b8 b7

	{link} next d8 c8
	{link} next c8 c7
	{link} next c7 c6
	{link} next c6 c5
	{link} next c5 d5
	{link} next d5 d6
	{link} next d6 d7
	{link} next d7 d8

	{link} to-s a1 a8 {link} to-f a1 b1
directions}
