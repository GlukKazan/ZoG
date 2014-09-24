32	CONSTANT	HLFC

VARIABLE	white-pyramid-is-missing?
VARIABLE	black-pyramid-is-missing?
VARIABLE	white-half-count
VARIABLE	black-half-count
VARIABLE	half-size
VARIABLE        a-index
VARIABLE        b-index
VARIABLE        c-index
VARIABLE        a-value
VARIABLE        b-value
VARIABLE        c-value
VARIABLE        result-value

HLFC []		white-half-value[]
HLFC []		black-half-value[]
HLFC []		white-half-pos[]
HLFC []		black-half-pos[]
HLFC [] 	white-half-enemy[]
HLFC [] 	black-half-enemy[]

: get-half-count ( ? -- count )
	IF
		white-half-count @
	ELSE
		black-half-count @
	ENDIF
;

: inc-half-count ( ? -- )
	IF
		white-half-count ++
	ELSE
		black-half-count ++
	ENDIF
;

: load-piece ( ? pos value -- )
	ROT DUP get-half-count HLFC < IF
		SWAP OVER DUP get-half-count SWAP IF
			white-half-value[] !
		ELSE
			black-half-value[] !
		ENDIF
		SWAP OVER DUP get-half-count SWAP IF
			2DUP SWAP player-at White = SWAP white-half-enemy[] !
			white-half-pos[] !
		ELSE
			2DUP SWAP player-at Black = SWAP black-half-enemy[] !
			black-half-pos[] !
		ENDIF
		inc-half-count
	ELSE
		2DROP DROP
	ENDIF
;

: load-pieces ( ? pos -- )
	DUP piece-type-at PYRAMID > IF
		DUP player-at White = IF
			FALSE white-pyramid-is-missing? !
		ENDIF
		DUP player-at Black = IF
			FALSE black-pyramid-is-missing? !
		ENDIF
		0 sum-value !
		a1 to
		DUP friend-at? IF
			BEGIN
				friend-p IF
					empty? NOT IF
						2DUP piece piece-value 
						DUP sum-value @ + sum-value !
						load-piece
					ENDIF
					FALSE
				ELSE
					TRUE
				ENDIF
			UNTIL
		ELSE
			BEGIN
				enemy-p IF
					empty? NOT IF
						2DUP piece piece-value 
						DUP sum-value @ + sum-value !
						load-piece
					ENDIF
					FALSE
				ELSE
					TRUE
				ENDIF
			UNTIL
		ENDIF
		sum-value @ DUP 0> IF
			load-piece
		ELSE
			2DROP DROP
		ENDIF
	ELSE
		DUP piece-at piece-value load-piece
	ENDIF
;

: load-halfs ( -- )
	0 white-half-count !
	0 black-half-count !
	TRUE white-pyramid-is-missing? !
	TRUE black-pyramid-is-missing? !
	ROWS COLS *
	DUP 2/ half-size !
	BEGIN
		1-
		DUP on-board-at? OVER empty-at? NOT AND IF
			DUP half-size @ < IF
				TRUE OVER load-pieces
			ELSE
				FALSE OVER load-pieces
			ENDIF
		ENDIF
		DUP 0=
	UNTIL
	DROP
;

: enemy-present? ( ? -- ? )
	IF
		a-index @ white-half-enemy[] @
		b-index @ white-half-enemy[] @ OR
		c-index @ white-half-enemy[] @ OR
	ELSE
		a-index @ black-half-enemy[] @
		b-index @ black-half-enemy[] @ OR
		c-index @ black-half-enemy[] @ OR
	ENDIF
;

: get-pos-by-index ( ? index -- pos )
	SWAP IF
		white-half-pos[] @
	ELSE
		black-half-pos[] @
	ENDIF
;

: get-value-by-index ( ? index -- value )
	SWAP IF
		white-half-value[] @
	ELSE
		black-half-value[] @
	ENDIF
;

: get-positions ( ? -- a b c )
	DUP a-index @ get-pos-by-index SWAP
	DUP b-index @ get-pos-by-index SWAP
	c-index @ get-pos-by-index
;

: get-values ( ? -- a b c )
	DUP a-index @ get-value-by-index SWAP
	DUP b-index @ get-value-by-index SWAP
	c-index @ get-value-by-index
;

: get-x ( pos -- x )
	COLS MOD
;

: get-y ( pos -- y )
	COLS /
;

: sort-values ( -- )
	b-value @ a-value @ 2DUP < IF
		b-value !
		a-value !
	ELSE
		2DROP
	ENDIF
	c-value @ b-value @ 2DUP < IF
		c-value !
		b-value !
	ELSE
		2DROP
	ENDIF
	b-value @ a-value @ 2DUP < IF
		b-value !
		a-value !
	ELSE
		2DROP
	ENDIF
;

: is-arranged? ( a b c -- ? )
	a-value ! b-value ! c-value ! FALSE
	sort-values
	a-value @ get-y b-value @ get-y = 
        b-value @ get-x c-value @ get-x = AND IF
		a-value @ get-x b-value @ get-x - ABS
		b-value @ get-y c-value @ get-y - ABS = OR
	ENDIF
	a-value @ get-x b-value @ get-x = 
        b-value @ get-y c-value @ get-y = AND IF
		a-value @ get-y b-value @ get-y - ABS
		b-value @ get-x c-value @ get-x - ABS = OR
	ENDIF
	b-value @ get-y c-value @ get-y = 
        c-value @ get-x a-value @ get-x = AND IF
		b-value @ get-x c-value @ get-x - ABS
		c-value @ get-y a-value @ get-y - ABS = OR
	ENDIF
	b-value @ get-x c-value @ get-x = 
        c-value @ get-y a-value @ get-y = AND IF
		b-value @ get-y c-value @ get-y - ABS
		c-value @ get-x a-value @ get-x - ABS = OR
	ENDIF
	b-value @ get-x a-value @ get-x -
	c-value @ get-x b-value @ get-x - =
	b-value @ get-y a-value @ get-y -
	c-value @ get-y b-value @ get-y - = AND OR
;

: is-progression? ( a b c -- ? )
	a-value ! b-value ! c-value ! FALSE
	sort-values
	b-value @ a-value @ - c-value @ b-value @ - = OR
	a-value @ c-value @ * b-value @ b-value @ * = OR
	a-value @ c-value @ + b-value @ * a-value @ c-value @ * 2* = OR
;

: check-set ( ? -- )
	DUP enemy-present? IF
		DUP get-positions is-arranged? IF
			DUP get-values is-progression? IF
				DUP IF
					current-player White = IF
						#WinScore
					ELSE
						#LossScore
					ENDIF
				ELSE
					current-player Black = IF
						#WinScore
					ELSE
						#LossScore
					ENDIF
				ENDIF
				result-value !
			ENDIF
		ENDIF
	ENDIF
	DROP
;

: iterate-c ( ? count -- ? count )
	b-index @ 1+ c-index !
	BEGIN
		c-index @ OVER < IF
		        OVER check-set
			c-index ++
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
;

: iterate-b ( ? count -- ? count )
	a-index @ 1+ b-index !
	BEGIN
		b-index @ OVER < IF
			iterate-c
			b-index ++
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
;

: iterate-a ( ? count -- )
	0 a-index !
	BEGIN
		a-index @ OVER < IF
			iterate-b
			a-index ++
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL
	2DROP
;

: OnIsGameOver ( -- gameResult )
	#UnknownScore result-value !
	CheckGameOver result-value !
	result-value @ #UnknownScore = IF
		here  load-halfs to
		TRUE  white-half-count @ iterate-a
		FALSE black-half-count @ iterate-a
	ENDIF
	result-value @
;
