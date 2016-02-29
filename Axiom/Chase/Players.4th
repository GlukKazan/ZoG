{players
	{player}	Red
	{player}	White
	{player}	?R	{random}
players}

{turn-order
	{turn}	Red
	{turn}	?R	{for-player} White	{of-type} clear-mode
	{turn}	White
	{turn}	?R	{for-player} Red	{of-type} clear-mode
turn-order}
