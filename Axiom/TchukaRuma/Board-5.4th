5	CONSTANT	COLS

{board
	{position}	a
	{position}	b
	{position}	c
	{position}	d
	{position}	home
board}

{directions
	{link} next a b
	{link} next b c
	{link} next c d
	{link} next d home
	{link} next home a
directions}
