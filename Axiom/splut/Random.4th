LOAD Splut.4th ( Load the base Splut game )

{players
	{player}	South	 {random}
	{neutral}	West
	{player}	North	 {random}
	{neutral}	East
	{player}	?Cleaner {random}
players}

{turn-order
	{turn}	South
	{turn}	North
	{turn}	North
	{repeat}
	{turn}  ?Cleaner {of-type} clear-type
	{turn}	South
	{turn}	South
	{turn}	South
	{turn}	North
	{turn}	North
	{turn}	North
turn-order}

{board-setup
	{setup}	South sstone e1
	{setup}	South wizard f2
	{setup}	South dwarf  e2
	{setup}	South troll  d2
	{setup}	South lock   f1

	{setup}	West  wstone a5

	{setup}	North nstone e9
	{setup}	North wizard f8
	{setup}	North dwarf  e8
	{setup}	North troll  d8
	{setup}	North lock   h1

	{setup}	East  estone i5
board-setup}

