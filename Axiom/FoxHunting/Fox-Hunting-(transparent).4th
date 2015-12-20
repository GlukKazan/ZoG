LOAD Tarnsparent-TRUE.4th
LOAD Players.4th
LOAD Board.4th
LOAD Pieces.4th
LOAD AI.4th

{moves fox-moves
	{move} setup-drop	{move-type} setup
	{move} normal-drop	{move-type} normal
moves}

{pieces
	{piece}		d0
	{piece}		d1
	{piece}		d2
	{piece}		d3
	{piece}		d4
	{piece}		d5
	{piece}		d6
	{piece}		d7
	{piece}		d8

	{piece}		fox	{drops} fox-moves
pieces}

' d0	IS ZERO
' fox	IS FOX
