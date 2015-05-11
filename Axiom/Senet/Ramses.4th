LOAD	Senet-(my-variant).4th

VARIABLE prev-enemy

{turn-order
	{turn}	?White	 {of-type} dice-type
	{turn}	?White	 {of-type} dice-type
	{turn}	?White	 {of-type} dice-type
	{turn}	?White	 {of-type} dice-type
	{turn}	White
	{turn}	?Black	 {of-type} dice-type
	{turn}	?Black	 {of-type} dice-type
	{turn}	?Black	 {of-type} dice-type
	{turn}	?Black	 {of-type} dice-type
	{turn}	Black
	{turn}	?Counter {of-type} counter-type
turn-order}

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
	here f2 < verify
	DUP check-dices
	FALSE prev-enemy !
	BEGIN
		1-
		enemy? DUP IF
			prev-enemy @ NOT verify
		ENDIF prev-enemy !
		OVER EXECUTE 
		DUP NOT IF
			here a4 > verify
		ENDIF
		OVER 0> AND NOT
	UNTIL 2DROP
	here f2 = empty? NOT AND IF
		to-water
	ELSE
		friend? NOT verify
		check-enemy
		from here move
		IF from create-player-at ELSE DROP ENDIF
	ENDIF
	here f3 = IF
		k1 empty-at? IF
			MARK k1 create-piece-type-at
		ENDIF
	ELSE
		from f3 = IF
			k1 empty-at? NOT IF
				k1 capture-at
			ENDIF
		ELSE
			check-repeat
		ENDIF
	ENDIF
	add-move
;

: priv-move ( 'dir n -- )
	here f2 >= verify
	DUP check-dices
	h2 here = IF
		DUP 3 = verify
	ENDIF
	i2 here = IF
		DUP 2 = verify
	ENDIF
	j2 here = IF
		DUP 1 = verify
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

{board-setup
	{setup}	White 	Man a4
	{setup}	White 	Man b4
	{setup}	White 	Man c4
	{setup}	White 	Man d4
	{setup}	White 	Man e4

	{setup}	Black 	Man f4
	{setup}	Black 	Man g4
	{setup}	Black 	Man h4
	{setup}	Black 	Man i4
	{setup}	Black 	Man j4
board-setup}
