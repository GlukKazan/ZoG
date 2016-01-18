DEFER	mark

ALL []		pos[]
ALL []		ix[]
VARIABLE	curr-size
VARIABLE	collision-size

: get-x ( pos -- x )
	DIM MOD
;

: get-y ( pos -- y )
	DIM /
;

: get-ix ( pos - ix )
	DUP  get-y get-y DIM *
	SWAP get-x get-y +
;

: find-mark ( -- ix )
	0 BEGIN
		DUP piece-type-at mark = IF
			TRUE
		ELSE
			1+ ALL >=
		ENDIF
	UNTIL
	DUP ALL < verify
	get-ix
;

: pieces-equals-at? ( pos -- ? )
	curr-size @ 0> verify
	DUP curr-size @ 1- pos[] @ = OVER empty-at? OR IF
		DROP FALSE
	ELSE
		piece-type-at
		curr-size @ 1- pos[] @
		piece-type-at =
	ENDIF
;

: is-looped? ( -- ? )
	curr-size @ 0> verify
	FALSE curr-size @ BEGIN
		1-
		DUP ix[] @ curr-size @ ix[] @ = IF
			2DROP TRUE 0
		ENDIF
		DUP 0=
	UNTIL DROP
;

: find-pair ( -- ? )
	FALSE 0 BEGIN
		DUP pieces-equals-at? IF
			DUP get-ix curr-size @ ix[] !
			is-looped? IF
				curr-size @ collision-size !
				DROP ALL
			ELSE
				2DROP TRUE ALL
			ENDIF
		ENDIF
		1+ ALL >=
	UNTIL DROP
;

: try-ix ( -- )
	0 BEGIN
		DUP get-ix curr-size @ ix[] @ = IF
			empty-at? NOT OVER piece-type-at mark > AND IF
				DUP curr-size @ pos[] !
				curr-size ++
				find-pair IF
					RECURSE
				ENDIF
				curr-size --
			ENDIF
		ENDIF
		1+ ALL >=
	UNTIL DROP
;

: find-collision ( -- )
	0 collision-size !
	0 curr-size !
	find-mark 0 ix[] !
	try-ix
;

{pieces
	{piece}		M
	{piece}		x1	1 {value}
	{piece}		X1	1 {value}
	{piece}		o1	1 {value}
	{piece}		O1	1 {value}
	{piece}		x2	2 {value}
	{piece}		X2	2 {value}
	{piece}		o2	2 {value}
	{piece}		O2	2 {value}
	{piece}		x3	3 {value}
	{piece}		X3	3 {value}
	{piece}		o3	3 {value}
	{piece}		O3	3 {value}
	{piece}		x4	4 {value}
	{piece}		X4	4 {value}
	{piece}		o4	4 {value}
	{piece}		O4	4 {value}
	{piece}		x5	5 {value}
	{piece}		X5	5 {value}
pieces}

' M	IS mark
