ROWS COLS *	CONSTANT	PLANE

{board
	ROWS 2 * COLS	{grid}
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
	 ROWS	 0	{direction} u
directions}
