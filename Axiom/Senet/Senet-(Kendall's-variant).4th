LOAD	Senet.4th

VARIABLE not-water?

: check-neighbors ( -- ? )
	['] prev check-neighbor
	['] next check-neighbor OR NOT
;

: check-enemy ( -- player ? )
	player
	enemy? check-neighbors AND empty? OR verify
	enemy?
;

: clear-repeat ( -- )
	k1 empty-at? NOT IF
		k1 capture-at
	ENDIF
;

: next-move ( 'dir n -- )
	here f2 < verify
	DUP check-dices
	BEGIN
		1-
		OVER EXECUTE 
		DUP NOT IF
			here a4 > verify
		ENDIF
		OVER 0> AND NOT
	UNTIL 2DROP
	friend? NOT verify
	check-enemy
	from here move
	IF from create-player-at ELSE DROP ENDIF
	check-repeat
	add-move
;

: priv-move ( 'dir n -- )
	here f2 >= verify
	here g2 = NOT verify
	TRUE not-water? !
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
	DUP 0> IF
		BEGIN
			1-
			OVER EXECUTE OVER 0> AND NOT
		UNTIL 2DROP
	ENDIF
	g2 here = IF
		FALSE not-water? !
	ENDIF
	empty? IF
		from here move
		check-finis
	ELSE
		friend? NOT verify
		check-enemy
		from here move
		IF
			g2 empty-at? IF
				g2
			ELSE
				from
			ENDIF
			create-player-at
		ELSE
			DROP
		ENDIF
	ENDIF
	not-water? @ IF
		check-repeat
	ELSE
		clear-repeat
	ENDIF
	add-move
;

: water-4 ( -- )
	here g2 = verify
	4 check-dices
	k2 to
	from here move
	check-finis
	clear-repeat
	add-move
;

: water-x ( -- )
	here g2 = verify
	f3 to empty? verify
	from here move
	clear-repeat
	add-move
;

: to-water ( -- )
	here g2 > verify
	here j2 < verify
	g2 to empty? verify
	from here move
	clear-repeat
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
	{move} water-4   {move-type} priority-type
	{move} water-x   {move-type} water-type
	{move} to-water  {move-type} return-type
	{move} priv-1    {move-type} normal-type
	{move} priv-2    {move-type} normal-type
	{move} priv-3    {move-type} normal-type
	{move} priv-4    {move-type} normal-type
	{move} priv-5    {move-type} normal-type
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
	{move-priority} water-type
	{move-priority} normal-type
	{move-priority} back-type
	{move-priority} return-type
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
	{setup}	White 	Man c4
	{setup}	White 	Man e4
	{setup}	White 	Man g4
	{setup}	White 	Man i4
	{setup}	White 	Man j3
	{setup}	White 	Man h3

	{setup}	Black 	Man b4
	{setup}	Black 	Man d4
	{setup}	Black 	Man f4
	{setup}	Black 	Man h4
	{setup}	Black 	Man j4
	{setup}	Black 	Man i3
	{setup}	Black 	Man g3
board-setup}
