LOAD	Board.4th

VARIABLE prev-enemy
VARIABLE piece-counter

{players
	{player}	White	 {random}
	{player}	Black	 {random}
	{player}	?White	 {random}
	{player}	?Black	 {random}
	{player}	?Counter {random}
players}

{turn-order
	{turn}	?Black	 {of-type} dice-type
	{turn}	?Black	 {of-type} dice-type
	{turn}	?Black	 {of-type} dice-type
	{turn}	?Black	 {of-type} dice-type
	{turn}	Black
	{turn}	?White	 {of-type} dice-type
	{turn}	?White	 {of-type} dice-type
	{turn}	?White	 {of-type} dice-type
	{turn}	?White	 {of-type} dice-type
	{turn}	White
	{turn}	?Counter {of-type} counter-type
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

DEFER		MARK

: check-dices ( n -- )
	k1 enemy-at? IF
		DROP 0
	ENDIF
	g1 piece-at piece-value
	h1 piece-at piece-value +
	i1 piece-at piece-value +
	j1 piece-at piece-value +
	DUP 0= IF
		DROP 5
	ENDIF
	= verify
;

: check-repeat ( -- )
	g1 piece-at piece-value
	h1 piece-at piece-value +
	i1 piece-at piece-value +
	j1 piece-at piece-value +
	DUP 2 = SWAP 3 = OR IF
		k1 empty-at? NOT IF
			k1 capture-at
		ENDIF
	ELSE
		k1 empty-at? IF
			MARK k1 create-piece-type-at
		ENDIF
	ENDIF
;

: next-move ( 'dir n -- )
	DUP check-dices
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
	check-repeat
	add-move
;

: priv-move ( 'dir n -- )
	j2 here = IF
		DROP 1
	ENDIF
	DUP check-dices
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
	check-repeat
	add-move
;

: drop-dice ( -- )
	here g1 >=  verify
	here k1 <   verify
	friend? NOT verify
	drop
	add-move
;

: drop-mark ( -- )
	here f1 = verify
	drop
	a1 to
	BEGIN
		empty? IF
			MARK create-piece-type
			TRUE
		ELSE
			capture
			cnt NOT
		ENDIF
	UNTIL
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
	{move} priv-1    {move-type} priority-type
	{move} priv-2    {move-type} priority-type
	{move} priv-3    {move-type} priority-type
	{move} priv-4    {move-type} priority-type
	{move} priv-5    {move-type} priority-type
	{move} next-1    {move-type} normal-type
	{move} next-2    {move-type} normal-type
	{move} next-3    {move-type} normal-type
	{move} next-4    {move-type} normal-type
	{move} next-5    {move-type} normal-type
	{move} back-1    {move-type} back-type
	{move} back-2    {move-type} back-type
	{move} back-3    {move-type} back-type
	{move} back-4    {move-type} back-type
	{move} back-5    {move-type} back-type
	{move} Pass	 {move-type} pass-type
moves}

{moves dice-drops
	{move} drop-dice {move-type} dice-type
moves}

{moves counter-drops
	{move} drop-mark {move-type} counter-type
moves}

{move-priorities
	{move-priority} priority-type
	{move-priority} normal-type
	{move-priority} back-type
	{move-priority} pass-type
move-priorities}

{pieces
	{piece}		Man	{moves} man-moves
	{piece}		Mark	{drops} counter-drops
	{piece}		Zero	{drops} dice-drops	0 {value}
	{piece}		One	{drops} dice-drops	1 {value}
pieces}

' Mark	IS MARK

: OnNewGame ( -- )
	RANDOMIZE
;

: calc-pieces ( player -- n )
	0 piece-counter !
	k2 BEGIN
		1-
		OVER OVER player-at = IF
			piece-counter ++
		ENDIF
		DUP 0=
	UNTIL 2DROP
	piece-counter @
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	White calc-pieces 0= IF
		current-player Black = IF
			DROP
			#LossScore
		ENDIF
		current-player White = IF
			DROP
			#WinScore
		ENDIF
	ENDIF
	Black calc-pieces 0= IF
		current-player White = IF
			DROP
			#LossScore
		ENDIF
		current-player Black = IF
			DROP
			#WinScore
		ENDIF
	ENDIF
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
