\ LOAD this file if your game requires repetition detection.

VARIABLE RepetitionCount	\ The number of repetitions for the current position.

\ Define a simple predicate to test repetition to be used within OnIsGameOver.
: repetition? ( -- ? )
	RepetitionCount  @ 3 >=
;

: ResetRepetition
	repetition-reset
	0 RepetitionCount !
;

\ Sets the first position for repetition detection.
: SetInitialPosition
	ResetRepetition
	repetition-push-position DROP
;

\
\ Event Overrides
\

\ Save the position after advancing the turn.
: OnNextTurn
	OnNextTurn
	repetition-push-position RepetitionCount !
;

\ Executed when the engine retracts a tentative move.
\   Here we remove the last move from the repetition detector.
: OnRetractMove ( -- )
	OnRetractMove
	repetition-pop-position	\ Remove the tentative move from the repetition detector.
	0 RepetitionCount !	\ Reset the repetition counter.
;

\ Reset repetition at game start.
: OnNewGame
	ResetRepetition
;

\ Board edits restart repetition detection.
\   Note: OnIsGameOver is executed prior to setup so we are forced to initialize here!
: OnEditAdd
	OnEditAdd
	SetInitialPosition
;

: OnEditRemove
	OnEditRemove
	SetInitialPosition
;