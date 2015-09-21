{players
	{player}	W
	{player}	B
	{player}	?C	{random}
players}

{turn-order
	{turn}	W	{of-type} normal
	{turn}	?C	{for-player} W	{of-type} clean
	{turn}	B	{of-type} normal
	{turn}	?C	{for-player} B	{of-type} clean
turn-order}
