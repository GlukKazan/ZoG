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

: common-direction ( 'dir 'op -- ? )
	is-edge? IF
		DROP FALSE
	ELSE
		EXECUTE
	ENDIF
;

: my-first ( a b -- b )
	SWAP DROP
;

: n  ( -- ) ['] n-internal  ['] my-first common-direction ;
: nw ( -- ) ['] nw-internal ['] my-first common-direction ;
: ne ( -- ) ['] ne-internal ['] my-first common-direction ;
: s  ( -- ) ['] s-internal  ['] DROP     common-direction ;
: sw ( -- ) ['] sw-internal ['] DROP     common-direction ;
: se ( -- ) ['] se-internal ['] DROP     common-direction ;

: decorate-piece ( piece-type -- piece-type )
	player W = IF
		2 +
	ENDIF
	player B = IF
		3 +
	ENDIF
;

: equal-types? ( piece-type base-type -- ? )
	2DUP >= ROT ROT
	4 + < AND
;

: hide-piece ( piece-type -- piece-type )
	DUP nw-piece equal-types? IF
		DROP nw-piece 1+
	ENDIF
	DUP ne-piece equal-types? IF
		DROP ne-piece 1+
	ENDIF
	DUP se-piece equal-types? IF
		DROP se-piece 1+
	ENDIF
	DUP sw-piece equal-types? IF
		DROP sw-piece 1+
	ENDIF
;

: create-plane-neighbor ( piece-type 'dir -- )
	here
	SWAP EXECUTE IF
		empty? verify
		SWAP create-piece-type
	ELSE
		SWAP DROP
	ENDIF
	to
;

: create-plane-neighbors ( piece-type 'dir piece-type 'dir piece-type 'dir -- )
	create-plane-neighbor
	create-plane-neighbor
	create-plane-neighbor
;

: plane-nw-neighbors ( -- ) sw-piece ['] w ne-piece ['] n nw-piece ['] nw create-plane-neighbors ;
: plane-sw-neighbors ( -- ) nw-piece ['] w se-piece ['] s sw-piece ['] sw create-plane-neighbors ;
: plane-ne-neighbors ( -- ) se-piece ['] e nw-piece ['] n ne-piece ['] ne create-plane-neighbors ;
: plane-se-neighbors ( -- ) ne-piece ['] e sw-piece ['] s se-piece ['] se create-plane-neighbors ;

: add-to-plane ( x y -- )
	2DUP
	here is-plane? verify
	here get-y get-odd = verify
	here get-x get-odd = verify
	empty? verify
	drop
	SWAP 2 * +
	DUP 0 = IF plane-se-neighbors ENDIF
	DUP 1 = IF plane-ne-neighbors ENDIF
	DUP 2 = IF plane-sw-neighbors ENDIF
	DUP 3 = IF plane-nw-neighbors ENDIF
	DROP
	add-move
;

: drop-w ( -- ) 0 0 add-to-plane ;
: drop-n ( -- ) 1 0 add-to-plane ;
: drop-e ( -- ) 1 1 add-to-plane ;
: drop-s ( -- ) 0 1 add-to-plane ;

: push-piece ( player piece-type -- )
	here ROT ROT hide-piece
	BEGIN
		d verify
		empty?
	UNTIL
	create-player-piece-type
	to 
;

: create-heap-neighbor ( piece-type base-type 'dir -- )
	here
	SWAP EXECUTE IF
		not-empty? verify
		SWAP piece-type SWAP equal-types? verify
		SWAP 
		decorate-piece
		player piece-type
		push-piece
		create-piece-type
	ELSE
		SWAP DROP SWAP DROP
	ENDIF
	to
;

: create-heap-neighbors ( piece-type base-type 'dir piece-type base-type 'dir piece-type base-type 'dir -- )
	create-heap-neighbor
	create-heap-neighbor
	create-heap-neighbor
;

: heap-nw-neighbors ( -- ) sw-piece ne-piece ['] w ne-piece sw-piece ['] n nw-piece se-piece ['] nw create-heap-neighbors ;
: heap-sw-neighbors ( -- ) nw-piece se-piece ['] w se-piece nw-piece ['] s sw-piece ne-piece ['] sw create-heap-neighbors ;
: heap-ne-neighbors ( -- ) se-piece nw-piece ['] e nw-piece se-piece ['] n ne-piece sw-piece ['] ne create-heap-neighbors ;
: heap-se-neighbors ( -- ) ne-piece sw-piece ['] e sw-piece ne-piece ['] s se-piece nw-piece ['] se create-heap-neighbors ;

: add-to-heap ( piece-type opposite-type -- )
	here is-plane? verify
	not-empty? verify
	DUP piece-type SWAP equal-types? verify
	SWAP decorate-piece SWAP
	player piece-type ROT
	drop
	DUP nw-piece = IF heap-nw-neighbors ENDIF
	DUP ne-piece = IF heap-ne-neighbors ENDIF
	DUP se-piece = IF heap-se-neighbors ENDIF
	DUP sw-piece = IF heap-sw-neighbors ENDIF
	DROP
	push-piece
	create-piece-type
	add-move
;

: drop-nw ( -- ) nw-piece se-piece add-to-heap ;
: drop-ne ( -- ) ne-piece sw-piece add-to-heap ;
: drop-se ( -- ) se-piece nw-piece add-to-heap ;
: drop-sw ( -- ) sw-piece ne-piece add-to-heap ;

: wrap-direction ( 'dir -- ? )
	here SWAP EXECUTE IF
		DROP TRUE
	ELSE
		to FALSE
	ENDIF
;

: up-internal ( -- ? ) 
	here is-plane? IF
		FALSE
	ELSE
		d NOT empty? OR IF
			BEGIN u NOT UNTIL
		ENDIF
		TRUE
	ENDIF
;

: up ( -- ? ) ['] up-internal wrap-direction ;

: down-internal ( -- ? ) 
	here is-plane? IF
		d NOT empty? OR IF
			FALSE
		ELSE
			BEGIN d NOT empty? OR UNTIL
			empty? IF
				u verify
			ENDIF
			TRUE
		ENDIF
	ELSE
		u verify
		here is-plane? NOT
	ENDIF
;

: down ( -- ? ) ['] down-internal wrap-direction ;

: common-internal ( 'dir -- ? )
	here is-plane? IF
		BEGIN d NOT empty? OR UNTIL
		empty? IF
			EXECUTE IF
				empty? IF
					BEGIN u NOT UNTIL
				ENDIF
				TRUE
			ELSE
				FALSE
			ENDIF
		ELSE
			EXECUTE empty? NOT AND IF
				BEGIN u NOT UNTIL
				TRUE
			ELSE
				FALSE
			ENDIF
		ENDIF
	ELSE
		EXECUTE 
		DUP empty? AND IF
			BEGIN u NOT UNTIL
		ENDIF
	ENDIF
	empty? NOT AND
;

: north-internal ( -- ? ) ['] n common-internal ;
: south-internal ( -- ? ) ['] s common-internal ;
: west-internal  ( -- ? ) ['] w common-internal ;
: east-internal  ( -- ? ) ['] e common-internal ;

: north ( -- ? ) ['] north-internal wrap-direction ;
: south ( -- ? ) ['] south-internal wrap-direction ;
: west  ( -- ? ) ['] west-internal  wrap-direction ;
: east  ( -- ? ) ['] east-internal  wrap-direction ;

: not-alive? ( -- ? )
	TRUE
	0 BEGIN
		DUP alive-count @ < IF
			DUP alive[] @ here = IF
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

: add-alive ( -- )
	not-alive? alive-count @ TOTAL < AND IF
		here alive-count @ alive[] !
		alive-count ++
	ENDIF
;

: check-alive ( 'op 'dir -- )
	EXECUTE IF
		EXECUTE IF
			add-alive
		ENDIF
	ELSE
		DROP
	ENDIF
;

: init-alive ( 'op -- 'op )
	0 alive-count !
	0 BEGIN
		DUP empty-at? IF
			DUP to OVER ['] n check-alive
			DUP to OVER ['] s check-alive
			DUP to OVER ['] w check-alive
			DUP to OVER ['] e check-alive 
		ENDIF
		1+ DUP PLANE >=
	UNTIL DROP
;

: proceed-alive ( 'op -- 'op )
	0 BEGIN
		DUP alive-count @ < IF
			DUP alive[] @ to OVER ['] north check-alive
			DUP alive[] @ to OVER ['] south check-alive
			DUP alive[] @ to OVER ['] west  check-alive
			DUP alive[] @ to OVER ['] east  check-alive
			DUP alive[] @ to OVER ['] up    check-alive
			DUP alive[] @ to OVER ['] down  check-alive
			1+ FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: not-zombies? ( -- ? )
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

: add-zombies ( -- )
	not-zombies? zombies-count @ TOTAL < AND IF
		here zombies-count @ zombies[] !
		zombies-count ++
	ENDIF
;

: check-zombies ( 'op -- 'op )
	0 zombies-count !
	0 BEGIN
		DUP to
		empty? NOT IF
			BEGIN
				OVER EXECUTE NOT not-alive? NOT OR IF
					TRUE
				ELSE
					down NOT
				ENDIF
			UNTIL
			BEGIN
				OVER EXECUTE not-alive? AND IF
					add-zombies
					here
					piece-type nw-piece equal-types? IF
						south IF
							add-zombies 
							DUP to
						ENDIF
						east IF
							add-zombies 
							DUP to
						ENDIF
					ENDIF
					piece-type ne-piece equal-types? IF
						south IF
							add-zombies 
							DUP to
						ENDIF
						west IF
							add-zombies 
							DUP to
						ENDIF
					ENDIF
					piece-type sw-piece equal-types? IF
						north IF
							add-zombies 
							DUP to
						ENDIF
						east IF
							add-zombies 
							DUP to
						ENDIF
					ENDIF
					piece-type se-piece equal-types? IF
						north IF
							add-zombies 
							DUP to
						ENDIF
						west IF
							add-zombies 
							DUP to
						ENDIF
					ENDIF
					DROP
				ENDIF
				down NOT
			UNTIL
		ENDIF
		1+ DUP PLANE >=
	UNTIL DROP
;

: capture-column ( 'op -- ? )
	TRUE BEGIN
		OVER EXECUTE not-alive? AND not-zombies? AND IF
			capture
			captured-tiles ++
			down NOT IF
				DROP FALSE
				TRUE
			ELSE
				FALSE
			ENDIF
		ELSE
			TRUE
		ENDIF
	UNTIL SWAP DROP
;

: capture-all ( 'op -- )
	0 captured-tiles !
	0 BEGIN
		DUP to
		empty? NOT IF
			OVER EXECUTE not-alive? AND IF
				captured-tiles ++
				down IF
					OVER capture-column IF
						DUP player piece-type 1-
						capture
						down IF decorate-piece ENDIF
						ROT create-player-piece-type-at
					ELSE
						DUP capture-at
					ENDIF
				ELSE
					DUP capture-at
				ENDIF
			ENDIF
		ENDIF
		1+ DUP PLANE >=
	UNTIL 2DROP
;

: my-enemy? ( -- ? )
	not-empty? IF
		for-player player = 
		current-player player =  OR 
		NOT
	ELSE
		FALSE
	ENDIF
;

: my-friend? ( -- ? )
	not-empty? IF
		for-player player =
		current-player player = OR
	ELSE
		FALSE
	ENDIF
;

: WC+ ( n -- )
	WC +!
;

: BC+ ( n -- )
	BC +!
;

: update-variables ( n -- )
	for-player W = IF NEGATE ENDIF 4 /
	DUP 0< IF
		NEGATE
		COMPILE-LITERAL COMPILE WC+
	ENDIF
	DUP 0> IF
		COMPILE-LITERAL COMPILE BC+
	ENDIF
;

: drop-m ( -- )
	here a1 = verify
	drop
	['] my-enemy?
	init-alive
        proceed-alive
	check-zombies
        capture-all
	captured-tiles @ 0= IF
		['] my-friend?
		init-alive
	        proceed-alive
		check-zombies
		capture-all
		captured-tiles @ NEGATE
		update-variables
	ELSE
		captured-tiles @
		update-variables
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
