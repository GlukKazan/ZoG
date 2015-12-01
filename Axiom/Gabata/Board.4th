3	CONSTANT	ROWS
8	CONSTANT	COLS

{board
	ROWS COLS	{grid}
board}

{directions
	1 0 {direction} side

	{link} side b1 b3
	{link} side c1 c3
	{link} side d1 d3
	{link} side e1 e3
	{link} side f1 f3
	{link} side g1 g3

	{link} next b1 c1
	{link} next c1 d1
	{link} next d1 e1
	{link} next e1 f1
	{link} next f1 g1
	{link} next g1 g2
	{link} next g2 f2
	{link} next f2 e2
	{link} next e2 g3
	{link} next g3 f3
	{link} next f3 e3
	{link} next e3 d3
	{link} next d3 c3
	{link} next c3 b3
	{link} next b3 b2
	{link} next b2 c2
	{link} next c2 d2
	{link} next d2 b1
directions}
