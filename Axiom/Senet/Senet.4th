LOAD	Board.4th

{players
	{player}	White	{random}
	{player}	Black	{random}
players}

{turn-order
	{turn}		Black
	{turn}		White
turn-order}

: check-finis ( -- )
	k2 here = IF
		k2 capture-at
	ENDIF
;

: check-neighbor ( 'dir -- ? )
	here SWAP
	EXECUTE IF
		enemy?
	ELSE
		FALSE
	ENDIF
	SWAP to
;

: check-neighbors ( -- ? )
	['] prev check-neighbor
	['] next check-neighbor XOR NOT
;

: check-enemy ( -- player ? )
	player
	enemy? check-neighbors AND empty? OR verify
	enemy?
;

: next-move ( 'dir n -- )
	BEGIN
		1-
		OVER EXECUTE OVER 0> AND NOT
	UNTIL 2DROP
	friend? NOT verify
	check-enemy
	from here move
	IF from create-player-at ELSE DROP ENDIF
	check-finis
	add-move
;

: next-1 ( -- ) ['] next 1 next-move ;
: next-2 ( -- ) ['] next 2 next-move ;
: next-3 ( -- ) ['] next 3 next-move ;
: next-4 ( -- ) ['] next 4 next-move ;
: next-5 ( -- ) ['] next 5 next-move ;

: back-1 ( -- ) ['] prev 1 next-move ;
: back-2 ( -- ) ['] prev 2 next-move ;
: back-3 ( -- ) ['] prev 3 next-move ;
: back-4 ( -- ) ['] prev 4 next-move ;
: back-5 ( -- ) ['] prev 5 next-move ;

{moves man-moves
	{move} next-1   {move-type} normal-type
	{move} next-2   {move-type} normal-type
	{move} next-3   {move-type} normal-type
	{move} next-4   {move-type} normal-type
	{move} next-5   {move-type} normal-type
	{move} back-1   {move-type} back-type
	{move} back-2   {move-type} back-type
	{move} back-3   {move-type} back-type
	{move} back-4   {move-type} back-type
	{move} back-5   {move-type} back-type
	{move} Pass	{move-type} pass-type
moves}

{move-priorities
	{move-priority} priority-type
	{move-priority} normal-type
	{move-priority} back-type
	{move-priority} pass-type
move-priorities}

{pieces
	{piece}		Man	{moves} man-moves
pieces}

: OnNewGame ( -- )
	RANDOMIZE
;

{board-setup
	{setup}	White 	Man a4
	{setup}	White 	Man c4
	{setup}	White 	Man e4
	{setup}	White 	Man g4
	{setup}	White 	Man i4

	{setup}	Black 	Man b4
	{setup}	Black 	Man d4
	{setup}	Black 	Man f4
	{setup}	Black 	Man h4
	{setup}	Black 	Man j4
board-setup}
