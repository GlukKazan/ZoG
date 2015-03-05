8		CONSTANT	ROWS
10		CONSTANT	COLS
ROWS COLS *	CONSTANT	SIZE
20		CONSTANT	LS
10		CONSTANT	SS

LS []		list[]
VARIABLE	list-size
SS []		set[]
VARIABLE	set-size
VARIABLE	curr-pos
VARIABLE	step-dir
VARIABLE	step-cnt
VARIABLE	from-pos

{board
	ROWS COLS 		{grid}
board}

{directions
	-1  0  {direction} n
	 1  0  {direction} s
	 0  1  {direction} e
	 0 -1  {direction} w
	-1  1  {direction} ne
	-1 -1  {direction} nw
	 1  1  {direction} se
	 1 -1  {direction} sw
directions}

{players
	{player}	Light
	{player}	Dark
players}

{symmetries 
	Dark		{symmetry} n	s
	Dark		{symmetry} nw	sw
	Dark		{symmetry} ne	se
symmetries}

{turn-order
	{turn}		Light
	{turn}		Dark
turn-order}

: not-in-list? ( pos - ? )
	curr-pos !
	TRUE list-size @
	BEGIN
		1- DUP 0 >= IF
			DUP list[] @ curr-pos @ = IF
				2DROP FALSE 0
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL DROP
;

: not-in-set? ( pos - ? )
	curr-pos !
	TRUE set-size @
	BEGIN
		1- DUP 0 >= IF
			DUP set[] @ curr-pos @ = IF
				2DROP FALSE 0
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL DROP
;

: add-position ( -- )
	list-size @ LS < IF
		here not-in-list? IF
			here list-size @ list[] !
			list-size ++
		ENDIF
	ENDIF
;

: not-from? ( pos -- ? )
	DUP from <>
	SWAP not-in-set? AND
;

: check-dir ( 'dir -- )
	EXECUTE here not-from? AND friend? AND IF
		add-position 
	ENDIF
;

: check-coherence ( -- ? )
	here 0 list[] @
	0 BEGIN
		DUP list[] @
		DUP to ['] n  check-dir
		DUP to ['] s  check-dir
		DUP to ['] w  check-dir
		DUP to ['] e  check-dir
		DUP to ['] nw check-dir
		DUP to ['] sw check-dir
		DUP to ['] ne check-dir
		to ['] se check-dir
		1+ DUP list-size @ >=
	UNTIL 2DROP to
	TRUE SIZE BEGIN
		1- DUP 0 >= IF
			DUP not-from? IF
				DUP from <> OVER friend-at? AND IF
					DUP not-in-list? IF
						2DROP FALSE 0
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL DROP
	0 list-size !
;

: slide ( 'dir -- )
	BEGIN
		DUP EXECUTE empty? AND IF
			1 list-size !
			here 0 list[] !
			check-coherence IF
				from here move
				add-move
			ENDIF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	enemy? IF
		1 list-size !
		here 0 list[] !
		check-coherence IF
			from here move
			add-move
		ENDIF
	ENDIF
;

: my-empty? ( -- ? )
	here not-from? NOT 
	empty? OR
;

: ordo-slide-check ( -- ? )
	here from-pos !
	FALSE step-cnt @ BEGIN
		1- DUP 0 >= IF
			step-dir @ EXECUTE my-empty? AND NOT IF
				DROP -1
			ENDIF
		ENDIF
		DUP 0= IF
			here list-size @ list[] ! list-size ++
			2DROP TRUE 0
		ENDIF
		DUP 0> NOT
	UNTIL DROP
;

: ordo-slide-n ( -- ? )
	here from-pos !
	FALSE step-cnt @ BEGIN
		1- DUP 0 >= IF
			step-dir @ EXECUTE my-empty? AND NOT IF
				DROP -1
			ENDIF
		ENDIF
		DUP 0= IF
			from-pos @ here move
			2DROP TRUE 0
		ENDIF
		DUP 0> NOT
	UNTIL DROP
;

: ordo-slide-set ( -- )
	0 list-size !
	FALSE 0 BEGIN
		DUP set-size @ < IF
			DUP set[] @ to
			ordo-slide-check IF
				1+
				FALSE
			ELSE
				TRUE
			ENDIF
		ELSE
			2DROP TRUE 0
			TRUE
		ENDIF
	UNTIL DROP
	IF
		check-coherence IF
			0 BEGIN
				DUP set-size @ < IF
					DUP set[] @ to
					ordo-slide-n IF
						1+
						FALSE
					ELSE
						TRUE
					ENDIF
				ELSE
					TRUE
				ENDIF
			UNTIL DROP
			add-move
		ENDIF
	ENDIF
;

: ordo-slide ( -- )
	0 step-cnt !
	here BEGIN
		step-cnt ++
		ordo-slide-set
		step-cnt @ 9 >
	UNTIL to
;

: ordo ( 'side 'fwd -- )
	step-dir !
	0 set-size !
	here set-size @ set[] ! set-size ++
	BEGIN
		DUP EXECUTE friend? AND IF
			here set-size @ set[] ! set-size ++
			ordo-slide
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	0 set-size !
;

DEFER	MAN

{board-setup
	{setup}	Light MAN a2
	{setup}	Light MAN a3
	{setup}	Light MAN b2
	{setup}	Light MAN b3
	{setup}	Light MAN c1
	{setup}	Light MAN c2
	{setup}	Light MAN d1
	{setup}	Light MAN d2
	{setup}	Light MAN e2
	{setup}	Light MAN e3
	{setup}	Light MAN f2
	{setup}	Light MAN f3
	{setup}	Light MAN g1
	{setup}	Light MAN g2
	{setup}	Light MAN h1
	{setup}	Light MAN h2
	{setup}	Light MAN i2
	{setup}	Light MAN i3
	{setup}	Light MAN j2
	{setup}	Light MAN j3

	{setup}	Dark  MAN a7
	{setup}	Dark  MAN a6
	{setup}	Dark  MAN b7
	{setup}	Dark  MAN b6
	{setup}	Dark  MAN c8
	{setup}	Dark  MAN c7
	{setup}	Dark  MAN d8
	{setup}	Dark  MAN d7
	{setup}	Dark  MAN e7
	{setup}	Dark  MAN e6
	{setup}	Dark  MAN f7
	{setup}	Dark  MAN f6
	{setup}	Dark  MAN g8
	{setup}	Dark  MAN g7
	{setup}	Dark  MAN h8
	{setup}	Dark  MAN h7
	{setup}	Dark  MAN i7
	{setup}	Dark  MAN i6
	{setup}	Dark  MAN j7
	{setup}	Dark  MAN j6
board-setup}
