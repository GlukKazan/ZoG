( ! . <= x ) ( ! x == y ) ( ! x == z )
( ! . <= ' ) ( ! . <= ` ) ( ! . <= * ) ( ! ` == '% )
( ! . <= ? ) ( ! ? == %? )
( ! x <= n ) ( ! x <= m )
( ! n <= p ) ( ! p == pos )
( ! n <= t ) ( ! t == piece-type )
( ! n <= a ) ( ! a == player )

: CONSTANT			( x << y ) ;
: VARIABLE			( << ' ) ;
: DEFER				( << ' ) ;
: '				( << ' ) ;
: IS				( ' << ' ) ;
: []				( x << * ) ;
: [']				( << ` ) ;
: EXECUTE			( ` -- ) ;
: IF				( ? -- ) ;
: UNTIL				( ? -- ) ;

: @				( ' -- x ) ;
: !				( x ' -- ) ;

: DUP				( x -- x x ) ;
: 2DUP				( x y -- x y x y ) ;
: SWAP				( x y -- y x ) ;
: DROP				( x -- ) ;
: 2DROP				( x y -- ) ;
: OVER				( x y -- x y x ) ;
: ROT				( x y z -- y z x ) ;

: +				( n n -- n ) ;
: -				( n n -- n ) ;
: *				( n n -- n ) ;
: /				( n n -- n ) ;
: MOD				( n n -- n ) ;
: MIN				( n n -- n ) ;
: MAX				( n n -- n ) ;
: RAND-WITHIN			( n n -- n ) ;
: RAND-WITHIN2			( n n -- n ) ;

: 1+				( n -- n ) ;
: 1-				( n -- n ) ;
: ABS				( n -- n ) ;
: NEGATE			( n -- n ) ;
: ++				( ' -- ) ;
: --				( ' -- ) ;

: =				( n n -- ? ) ;
: <				( n n -- ? ) ;
: >				( n n -- ? ) ;
: <=				( n n -- ? ) ;
: >=				( n n -- ? ) ;

: 0=				( n -- ? ) ;
: 0<				( n -- ? ) ;
: 0>				( n -- ? ) ;
: 0<>				( n -- ? ) ;

: TRUE				( -- ? ) ;
: FALSE				( -- ? ) ;
: AND				( ? ? -- ? ) ;
: OR				( ? ? -- ? ) ;
: XOR				( ? ? -- ? ) ;
: NOT				( ? -- ? ) ;

: empty?			( -- ? ) ;
: empty-at?			( p -- ? ) ;
: not-empty?			( -- ? ) ;
: not-empty-at?			( p -- ? ) ;
: not-piece-type		( t -- ? ) ;
: not-piece-type-at		( p t -- ? ) ;
: friend?			( -- ? ) ;
: friend-at?			( -- ? ) ;
: friend-of?			( a -- ? ) ;
: enemy?			( -- ? ) ;
: enemy-at?			( -- ? ) ;
: enemy-of?			( a -- ? ) ;
: neutral-piece?		( -- ? ) ;
: neutral-piece-at?		( p -- ? ) ;

: current-player		( -- a ) ;
: for-player			( -- a ) ;
: of-type			( -- m ) ;
: player			( -- a ) ;
: player-at			( p -- a ) ;

: move				( p p -- ) ;
: drop				( -- ) ;
: drop-piece			( t -- ) ;
: drop-piece-at			( t p -- ) ;
: capture			( -- ) ;
: capture-at			( p -- ) ;
: create			( -- ) ;
: create-at			( p -- ) ;
: create-player			( a -- ) ;
: create-player-at		( a p -- ) ;
: create-piece-type		( t -- ) ;
: create-piece-type-at		( t p -- ) ;
: create-player-piece-type	( a t -- ) ;
: create-player-piece-type-at	( a t p -- ) ;
: change-type			( t -- ) ;
: change-type-at		( t p -- ) ;
: change-owner			( a -- ) ;
: change-owner-at		( a p -- ) ;

: verify			( ? -- ) ;
: here				( -- p ) ;
: from				( -- p ) ;
: to				( p -- ) ;
: current-piece			( -- n ) ;
: current-piece-type		( -- t ) ;
: piece				( -- n ) ;
: piece-at			( p -- n ) ;
: piece-value			( n -- n ) ;
: piece-index			( n -- n ) ;
: piece-type			( -- t ) ;
: piece-type-at			( p -- t ) ;

: move-count			( -- n ) ;
: turn-number			( -- n ) ;
: turn-offset			( -- n ) ;
: next-turn-offset		( n -- n ) ;
: turn-offset-to-player		( n -- a ) ;
: next-player			( -- a ) ;
: stalemate?			( -- ? ) ;
: board[]			( p -- ' ) ;
: material-balance		( p -- n ) ;
: player-index			( a -- n ) ;
: player-count			( -- n ) ;

: add-move			( -- ) ;
: partial			( -- ) ;
: partial-move-type		( m -- ) ;
: Pass				( -- ) ;
