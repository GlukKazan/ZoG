: drop-bean ( -- )
	here PLANE < verify
	empty? IF
		0
	ELSE
		piece piece-value
	ENDIF
	DUP 5 < verify
	current-piece-type +
	drop
	create-piece-type
	add-move
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
	0 size !
	piece piece-value
	BEGIN
		OVER EXECUTE verify
		inc-piece
		1- DUP 0=
	UNTIL DROP
	from to EXECUTE verify
	from here move
	size @ 0> verify
	0 BEGIN
		DUP val[] @ OVER pos[] @ create-piece-type-at
		1+ DUP size @ >=
	UNTIL DROP
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

{moves drop-pieces
	{move} drop-bean {move-type} setup
moves}

{moves move-pieces
	{move} move-n  {move-type} normal
	{move} move-s  {move-type} normal
	{move} move-e  {move-type} normal
	{move} move-w  {move-type} normal
	{move} move-nw {move-type} normal
	{move} move-sw {move-type} normal
	{move} move-ne {move-type} normal
	{move} move-se {move-type} normal
	{move} Pass    {move-type} normal
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
pieces}
