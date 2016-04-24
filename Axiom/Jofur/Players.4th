{players
	{player}	Light
	{player}	Dark
	{player}	?Owner	{random}
players}

{turn-order
	{turn}		Light	{for-player} ?Owner
	{turn}		Dark	{for-player} ?Owner
turn-order}
