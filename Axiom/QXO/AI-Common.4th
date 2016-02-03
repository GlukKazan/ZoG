: opponent-piece ( pos -- n )
	DUP enemy-at? IF
		piece-at piece-value
	ELSE
		DROP 0
	ENDIF
;

: my-piece ( pos -- n )
	DUP friend-at? IF
		piece-at piece-value
	ELSE
		DROP 0
	ENDIF
;

: add ( n n -- n )
	2DUP 0= SWAP 0= OR IF 2DROP 0 ELSE + ENDIF
;

: max ( n n -- n )
	2DUP 0= SWAP 0= OR IF 2DROP 0 ELSE MAX ENDIF
;

: opponent-line ( pos pos pos -- n )
	opponent-piece
	SWAP opponent-piece max
	SWAP opponent-piece max
;

: my-line ( pos pos pos -- n )
	my-piece
	SWAP my-piece max
	SWAP my-piece max
;

: min ( n n -- n )
	2DUP 0= SWAP 0= OR IF +	ELSE MIN ENDIF
;

: opponent-score? ( -- score )
	1A 1B 1C opponent-line
	2A 2B 2C opponent-line min
	3A 3B 3C opponent-line min
	1A 2A 3A opponent-line min
	1B 2B 3B opponent-line min
	1C 2C 3C opponent-line min
	3A 2B 1C opponent-line min
	1A 2B 3C opponent-line min
;

: my-score? ( -- score )
	1A 1B 1C my-line
	2A 2B 2C my-line min
	3A 3B 3C my-line min
	1A 2A 3A my-line min
	1B 2B 3B my-line min
	1C 2C 3C my-line min
	3A 2B 1C my-line min
	1A 2B 3C my-line min
;
