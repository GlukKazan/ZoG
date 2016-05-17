{players
	{player}	Light
	{player}	Dark
	{player}	?Owner	{random}
players}

{turn-order
	{turn}	?Owner	{of-type} setup-1
	{turn}	?Owner	{of-type} setup-2
	{turn}	?Owner	{of-type} setup-3
	{turn}	?Owner	{of-type} setup-4
	{turn}	?Owner	{of-type} setup-3
	{turn}	?Owner	{of-type} setup-4
	{turn}	?Owner	{of-type} setup-5
	{turn}	?Owner	{of-type} setup-6
	{repeat}
	{turn}		Light	{for-player} ?Owner
	{turn}		Dark	{for-player} ?Owner
turn-order}
