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

	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup

	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup
	{turn}	?Common	{of-type} setup

	{repeat}
	{turn}	First	{for-player} ?Common
	{turn}	Second	{for-player} ?Common
turn-order}

: OnNewGame ( -- )
	RANDOMIZE
;
