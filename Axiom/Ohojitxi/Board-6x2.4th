2	CONSTANT	COLS
6	CONSTANT	ROWS

{board
	ROWS COLS	{grid}
board}

{directions
	{link} next a1 b1 {link} prev b1 a1
	{link} next b1 b2 {link} prev b2 b1
	{link} next b2 b3 {link} prev b3 b2
	{link} next b3 a3 {link} prev a3 b3
	{link} next a3 a2 {link} prev a2 a3
	{link} next a2 a1 {link} prev a1 a2

	{link} next b6 a6 {link} prev a6 b6
	{link} next a6 a5 {link} prev a5 a6
	{link} next a5 a4 {link} prev a4 a5
	{link} next a4 b4 {link} prev b4 a4
	{link} next b4 b5 {link} prev b5 b4
	{link} next b5 b6 {link} prev b6 b5

	{link} to-s a1 a6 {link} to-f a1 b1
directions}
