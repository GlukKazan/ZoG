LOAD Ur.4th ( Load the base Ur game )

VARIABLE BestScore		\ Keep track of the best score found so far by our search engine.
VARIABLE Nodes			\ The number of possibilities explored by our search engine.
VARIABLE Eated
VARIABLE Rosettes

: CountEated ( -- count )
	0
	i1 enemy-at? IF 1+ ENDIF
	j1 enemy-at? IF 1+ ENDIF
	k1 enemy-at? IF 1+ ENDIF
	l1 enemy-at? IF 1+ ENDIF
	m1 enemy-at? IF 1+ ENDIF
	n1 enemy-at? IF 1+ ENDIF
	o1 enemy-at? IF 1+ ENDIF
	i5 enemy-at? IF 1+ ENDIF
	j5 enemy-at? IF 1+ ENDIF
	k5 enemy-at? IF 1+ ENDIF
	l5 enemy-at? IF 1+ ENDIF
	m5 enemy-at? IF 1+ ENDIF
	n5 enemy-at? IF 1+ ENDIF
	o5 enemy-at? IF 1+ ENDIF
;

: CountRosettes ( -- count )
	0
	i2 friend-at? IF 1+ ENDIF
	i4 friend-at? IF 1+ ENDIF
	l3 friend-at? IF 1+ ENDIF
	o2 friend-at? IF 1+ ENDIF
	o4 friend-at? IF 1+ ENDIF
;

: Score ( -- score )
	CountEated Eated @ - 2 *
	CountRosettes Rosettes @ - +
	current-player Black = IF NEGATE ENDIF
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
