DEFER		AI

{players
	{player}	?C	{random}
	{player}	First	{search-engine}	AI
	{player}	Second	{search-engine}	AI
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
