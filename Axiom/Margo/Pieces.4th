DEFER	nw-piece
DEFER	ne-piece
DEFER	se-piece
DEFER	sw-piece

: get-x ( pos -- x )
	COLS MOD
;

: get-y ( pos -- y )
	COLS /
;

: is-plane? ( pos -- ? )
	get-y COLS <
;

: get-odd ( x -- n )
	2 MOD
;

: is-edge? ( 'op -- ? )
	COLS here get-y
	BEGIN
		2DUP <= IF
			OVER -
			SWAP 2 - SWAP
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
	SWAP 1- OVER = SWAP 0= ROT EXECUTE
;

: common-dir ( 'dir 'op -- ? )
	is-edge? IF
		DROP FALSE
	ELSE
		EXECUTE
	ENDIF
;

: my-first ( a b -- b )
	SWAP DROP
;

: n ( -- ) ['] n-internal ['] my-first common-dir ;
: s ( -- ) ['] s-internal ['] DROP     common-dir ;
: d ( -- ) ['] d-internal ['] OR       common-dir ;

: create-neighbor ( piece-type 'dir -- )
	here
	SWAP EXECUTE IF
		empty? verify
		SWAP create-piece-type

	ELSE
		SWAP DROP
	ENDIF
	to
;

: create-neighbors ( piece-type 'dir piece-type 'dir piece-type 'dir -- )
	create-neighbor
	create-neighbor
	create-neighbor
;

: create-nw-neighbors ( -- ) sw-piece ['] w ne-piece ['] n nw-piece ['] nw create-neighbors ;
: create-sw-neighbors ( -- ) nw-piece ['] w se-piece ['] s sw-piece ['] sw create-neighbors ;
: create-ne-neighbors ( -- ) se-piece ['] e nw-piece ['] n ne-piece ['] ne create-neighbors ;
: create-se-neighbors ( -- ) ne-piece ['] e sw-piece ['] s se-piece ['] se create-neighbors ;

: drop-piece ( x y -- )
	2DUP
	here is-plane? verify
	here get-y get-odd = verify
	here get-x get-odd = verify
	empty? verify
	drop
	SWAP 2 * +
	DUP 0 = IF create-se-neighbors ENDIF
	DUP 1 = IF create-ne-neighbors ENDIF
	DUP 2 = IF create-sw-neighbors ENDIF
	DUP 3 = IF create-nw-neighbors ENDIF
	DROP
	add-move
;

: drop-w ( -- ) 0 0 drop-piece ;
: drop-n ( -- ) 1 0 drop-piece ;
: drop-e ( -- ) 1 1 drop-piece ;
: drop-s ( -- ) 0 1 drop-piece ;

{moves w-drop
	{move} drop-w
moves}

{moves n-drop
	{move} drop-n
moves}

{moves e-drop
	{move} drop-e
moves}

{moves s-drop
	{move} drop-s
moves}

{pieces
	{piece}		M
	{piece}		tw	{drops} w-drop
	{piece}		zw
	{piece}		ww
	{piece}		bw
	{piece}		tn	{drops} n-drop
	{piece}		zn
	{piece}		wn
	{piece}		bn
	{piece}		te	{drops} e-drop
	{piece}		ze
	{piece}		we
	{piece}		be
	{piece}		ts	{drops} s-drop
	{piece}		zs
	{piece}		ws
	{piece}		bs
pieces}

' tw	IS nw-piece
' tn	IS ne-piece
' te	IS se-piece
' ts	IS sw-piece
