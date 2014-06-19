LOAD Ur.4th ( Load the base Ur game )

VARIABLE BestScore		\ Keep track of the best score found so far by our search engine.
VARIABLE Nodes			\ The number of possibilities explored by our search engine.
VARIABLE Eated
VARIABLE Rosettes

: enemy-value-at ( pos -- value )
	DUP
	empty-at?
	IF
		DROP 0
	ELSE
		0 SWAP
		player-at current-player <>
		IF DROP 1 ENDIF
	ENDIF
;

: friend-value-at ( pos -- value )
	DUP
	empty-at?
	IF
		DROP 0
	ELSE
		1 SWAP
		player-at current-player <>
		IF DROP 0 ENDIF
	ENDIF
;

: Make_enemy_p  ( pos -- ) <BUILDS , DOES> @ enemy-value-at ;
: Make_friend_p ( pos -- ) <BUILDS , DOES> @ enemy-value-at ;

i1 Make_enemy_p e0
j1 Make_enemy_p e1
k1 Make_enemy_p e2
l1 Make_enemy_p e3
m1 Make_enemy_p e4
n1 Make_enemy_p e5
o1 Make_enemy_p e6
i5 Make_enemy_p e7
j5 Make_enemy_p e8
k5 Make_enemy_p e9
l5 Make_enemy_p e10
m5 Make_enemy_p e11
n5 Make_enemy_p e12
o5 Make_enemy_p e13

i2 Make_friend_p f0
i4 Make_friend_p f1
l3 Make_friend_p f2
o2 Make_friend_p f3
o4 Make_friend_p f4

: CountEated ( -- count )
	e0 e1 + e2 + e3 + e4 + e5 + e6 + e7 + e8 + e9 + e10 + e11 + e12 + e13 +
;

: CountRosettes ( -- count )
	f0 f1 + f2 + f3 + f4 +
;

: Score ( -- score )
	Eated @ CountEated < IF 10 ELSE 0 ENDIF
	Rosettes @ CountRosettes < IF 5 ELSE 0 ENDIF +
;

: Custom-Engine ( -- )
	-1000 BestScore !				\ Keep track of the best score.
	0 Nodes !					\ Count the number of possibilities explored.
	CountEated Eated !
	CountRosettes Rosettes !
(
  Notes:
  1 - We do not need to invoke $GenerateMoves since they have already been generated for the
  current player { since ZoG has called DLL_GenerateMoves prior to calling DLL_Search}.

  2 - ZoG does not invoke the search engine if there are no moves, so we can safely assume.
  that at least one move exists.  Thus we can use BEGIN..UNTIL instead of BEGIN...WHILE..REPEAT
  for iterating moves.
)
	$FirstMove					\ Obtain the address of the first move.

	BEGIN						\ Loop through all possible moves.
		$CloneBoard				\ Create a temporary copy of the current board.

		DUP $MoveString CurrentMove!		\ Inform ZoG of the current move being examined.

		DUP .moveCFA EXECUTE			\ Apply the move to the board by executing its code.

		Score					\ Calculate the score for the new board.
		BestScore @ OVER <			\ Have we found a better score?
		IF
			DUP BestScore !			\ Save the improved score.
			Score!				\ Inform ZoG of the improved score.
			0 Depth!

			DUP $MoveString BestMove!	\ Inform ZoG of the best move found so far.
		ELSE
			DROP 				\ We didn't find a better move, drop the score.
		ENDIF

		$DeallocateBoard			\ Done with the revised board.

		Nodes ++				\ Count one more node explored.
		Nodes @ Nodes!				\ Inform ZoG of the node count.

		$Yield					\ Allow ZoG to dispatch Windows messages.
		$NextMove				\ Advance to the next move.

		DUP NOT					\ No more moves?
	UNTIL						\ Until no more moves to explore.
	DROP						\ Move address
;

{players
	{player}	White	{search-engine} Custom-Engine
	{player}	Black	{search-engine} Custom-Engine
	{player}	?Dice	{random}
players}
