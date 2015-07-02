$gameLog	OFF

DEFER		nw-piece
DEFER		ne-piece
DEFER		se-piece
DEFER		sw-piece

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

: change-piece ( piece-type -- piece-type )
	player W = IF
		2 +
	ENDIF
	player B = IF
		3 +
	ENDIF
;

: equal-type? ( piece-type -- ? )
	DUP piece-type <= 
	SWAP 4 + piece-type > AND
;

: equal-types? ( piece-type base-type -- ? )
	2DUP >= ROT ROT
	4 + < AND
;

: zero-type ( piece-type -- piece-type )
	DUP nw-piece equal-types? IF
		DROP nw-piece 1+
	ELSE
		DUP ne-piece equal-types? IF
			DROP ne-piece 1+
		ELSE
			DUP se-piece equal-types? IF
				DROP se-piece 1+
			ELSE
				DUP sw-piece equal-types? IF
					DROP sw-piece 1+
				ENDIF
			ENDIF
		ENDIF
	ENDIF
;

: add-piece-type ( player piece-type -- )
	here ROT ROT zero-type
	BEGIN
		d verify
		empty?
	UNTIL
	create-player-piece-type
	to 
;

: add-neighbor ( piece-type pattern-type 'dir -- )
	here
	SWAP EXECUTE IF
		not-empty? verify
		SWAP equal-type? verify
		SWAP 
		change-piece
		player piece-type
		add-piece-type
		create-piece-type
	ELSE
		SWAP DROP SWAP DROP
	ENDIF
	to
;

: create-neighbors ( piece-type 'dir piece-type 'dir piece-type 'dir -- )
	create-neighbor
	create-neighbor
	create-neighbor
;

: add-neighbors ( piece-type pattern-type 'dir piece-type pattern-type 'dir piece-type pattern-type 'dir -- )
	add-neighbor
	add-neighbor
	add-neighbor
;

: create-nw-neighbors ( -- ) sw-piece ['] w ne-piece ['] n nw-piece ['] nw create-neighbors ;
: create-sw-neighbors ( -- ) nw-piece ['] w se-piece ['] s sw-piece ['] sw create-neighbors ;
: create-ne-neighbors ( -- ) se-piece ['] e nw-piece ['] n ne-piece ['] ne create-neighbors ;
: create-se-neighbors ( -- ) ne-piece ['] e sw-piece ['] s se-piece ['] se create-neighbors ;

: add-nw-neighbors ( -- ) sw-piece ne-piece ['] w ne-piece sw-piece ['] n nw-piece se-piece ['] nw add-neighbors ;
: add-sw-neighbors ( -- ) nw-piece se-piece ['] w se-piece nw-piece ['] s sw-piece ne-piece ['] sw add-neighbors ;
: add-ne-neighbors ( -- ) se-piece nw-piece ['] e nw-piece se-piece ['] n ne-piece sw-piece ['] ne add-neighbors ;
: add-se-neighbors ( -- ) ne-piece sw-piece ['] e sw-piece ne-piece ['] s se-piece nw-piece ['] se add-neighbors ;

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

: add-piece ( piece-type opposite-type -- )
	here is-plane? verify
	not-empty? verify
	DUP equal-type? verify
	SWAP change-piece SWAP
	player piece-type ROT
	drop
	DUP nw-piece = IF add-nw-neighbors ENDIF
	DUP ne-piece = IF add-ne-neighbors ENDIF
	DUP se-piece = IF add-se-neighbors ENDIF
	DUP sw-piece = IF add-sw-neighbors ENDIF
	DROP
	add-piece-type
	create-piece-type
	add-move
;

: drop-w ( -- ) 0 0 drop-piece ;
: drop-n ( -- ) 1 0 drop-piece ;
: drop-e ( -- ) 1 1 drop-piece ;
: drop-s ( -- ) 0 1 drop-piece ;

: drop-nw ( -- ) nw-piece se-piece add-piece ;
: drop-ne ( -- ) ne-piece sw-piece add-piece ;
: drop-se ( -- ) se-piece nw-piece add-piece ;
: drop-sw ( -- ) sw-piece ne-piece add-piece ;

: position-not-present? ( -- ? )
	TRUE
	0 BEGIN
		DUP pieces-count @ < IF
			DUP pieces[] @ here = IF
				SWAP DROP FALSE SWAP
				TRUE
			ELSE
				1+
				FALSE
			ENDIF

		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: add-position ( -- )
	position-not-present? pieces-count @ TOTAL < AND IF
		here pieces-count @ pieces[] !
		pieces-count ++
	ENDIF
;

: check-piece ( 'op 'dir -- )
	EXECUTE IF
		EXECUTE IF
			add-position
		ENDIF
	ELSE
		DROP
	ENDIF
;

: init-group ( 'op -- )
	0 pieces-count !
	0 BEGIN
		DUP empty-at? IF
			DUP to OVER ['] n check-piece
			DUP to OVER ['] s check-piece
			DUP to OVER ['] w check-piece
			DUP to OVER ['] e check-piece 
		ENDIF
		1+ DUP PLANE >=
	UNTIL 2DROP
;

: proceed-group ( 'op -- )
	0 BEGIN
		DUP pieces-count @ < IF
			DUP pieces[] @ to OVER ['] n check-piece
			DUP pieces[] @ to OVER ['] s check-piece
			DUP pieces[] @ to OVER ['] w check-piece
			DUP pieces[] @ to OVER ['] e check-piece
			1+ FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL 2DROP
;

: is-not-zomby? ( -- ? )
	TRUE
	0 BEGIN
		DUP zombies-count @ < IF
			DUP zombies[] @ here = IF
				SWAP DROP FALSE SWAP
				TRUE
			ELSE
				1+
				FALSE
			ENDIF
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: add-zomby ( -- )
	is-not-zomby? zombies-count @ TOTAL < AND IF
		here zombies-count @ zombies[] !
		zombies-count ++
	ENDIF
;

: influence-dir ( 'dir -- )
	here
	SWAP EXECUTE verify
	empty? IF
		BEGIN u NOT UNTIL
	ENDIF
	add-zomby
	to
;

: influence ( -- )
	nw-piece equal-type? IF
		['] s  influence-dir
		['] e  influence-dir
		['] se influence-dir
	ENDIF
	ne-piece equal-type? IF
		['] s  influence-dir
		['] w  influence-dir
		['] sw influence-dir
	ENDIF
	se-piece equal-type? IF
		['] n  influence-dir
		['] w  influence-dir
		['] nw influence-dir
	ENDIF
	sw-piece equal-type? IF
		['] n  influence-dir
		['] e  influence-dir
		['] ne influence-dir
	ENDIF
;

: is-over? ( 'op -- ? )
	not-empty? IF
		EXECUTE IF
			is-not-zomby? NOT
		ELSE
			TRUE
		ENDIF
	ELSE
		DROP FALSE
	ENDIF
;

: is-not-over? ( 'op -- ? )
	here PLANE < IF
		DROP TRUE
	ELSE
		is-not-zomby? NOT IF
			DROP FALSE
		ELSE
			TRUE here
			d NOT empty? OR IF
				BEGIN u NOT UNTIL
			ENDIF
			ROT is-over? IF
				SWAP FALSE SWAP
			ENDIF
			to
			DUP NOT IF
				add-zomby
				influence
			ENDIF
		ENDIF
	ENDIF
;

: clear-unmarked ( 'op -- ? )
	TRUE result !
	0 zombies-count !
        ALL BEGIN
		1-
		DUP to OVER EXECUTE IF
			position-not-present? IF
				OVER is-not-over? IF
					capture
					FALSE result !
				ENDIF
			ENDIF
		ENDIF
		DUP 0 <=
	UNTIL 2DROP
	result @
;

: clear-pieces ( 'op -- ? )
	DUP init-group    
	DUP proceed-group
	clear-unmarked     
;

: my-enemy? ( -- ? )
	here a1 <> not-empty? AND IF
		for-player player = NOT
	ELSE
		FALSE
	ENDIF
;

: my-friend? ( -- ? )
	here a1 <> not-empty? AND IF
		for-player player =
	ELSE
		FALSE
	ENDIF
;

: drop-m ( -- )
	here a1 = verify
	drop
	['] my-enemy? clear-pieces IF
		['] my-friend? clear-pieces DROP
	ENDIF
	add-move
;

{moves w-drop
	{move} drop-w	{move-type} normal
	{move} drop-nw	{move-type} normal
moves}

{moves n-drop
	{move} drop-n	{move-type} normal
	{move} drop-ne	{move-type} normal
moves}

{moves e-drop
	{move} drop-e	{move-type} normal
	{move} drop-se	{move-type} normal
moves}

{moves s-drop
	{move} drop-s	{move-type} normal
	{move} drop-sw	{move-type} normal
moves}

{moves m-drop
	{move} drop-m	{move-type} clean
moves}

{pieces
	{piece}		M	{drops} m-drop
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
