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

: add-position ( -- )
	list-size @ LS < IF
		here not-in-list? IF
			here list-size @ list[] !
			list-size ++
		ENDIF
	ENDIF
;

: check-dir ( 'dir -- )
	EXECUTE here from <> AND friend? AND IF
		add-position 
	ENDIF
;

: check-coherence ( -- ? )
	0 list-size !
	here DUP list-size @ list[] ! list-size ++
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
	UNTIL DROP to
	TRUE SIZE BEGIN
		1- DUP 0 >= IF
			DUP from <> OVER friend-at? AND IF
				DUP not-in-list? IF
					2DROP FALSE 0
				ENDIF
			ENDIF
		ENDIF
		DUP 0> NOT
	UNTIL DROP
;

: slide ( 'dir -- )
	BEGIN
		DUP EXECUTE empty? AND IF
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
		check-coherence IF
			from here move
			add-move
		ENDIF
	ENDIF
;

: ordo-slide-n ( -- ? )
	here from-pos !
	FALSE step-cnt @ BEGIN
		1- DUP 0 >= IF
			step-dir @ EXECUTE empty? AND NOT IF
				DROP 0
			ENDIF
		ELSE
			from-pos @ here move
			2DROP TRUE 0
		ENDIF
		DUP 0> NOT
	UNTIL DROP
;

: ordo-slide-set ( -- ? )
	FALSE 0 BEGIN
		DUP set-size @ < IF
			DUP set[] @ to
			ordo-slide-n IF
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
	DUP ( check-coherence AND ) IF
		add-move
	ENDIF
;

: ordo-slide ( -- )
	0 step-cnt !
	here BEGIN
		step-cnt ++
		ordo-slide-set NOT
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
;

: slide-n	( -- ) ['] n slide ;
: slide-s	( -- ) ['] s slide ;
: slide-e	( -- ) ['] e slide ;
: slide-w	( -- ) ['] w slide ;

: slide-nw	( -- ) ['] nw slide ;
: slide-sw	( -- ) ['] sw slide ;
: slide-ne	( -- ) ['] ne slide ;
: slide-se	( -- ) ['] se slide ;

: ordo-en	( -- ) ['] e ['] n ordo ;
: ordo-se	( -- ) ['] s ['] e ordo ;
: ordo-sw	( -- ) ['] s ['] w ordo ;
: ordo-es	( -- ) ['] e ['] s ordo ;

{moves man-moves
	{move} slide-n	{move-type} normal-type
	{move} slide-w	{move-type} normal-type
	{move} slide-e	{move-type} normal-type
	{move} slide-nw	{move-type} normal-type
	{move} slide-ne	{move-type} normal-type
	{move} slide-s	{move-type} repair-type
	{move} slide-sw	{move-type} repair-type
	{move} slide-se	{move-type} repair-type

(	{move} ordo-en	{move-type} normal-type
	{move} ordo-se	{move-type} normal-type
	{move} ordo-sw	{move-type} normal-type
	{move} ordo-es	{move-type} repair-type )
moves}


{move-priorities
	{move-priority} normal-type
	{move-priority} repair-type
move-priorities}

{pieces
	{piece}		Man		{moves} man-moves
pieces}

{board-setup
	{setup}	Light Man a2
	{setup}	Light Man a3
	{setup}	Light Man b2
	{setup}	Light Man b3
	{setup}	Light Man c1
	{setup}	Light Man c2
	{setup}	Light Man d1
	{setup}	Light Man d2
	{setup}	Light Man e2
	{setup}	Light Man e3
	{setup}	Light Man f2
	{setup}	Light Man f3
	{setup}	Light Man g1
	{setup}	Light Man g2
	{setup}	Light Man h1
	{setup}	Light Man h2
	{setup}	Light Man i2
	{setup}	Light Man i3
	{setup}	Light Man j2
	{setup}	Light Man j3

	{setup}	Dark  Man a7
	{setup}	Dark  Man a6
	{setup}	Dark  Man b7
	{setup}	Dark  Man b6
	{setup}	Dark  Man c8
	{setup}	Dark  Man c7
	{setup}	Dark  Man d8
	{setup}	Dark  Man d7
	{setup}	Dark  Man e7
	{setup}	Dark  Man e6
	{setup}	Dark  Man f7
	{setup}	Dark  Man f6
	{setup}	Dark  Man g8
	{setup}	Dark  Man g7
	{setup}	Dark  Man h8
	{setup}	Dark  Man h7
	{setup}	Dark  Man i7
	{setup}	Dark  Man i6
	{setup}	Dark  Man j7
	{setup}	Dark  Man j6
board-setup}
