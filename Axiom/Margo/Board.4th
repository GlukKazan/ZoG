DIM 2 *		CONSTANT	COLS
COLS DIM *	CONSTANT	ROWS
COLS NEGATE	CONSTANT	UDIR
ROWS COLS -	CONSTANT	BRIR

{board
	ROWS COLS	{grid}
board}

{directions
	-1	 0	{direction} n
	 1	 0	{direction} s
	 0	 1	{direction} e
	 0	-1	{direction} w
	 COLS	 0 	{direction} d
	 UDIR	 0 	{direction} u
	 BDIR	 0 	{direction} b
directions}
