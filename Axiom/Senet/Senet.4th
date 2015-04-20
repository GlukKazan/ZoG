LOAD	Board.4th

VARIABLE prev-enemy

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

: to-water ( -- )
	g2 to empty? IF
		from here move
	ELSE
		f3 to
		BEGIN
			empty? IF
				from here move
				TRUE
			ELSE
				prev NOT
			ENDIF
		UNTIL
	ENDIF
;

: next-move ( 'dir n -- )
	( TODO: Check Dices )
	FALSE prev-enemy !
	BEGIN
		1-
		enemy? DUP IF
			prev-enemy @ NOT verify
		ENDIF prev-enemy !
		OVER EXECUTE OVER 0> AND NOT
	UNTIL 2DROP
	here f2 = empty? NOT AND IF
		to-water
	ELSE
		friend? NOT verify
		check-enemy
		from here move
		IF from create-player-at ELSE DROP ENDIF
	ENDIF
	add-move
;

: priv-move ( 'dir n -- )
	j2 here = IF
		DROP 1
	ENDIF
	( TODO: Check Dices )
	here f2 >= verify
	h2 here = IF
		DUP 3 = verify
	ENDIF
	i2 here = IF
		DUP 2 = verify
	ENDIF
	g2 here = IF
		DUP 4 <= verify
		DUP 4 < IF
			DROP 0
		ENDIF
	ENDIF
	DUP 0> IF
		BEGIN
			1-
			OVER EXECUTE OVER 0> AND NOT
		UNTIL 2DROP
	ENDIF
	empty? IF
		from here move
		check-finis
	ELSE
		to-water
	ENDIF
	add-move
;

: priv-1 ( -- ) ['] priv 1 priv-move ;
: priv-2 ( -- ) ['] priv 2 priv-move ;
: priv-3 ( -- ) ['] priv 3 priv-move ;
: priv-4 ( -- ) ['] priv 4 priv-move ;
: priv-5 ( -- ) ['] priv 5 priv-move ;

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
	{move} priv-1   {move-type} priority-type
	{move} priv-2   {move-type} priority-type
	{move} priv-3   {move-type} priority-type
	{move} priv-4   {move-type} priority-type
	{move} priv-5   {move-type} priority-type
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
