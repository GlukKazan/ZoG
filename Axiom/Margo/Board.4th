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
	-1	-1	{direction} nw-internal
	 1	-1	{direction} sw-internal
	-1	 1	{direction} ne-internal
	 1	 1	{direction} se-internal
directions}

TOTAL []	pieces[]
VARIABLE	pieces-count
TOTAL []	zombies[]
VARIABLE	zombies-count
