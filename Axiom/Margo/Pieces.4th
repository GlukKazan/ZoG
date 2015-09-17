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
		d verify 
		empty? IF
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
		empty? EXECUTE IF
			empty? AND IF
				BEGIN u NOT UNTIL
			ENDIF
			TRUE
		ELSE
			DROP FALSE
		ENDIF
	ELSE
		EXECUTE 
		DUP empty? AND IF
			BEGIN u NOT UNTIL
		ENDIF
	ENDIF
	empty? NOT AND
;

: n-internal ( -- ? ) ['] n common-internal ;
: s-internal ( -- ? ) ['] s common-internal ;
: w-internal ( -- ? ) ['] w common-internal ;
: e-internal ( -- ? ) ['] e common-internal ;

: north ( -- ? ) ['] n-internal wrap-direction ;
: south ( -- ? ) ['] s-internal wrap-direction ;
: west  ( -- ? ) ['] w-internal wrap-direction ;
: east  ( -- ? ) ['] e-internal wrap-direction ;

: position-not-present? ( -- ? )
	TRUE
	0 BEGIN
		DUP piece-group-count @ < IF
			DUP piece-group[] @ here = IF
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
	position-not-present? piece-group-count @ TOTAL < AND IF
		here piece-group-count @ piece-group[] !
		piece-group-count ++
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
	0 piece-group-count !
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
		DUP piece-group-count @ < IF
			DUP piece-group[] @ to OVER ['] north check-piece
			DUP piece-group[] @ to OVER ['] south check-piece
			DUP piece-group[] @ to OVER ['] west  check-piece
			DUP piece-group[] @ to OVER ['] east  check-piece
			DUP piece-group[] @ to OVER ['] up    check-piece
			DUP piece-group[] @ to OVER ['] down  check-piece
			1+ FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL 2DROP
;

{moves w-drop
	{move} drop-w
	{move} drop-nw
moves}

{moves n-drop
	{move} drop-n
	{move} drop-ne
moves}

{moves e-drop
	{move} drop-e
	{move} drop-se
moves}

{moves s-drop
	{move} drop-s
	{move} drop-sw
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
