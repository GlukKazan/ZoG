DEFER	MARK

: drop-bean ( -- )
	current-player ?C = verify
	here PLANE < verify
	empty? IF
		0
	ELSE
		piece piece-value
	ENDIF
	DUP LIMIT < verify
	current-piece-type +
	drop
	create-piece-type
	add-move
;

: check-last ( -- )
	ALL BEGIN
		1-
		DUP not-empty-at? IF
			DUP piece-type-at MARK = IF
				DUP player-at current-player = verify
				from to up verify
				DUP here = verify
			ENDIF
		ENDIF
		DUP 0=
	UNTIL DROP
	from to
;

: inc-piece ( -- )
	0 BEGIN
		DUP size @ < IF
			DUP pos[] @ here = IF
				TRUE
			ELSE
				1+
				FALSE
			ENDIF
		ELSE
			TRUE
		ENDIF
	UNTIL
	DUP size @ < IF
		DUP val[] @
		0 curr-piece !
	ELSE
		DUP SIZE < verify
		here OVER pos[] !
		piece piece-value
		here from = IF
			DROP 0
		ENDIF
		size ++
	ENDIF
	DUP 20 < verify
	1+ SWAP val[] !
;

: move-piece ( 'dir -- )
	check-last
	piece piece-value
	DUP curr-piece !
	DUP curr-val !
	0 size !
	BEGIN
		OVER EXECUTE verify
		inc-piece
		1- DUP 0=
	UNTIL DROP
	not-empty? IF
		0 curr-piece !
	ENDIF
	DUP EXECUTE verify
	here from <> curr-val @ 1 > AND IF
		here capture-pos !
	ENDIF
	from to EXECUTE verify
	from here move
	size @ 0> verify
	0 BEGIN
		DUP val[] @ 
		OVER size @ 1- = curr-piece @ 0= AND IF
			OVER pos[] @ to
			here from <> IF
				20 +
			ENDIF
		ENDIF
		OVER pos[] @ create-piece-type-at
		DUP size @ 1- = curr-piece @ 0= AND IF
			here OVER pos[] @ to 
			here from <> IF
				up verify
				current-player MARK create-player-piece-type
			ENDIF to
		ENDIF
		1+ DUP size @ >=
	UNTIL DROP
	curr-piece @ 1 > IF
		capture-pos @ capture-at
	ENDIF
	from to up verify
	not-empty? IF
		piece-type MARK = IF
			capture
		ENDIF
	ENDIF
	add-move
;

: move-n  ( -- ) ['] n  move-piece ;
: move-s  ( -- ) ['] s  move-piece ;
: move-e  ( -- ) ['] e  move-piece ;
: move-w  ( -- ) ['] w  move-piece ;
: move-nw ( -- ) ['] nw move-piece ;
: move-sw ( -- ) ['] sw move-piece ;
: move-ne ( -- ) ['] ne move-piece ;
: move-se ( -- ) ['] se move-piece ;

{move-priorities
	{move-priority} normal
	{move-priority} low
move-priorities}

{moves drop-pieces
	{move} drop-bean {move-type} setup
moves}

{moves move-pieces
	{move} move-n    {move-type} normal
	{move} move-s    {move-type} normal
	{move} move-e    {move-type} normal
	{move} move-w    {move-type} normal
	{move} move-nw   {move-type} normal
	{move} move-sw   {move-type} normal
	{move} move-ne   {move-type} normal
	{move} move-se   {move-type} normal
	{move} Pass      {move-type} low
moves}

{pieces
	{piece} p1  {moves} move-pieces 1  {value}
	{piece} p2  {drops} drop-pieces {moves} move-pieces 2  {value}
	{piece} p3  {drops} drop-pieces {moves} move-pieces 3  {value}
	{piece} p4  {drops} drop-pieces {moves} move-pieces 4  {value}
	{piece} p5  {drops} drop-pieces {moves} move-pieces 5  {value}
	{piece} p6  {drops} drop-pieces {moves} move-pieces 6  {value}
	{piece} p7  {moves} move-pieces 7  {value}
	{piece} p8  {moves} move-pieces 8  {value}
	{piece} p9  {moves} move-pieces 9  {value}
	{piece} p10 {moves} move-pieces 10 {value}
	{piece} p11 {moves} move-pieces 11 {value}
	{piece} p12 {moves} move-pieces 12 {value}
	{piece} p13 {moves} move-pieces 13 {value}
	{piece} p14 {moves} move-pieces 14 {value}
	{piece} p15 {moves} move-pieces 15 {value}
	{piece} p16 {moves} move-pieces 16 {value}
	{piece} p17 {moves} move-pieces 17 {value}
	{piece} p18 {moves} move-pieces 18 {value}
	{piece} p19 {moves} move-pieces 19 {value}
	{piece} p20 {moves} move-pieces 20 {value}

	{piece} q1  {moves} move-pieces 1  {value}
	{piece} q2  {moves} move-pieces 2  {value}
	{piece} q3  {moves} move-pieces 3  {value}
	{piece} q4  {moves} move-pieces 4  {value}
	{piece} q5  {moves} move-pieces 5  {value}
	{piece} q6  {moves} move-pieces 6  {value}
	{piece} q7  {moves} move-pieces 7  {value}
	{piece} q8  {moves} move-pieces 8  {value}
	{piece} q9  {moves} move-pieces 9  {value}
	{piece} q10 {moves} move-pieces 10 {value}
	{piece} q11 {moves} move-pieces 11 {value}
	{piece} q12 {moves} move-pieces 12 {value}
	{piece} q13 {moves} move-pieces 13 {value}
	{piece} q14 {moves} move-pieces 14 {value}
	{piece} q15 {moves} move-pieces 15 {value}
	{piece} q16 {moves} move-pieces 16 {value}
	{piece} q17 {moves} move-pieces 17 {value}
	{piece} q18 {moves} move-pieces 18 {value}
	{piece} q19 {moves} move-pieces 19 {value}
	{piece} q20 {moves} move-pieces 20 {value}

	{piece} M
pieces}

' M	IS MARK
