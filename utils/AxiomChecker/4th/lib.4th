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

: @				( ' -- x ) ;
: !				( i ' -- ) ;

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
: empty-at?			( i -- ? ) ;
: not-empty?			( -- ? ) ;
: not-empty-at?			( i -- ? ) ;
: not-piece-type		( i -- ? ) ;
: not-piece-type-at		( i i -- ? ) ;
: friend?			( -- ? ) ;
: friend-at?			( -- ? ) ;
: friend-of?			( a -- ? ) ;
: enemy?			( -- ? ) ;
: enemy-at?			( -- ? ) ;
: enemy-of?			( a -- ? ) ;
: neutral-piece?		( -- ? ) ;
: neutral-piece-at?		( i -- ? ) ;

: current-player		( -- a ) ;
: for-player			( -- a ) ;
: of-type			( -- m ) ;
: player			( -- a ) ;
: player-at			( i -- a ) ;

: move				( i i -- ) ;
: drop				( -- ) ;
: drop-piece			( i -- ) ;
: drop-piece-at			( i i -- ) ;
: capture			( -- ) ;
: capture-at			( i -- ) ;
: create			( -- ) ;
: create-at			( i -- ) ;
: create-player			( a -- ) ;
: create-player-at		( a i -- ) ;
: create-piece-type		( i -- ) ;
: create-piece-type-at		( i i -- ) ;
: create-player-piece-type	( a i -- ) ;
: create-player-piece-type-at	( a i i -- ) ;
: change-type			( i -- ) ;
: change-type-at		( i i -- ) ;
: change-owner			( a -- ) ;
: change-owner-at		( a i -- ) ;

: verify			( ? -- ) ;
: here				( -- p ) ;
: from				( -- p ) ;
: to				( i -- ) ;
: current-piece			( -- i ) ;
: current-piece-type		( -- t ) ;
: piece				( -- i ) ;
: piece-at			( i -- i ) ;
: piece-value			( i -- i ) ;
: piece-index			( i -- i ) ;
: piece-type			( -- t ) ;
: piece-type-at			( i -- t ) ;

: move-count			( -- i ) ;
: turn-number			( -- i ) ;
: turn-offset			( -- i ) ;
: next-turn-offset		( i -- i ) ;
: turn-offset-to-player		( i -- a ) ;
: next-player			( -- a ) ;
: stalemate?			( -- ? ) ;
: board[]			( i -- ' ) ;
: material-balance		( i -- i ) ;
: player-index			( a -- i ) ;
: player-count			( -- i ) ;

: add-move			( -- ) ;
: partial			( -- ) ;
: partial-move-type		( m -- ) ;
: Pass				( -- ) ;
