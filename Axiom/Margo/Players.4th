{players
	{player}	W
	{player}	B
	{player}	?C	{random}
players}

{turn-order
	{turn}	W	{of-type} high-priority
	{turn}	?C	{for-player} W
	{turn}	B	{of-type} high-priority
	{turn}	?C	{for-player} B
turn-order}
