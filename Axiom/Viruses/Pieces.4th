TOTAL []	pieces[]
VARIABLE	pieces-count

DEFER	ALIVE

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

: visit-neigbor ( 'dir -- )
	EXECUTE friend? AND IF
		add-to-pieces
	ENDIF
;

: visit-neighbors ( -- )
	here ['] n  visit-neigbor to
	here ['] s  visit-neigbor to
	here ['] w  visit-neigbor to
	here ['] e  visit-neigbor to
	here ['] nw visit-neigbor to
	here ['] sw visit-neigbor to
	here ['] ne visit-neigbor to
	here ['] se visit-neigbor to
;

: check-neighbors ( -- )
	0 pieces-count !
	visit-neighbors
	FALSE 0 BEGIN
		DUP pieces-count @ >= IF
			TRUE
		ELSE
			DUP piece-at ALIVE = IF
				SWAP DROP TRUE SWAP
				TRUE
			ELSE
				DUP to visit-neighbors
				1+ FALSE
			ENDIF
		ENDIF
	UNTIL DROP
	verify
;

: drop-alive ( -- )
	empty? verify
	drop
	check-neighbors
	add-move
;

: drop-dead ( -- )
	enemy? piece ALIVE = AND verify
	drop
	check-neighbors
	add-move
;

{moves alive-moves
	{move} drop-alive
moves}

{moves dead-moves
	{move} drop-dead
moves}

{pieces
	{piece}		Alive	{drops} alive-moves	ALIVE-VALUE	{value}
	{piece}		Dead	{drops} dead-moves	DEAD-VALUE	{value}
pieces}

' Alive	IS ALIVE

{board-setup
	{setup}	Blue 	Alive j1
	{setup}	Red 	Alive a10
board-setup}
