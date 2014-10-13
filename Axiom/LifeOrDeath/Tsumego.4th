LOAD Go.4th
LOAD Common.4th

\ $gameLog	ON

0	CONSTANT	MIN_WX
0	CONSTANT	MIN_WY
5	CONSTANT	MAX_WX
5	CONSTANT	MAX_WY

0	CONSTANT	MIN_BX
0	CONSTANT	MIN_BY
5	CONSTANT	MAX_BX
5	CONSTANT	MAX_BY

: between? ( x min max -- ? )
	ROT DUP ROT <=
	ROT ROT <= AND
;

: check-move ( -- ? )
	current-player White = IF
		here get-x MIN_WX MAX_WX between?
		here get-y MIN_WY MAX_WY between? AND
	ENDIF
	current-player Black = IF
		here get-x MIN_BX MAX_BX between?
		here get-y MIN_BY MAX_BY between? AND
	ENDIF
;

' check-move		IS CHECK-MOVE

: check-win-player ( gameResult player -- gameResult )
	DUP get-raw raw-size @ 
	0= IF
		current-player = IF
			2DROP #LossScore
		ELSE
			2DROP #WinScore
		ENDIF
	ELSE
		FALSE BEGIN
			get-group IF
				calc-eyes eyes-cnt @ 2 >= IF
					DROP TRUE TRUE
				ELSE
					FALSE
				ENDIF
			ELSE
				TRUE
			ENDIF
		UNTIL
		IF
			current-player = IF
				2DROP #WinScore
			ELSE
				2DROP #LossScore
			ENDIF
		ELSE
			DROP
		ENDIF
	ENDIF
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore
	move-counter @ 0> IF
		White check-win-player
		Black check-win-player
	ENDIF
;

{board-setup
	{setup}	White	Stone	a18
	{setup}	White	Stone	b18
	{setup}	White	Stone	c18
	{setup}	White	Stone	d18
	{setup}	White	Stone	d19

	{setup}	Black	Stone	b15
	{setup}	Black	Stone	b17
	{setup}	Black	Stone	c17
	{setup}	Black	Stone	d17
	{setup}	Black	Stone	e18
	{setup}	Black	Stone	f18
board-setup}
