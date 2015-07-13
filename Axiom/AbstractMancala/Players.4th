{players
	{player}	?Common	{random}
	{player}	First
	{player}	Second
players}

{turn-order
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup

	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup

	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup

	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup

	{repeat}
	{turn}	First	{of-type} normal {for-player} ?Common
	{turn}	Second	{of-type} normal {for-player} ?Common
turn-order}
