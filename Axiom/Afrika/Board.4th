2	CONSTANT	ROWS
8	CONSTANT	COLS

{board
	ROWS COLS	{grid}
	{position}	west
	{position}	east
board}

{directions
	-1 0 {direction} north
	 1 0 {direction} south
	{link} next a1 b1
	{link} next b1 c1
	{link} next c1 d1
	{link} next d1 e1
	{link} next e1 f1
	{link} next f1 g1
	{link} next g1 h1
	{link} next h1 h2
	{link} next h2 g2
	{link} next g2 f2
	{link} next f2 e2
	{link} next e2 d2
	{link} next d2 c2
	{link} next c2 b2
	{link} next b2 a2
	{link} next a2 a1
directions}

{symmetries 
	Second {symmetry} north south
symmetries}
