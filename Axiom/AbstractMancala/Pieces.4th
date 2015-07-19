$gameLog	OFF

DEFER	MARK
DEFER	TRAP

DEFER	p++
DEFER	t++

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

: find-pos ( -- n )
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
;

: inc-piece ( -- )
	find-pos
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

: is-trap? ( -- ? )
	find-pos
	DUP size @ < verify
	DUP size @ 1- = IF
		val[] @ 4 =
	ELSE
		DROP FALSE
	ENDIF
;

: to-trap ( n -- )
	piece piece-value +
	DUP 20 < verify
	find-pos
	DUP size @ >= verify
	DUP SIZE < verify
	here OVER pos[] !
	val[] !
	size ++
;

: check-trap ( -- ? )
	STRONG-TRAP? IF
		here up verify
		not-empty? IF
			piece-type TRAP = IF
				TRUE use-trap !
			ENDIF
		ENDIF
		to
		use-trap @
	ELSE
		FALSE
	ENDIF
;

: not-enemy-trap? ( -- ? )
	here up verify
	TRUE
	not-empty? IF
		piece-type TRAP = IF
			player current-player <> IF
				DROP FALSE
			ENDIF
		ENDIF
	ENDIF
	SWAP to
;

: is-weak-trap? ( pos -- ? )
	to up verify
	piece-type TRAP =
;

: move-piece ( 'dir -- )
	check-last
	not-enemy-trap? verify
	piece piece-value
	FALSE is-marked? !
	FALSE set-trap !
	FALSE use-trap !
	DUP curr-piece !
	DUP curr-val !
	0 size !
	BEGIN
		OVER EXECUTE verify
		check-trap IF
			DUP to-trap
			TRUE
		ELSE
			inc-piece
			DUP 1 = IF
				is-trap? IF
					TRUE set-trap !
				ENDIF
			ENDIF
			1- DUP 0=
		ENDIF
	UNTIL DROP
	not-empty? IF
		0 curr-piece !
	ENDIF
	DUP EXECUTE verify
	here from <> curr-val @ 1 > AND IF
		not-enemy-trap? IF
			here capture-pos !
		ENDIF
	ENDIF
	from to EXECUTE verify
	from here move
	size @ 0> verify
	0 BEGIN
		DUP val[] @ 
		DUP 20 < verify		
		set-trap @ use-trap @ OR IF
			OVER size @ 1- = IF
				40 +
			ENDIF
		ELSE
			OVER pos[] @ is-weak-trap? IF
				40 +
			ELSE
				OVER size @ 1- = curr-piece @ 0= AND IF
					OVER pos[] @ to
					here from <> IF
						20 +
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		OVER pos[] @ create-piece-type-at
		use-trap @ NOT IF
			set-trap @ IF
				DUP size @ 1- = IF
					here OVER pos[] @ to 
					up verify
					current-player TRAP create-player-piece-type
					to
				ENDIF
			ELSE
				DUP size @ 1- = curr-piece @ 0= AND IF
					here OVER pos[] @ to 
					here from <> IF
						up verify
						empty? IF
							current-player MARK create-player-piece-type
							TRUE is-marked? !
						ENDIF
					ENDIF to
				ENDIF
			ENDIF
		ENDIF
		1+ DUP size @ >=
	UNTIL DROP
	curr-piece @ 1 > IF
		capture-pos @ piece-at piece-value
		BEGIN
			DUP 0> IF
				1-
				COMPILE p++
				FALSE
			ELSE
				TRUE
			ENDIF
		UNTIL DROP
		capture-pos @ capture-at
	ENDIF
	from to up verify
	not-empty? IF
		capture
	ENDIF
	is-marked? @ NOT IF
		COMPILE t++
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

	{piece} t1  {moves} move-pieces 1  {value}
	{piece} t2  {moves} move-pieces 2  {value}
	{piece} t3  {moves} move-pieces 3  {value}
	{piece} t4  {moves} move-pieces 4  {value}
	{piece} t5  {moves} move-pieces 5  {value}
	{piece} t6  {moves} move-pieces 6  {value}
	{piece} t7  {moves} move-pieces 7  {value}
	{piece} t8  {moves} move-pieces 8  {value}
	{piece} t9  {moves} move-pieces 9  {value}
	{piece} t10 {moves} move-pieces 10 {value}
	{piece} t11 {moves} move-pieces 11 {value}
	{piece} t12 {moves} move-pieces 12 {value}
	{piece} t13 {moves} move-pieces 13 {value}
	{piece} t14 {moves} move-pieces 14 {value}
	{piece} t15 {moves} move-pieces 15 {value}
	{piece} t16 {moves} move-pieces 16 {value}
	{piece} t17 {moves} move-pieces 17 {value}
	{piece} t18 {moves} move-pieces 18 {value}
	{piece} t19 {moves} move-pieces 19 {value}
	{piece} t20 {moves} move-pieces 20 {value}

	{piece} M
	{piece} T
pieces}

' M	IS MARK
' T	IS TRAP
