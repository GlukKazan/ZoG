DIM 2 *		CONSTANT	COLS
COLS DUP *	CONSTANT	PLANE

{board
	ROWS COLS	{grid}
board}

{directions
	-1	 0	{direction} n-internal
	 1	 0	{direction} s-internal
	 0	 1	{direction} e
	 0	-1	{direction} w
	-1	-1	{direction} nw
	 1	-1	{direction} sw
	-1	 1	{direction} ne
	 1	 1	{direction} se
directions}

TOTAL []	piece-group[]
VARIABLE	piece-group-head
VARIABLE	piece-group-tail
VARIABLE	result
