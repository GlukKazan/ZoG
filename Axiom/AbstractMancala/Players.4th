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
	{turn}	First	{for-player} ?C {of-type} normal
	{turn}	Second	{for-player} ?C {of-type} normal
turn-order}

: OnNewGame ( -- )
	RANDOMIZE
;
