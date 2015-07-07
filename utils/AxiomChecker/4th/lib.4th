( ! . <= x ) ( ! x == y ) ( ! x == z )
( ! . <= ' ) ( ! . <= ` ) ( ! . <= * ) ( ! ` == '% )
( ! . <= ? ) ( ! ? == %? )
( ! x <= i ) ( ! x <= m )
( ! i <= p ) ( ! p == pos )
( ! i <= t ) ( ! t == piece-type )
( ! i <= a ) ( ! a == player )

: CONSTANT			( i << i ) ;
: VARIABLE			( << ' ) ;
: DEFER				( << i ) ;
: []				( i << * ) ;
: [']				( << ` ) ;

: {direction}			( << ` ) ;
: {link}			( << ` ) ;
: {variable}			( << ' ) ;
: {position}			( << p ) ;
: {piece}			( << t ) ;
: {player}			( << a ) ;
: {move-type}			( << m ) ;

: EXECUTE			( ` -- ) ;
: IF				( ? -- ) ;
: UNTIL				( ? -- ) ;

: @				( ' -- . ) ;
: !				( . ' -- ) ;

: DUP				( x -- x x ) ;
: 2DUP				( x y -- x y x y ) ;
: SWAP				( x y -- y x ) ;
: DROP				( x -- ) ;
: 2DROP				( x y -- ) ;
: OVER				( x y -- x y x ) ;
: ROT				( x y z -- y z x ) ;

: +				( i i -- i ) ;
: -				( i i -- i ) ;
: *				( i i -- i ) ;
: /				( i i -- i ) ;
: MOD				( i i -- i ) ;
: MIN				( i i -- i ) ;
: MAX				( i i -- i ) ;
: RAND-WITHIN			( i i -- i ) ;
: RAND-WITHIN2			( i i -- i ) ;

: 1+				( i -- i ) ;
: 1-				( i -- i ) ;
: ABS				( i -- i ) ;
: NEGATE			( i -- i ) ;
: ++				( ' -- ) ;
: --				( ' -- ) ;

: =				( i i -- ? ) ;
: <				( i i -- ? ) ;
: >				( i i -- ? ) ;
: <=				( i i -- ? ) ;
: >=				( i i -- ? ) ;

: 0=				( i -- ? ) ;
: 0<				( i -- ? ) ;
: 0>				( i -- ? ) ;
: 0<>				( i -- ? ) ;

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
: current-piece			( -- i ) ;
: current-piece-type		( -- t ) ;
: piece				( -- i ) ;
: piece-at			( p -- i ) ;
: piece-value			( i -- i ) ;
: piece-index			( i -- i ) ;
: piece-type			( -- t ) ;
: piece-type-at			( p -- t ) ;

: move-count			( -- i ) ;
: turn-number			( -- i ) ;
: turn-offset			( -- i ) ;
: next-turn-offset		( i -- i ) ;
: turn-offset-to-player		( i -- a ) ;
: next-player			( -- a ) ;
: stalemate?			( -- ? ) ;
: board[]			( p -- ' ) ;
: material-balance		( p -- i ) ;
: player-index			( a -- i ) ;
: player-count			( -- i ) ;

: add-move			( -- ) ;
: partial			( -- ) ;
: partial-move-type		( m -- ) ;
: Pass				( -- ) ;
