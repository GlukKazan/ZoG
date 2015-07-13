{players
	{player}	?C	{random}
	{player}	First
	{player}	Second
players}

{turn-order
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup

	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup

	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup

	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup

	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup

	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup
	{turn}	?C	{of-type} setup

	{repeat}
	{turn}	First	{for-player} ?C
	{turn}	Second	{for-player} ?C
turn-order}

: OnNewGame ( -- )
	RANDOMIZE
;
