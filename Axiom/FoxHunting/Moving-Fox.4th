LOAD Tarnsparent-FALSE.4th
LOAD Players-Moving.4th
LOAD Board.4th
LOAD Pieces.4th
LOAD AI.4th

{moves fox-drops
	{move} setup-drop	{move-type} setup
	{move} normal-drop	{move-type} normal
moves}

{moves fox-moves
	{move} move-n		{move-type} moving
	{move} move-s		{move-type} moving
	{move} move-w		{move-type} moving
	{move} move-e		{move-type} moving
	{move} Pass		{move-type} moving
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

	{piece}		fox	{drops} fox-drops {moves} fox-moves
pieces}

' d0	IS ZERO
' fox	IS FOX
