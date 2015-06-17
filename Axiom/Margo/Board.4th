DIM 2 *		CONSTANT	COLS
COLS DIM *	CONSTANT	ROWS
COLS NEGATE	CONSTANT	UDIR
ROWS COLS -	CONSTANT	BDIR

{board
	ROWS COLS	{grid}
board}

{directions
	-1	 0	{direction} n
	 1	 0	{direction} s
	 0	 1	{direction} e
	 0	-1	{direction} w
	-1	-1	{direction} nw
	 1	-1	{direction} sw
	-1	 1	{direction} ne
	 1	 1	{direction} se
	 COLS	 0 	{direction} d
	 UDIR	 0 	{direction} u
	 BDIR	 0 	{direction} b
directions}
