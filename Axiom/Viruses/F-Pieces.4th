VARIABLE	current-color
TOTAL []	pieces[]
VARIABLE	pieces-count

: add-to-pieces ( -- )
	TRUE 0 BEGIN
		DUP pieces-count @ >= IF
			TRUE
		ELSE
			DUP here = IF
				SWAP DROP FALSE SWAP
				TRUE
			ELSE
				1+ FALSE
			ENDIF
		ENDIF
	UNTIL DROP
	pieces-count @ TOTAL AND < IF
		here pieces-count @ pieces[] !
		pieces-count ++
	ENDIF
;

: visit-neigbor ( -- )
	EXECUTE IF
		player ? N = piece-type current-color = AND friend? OR IF
			add-to-pieces
		ENDIF
	ENDIF
;

: visit-neigbors ( -- )
	here ['] n  visit-neigbor to
	here ['] s  visit-neigbor to
	here ['] w  visit-neigbor to
	here ['] e  visit-neigbor to
;

: change-color ( -- )
	0 pieces[] to visit-neigbors
	1 BEGIN
		DUP pieces-count @ >= IF
			TRUE
		ELSE
			DUP pieces[] @ to
			player ?N = IF
				create
			ENDIF
			friend? piece-type current-color <> AND IF
				current-color change-type
			ENDIF
			1+ FALSE
		ENDIF
	UNTIL DROP
;

: drop-piece ( -- )
	current-player ?N <> verify
	piece-type current-piece-type = verify
	player ?N = verify
	current-player B = IF a10 ELSE j1 ENDIF
	piece-type-at piece-type <> verify
	piece-type current-color !
	drop
	0 pieces-count !
	add-to-pieces
	change-color
	add-move
;

: init-piece ( -- )
	current-player ?N = verify
	empty? verify
	drop
	add-move
;

{move-priorities
	{move-priority} normal-type
	{move-priority} pass-type
move-priorities}

{moves drop-pieces
	{move} init-piece  {move-type} normal-type
	{move} drop-piece  {move-type} normal-type
	{move} Pass	   {move-type} pass-type
moves}

{pieces
	{piece}		r	{drops} drop-pieces
pieces}

{board-setup
	{setup}	B 	b j1
	{setup}	R 	r a10
board-setup}
