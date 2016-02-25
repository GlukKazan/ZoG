DEFER	mark

: val ( -- n )
	piece-type mark -
;

: mirror ( 'dir  -- 'dir )
	DUP ['] nw = IF
		DROP ['] sw
	ELSE
		DUP ['] ne = IF
			DROP ['] se
		ELSE
			DUP ['] sw = IF
				DROP ['] nw
			ELSE
				['] se = verify
				['] ne
			ENDIF
		ENDIF
	ENDIF
;

: step ( 'dir  -- 'dir )
	DUP EXECUTE NOT IF
		mirror
		DUP EXECUTE verify
	ENDIF
;

: exchange ( n 'dir -- )
	OVER val < verify
	EXECUTE verify
	friend? verify
	DUP val + 6 <= verify
	from here move
	DUP piece-type + create-piece-type
	from to piece-type SWAP - create-piece-type
	add-move
;

: exchange-1-nw ( -- ) 1 ['] nw exchange ;
: exchange-1-sw ( -- ) 1 ['] sw exchange ;
: exchange-1-ne ( -- ) 1 ['] ne exchange ;
: exchange-1-se ( -- ) 1 ['] se exchange ;
: exchange-1-w  ( -- ) 1 ['] w  exchange ;
: exchange-1-e  ( -- ) 1 ['] e  exchange ;

: exchange-2-nw ( -- ) 2 ['] nw exchange ;
: exchange-2-sw ( -- ) 2 ['] sw exchange ;
: exchange-2-ne ( -- ) 2 ['] ne exchange ;
: exchange-2-se ( -- ) 2 ['] se exchange ;
: exchange-2-w  ( -- ) 2 ['] w  exchange ;
: exchange-2-e  ( -- ) 2 ['] e  exchange ;

: exchange-3-nw ( -- ) 3 ['] nw exchange ;
: exchange-3-sw ( -- ) 3 ['] sw exchange ;
: exchange-3-ne ( -- ) 3 ['] ne exchange ;
: exchange-3-se ( -- ) 3 ['] se exchange ;
: exchange-3-w  ( -- ) 3 ['] w  exchange ;
: exchange-3-e  ( -- ) 3 ['] e  exchange ;

: exchange-4-nw ( -- ) 4 ['] nw exchange ;
: exchange-4-sw ( -- ) 4 ['] sw exchange ;
: exchange-4-ne ( -- ) 4 ['] ne exchange ;
: exchange-4-se ( -- ) 4 ['] se exchange ;
: exchange-4-w  ( -- ) 4 ['] w  exchange ;
: exchange-4-e  ( -- ) 4 ['] e  exchange ;

: exchange-5-nw ( -- ) 5 ['] nw exchange ;
: exchange-5-sw ( -- ) 5 ['] sw exchange ;
: exchange-5-ne ( -- ) 5 ['] ne exchange ;
: exchange-5-se ( -- ) 5 ['] se exchange ;
: exchange-5-w  ( -- ) 5 ['] w  exchange ;
: exchange-5-e  ( -- ) 5 ['] e  exchange ;

: my-empty? ( -- ? )
	empty? NOT IF
		FALSE
	ELSE
		here E5 <>
	ENDIF
;

: bump ( 'dir -- )
	BEGIN
		here E5 <> verify
		friend? here from <> AND IF
			piece-type SWAP step SWAP
			create-piece-type
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: slide ( 'dir -- )
	val SWAP BEGIN
		step
		SWAP 1- DUP 0= IF
			TRUE
		ELSE
			my-empty? verify
			SWAP FALSE
		ENDIF
	UNTIL DROP
	my-empty? friend? OR verify
	from here move
	bump
	add-move
;

: slide-nw ( -- ) ['] nw slide ;
: slide-sw ( -- ) ['] sw slide ;
: slide-ne ( -- ) ['] ne slide ;
: slide-se ( -- ) ['] se slide ;
: slide-w  ( -- ) ['] w  slide ;
: slide-e  ( -- ) ['] e  slide ;
