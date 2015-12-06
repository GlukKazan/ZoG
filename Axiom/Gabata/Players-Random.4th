{players
	{player} First	{random}
	{player} Second	{random}
players}

{turn-order
	{turn}	 First
	{turn}	 Second
turn-order}

: OnNewGame ( -- )
	RANDOMIZE
;
