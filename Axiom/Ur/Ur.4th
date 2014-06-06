{board
	5 17 		{grid}
board}

{directions
	( Afree )
	{link}		Afree h5 i5
	{link}		Afree i5 j5
	{link}		Afree j5 k5
	{link}		Afree k5 l5
	{link}		Afree l5 m5
	{link}		Afree m5 n5
	{link}		Afree n5 o5

	( Bfree )
	{link}		Bfree h5 i1
	{link}		Bfree i1 j1
	{link}		Bfree j1 k1
	{link}		Bfree k1 l1
	{link}		Bfree l1 m1
	{link}		Bfree m1 n1
	{link}		Bfree n1 o1

	( Anext )
	{link}		Anext i1 l2
	{link}		Anext j1 l2
	{link}		Anext k1 l2
	{link}		Anext l1 l2
	{link}		Anext m1 l2
	{link}		Anext n1 l2
	{link}		Anext o1 l2
	{link}		Anext l2 k2
	{link}		Anext k2 j2
	{link}		Anext j2 i2
	{link}		Anext i2 i3
	{link}		Anext i3 j3
	{link}		Anext j3 k3
	{link}		Anext k3 l3
	{link}		Anext l3 m3
	{link}		Anext m3 n3
	{link}		Anext n3 o3
	{link}		Anext o3 o2
	{link}		Anext o2 p2
	{link}		Anext p2 p3
	{link}		Anext p3 p4
	{link}		Anext p4 o4
	{link}		Anext o4 o3

	( Bnext )
	{link}		Bnext i5 l4
	{link}		Bnext j5 l4
	{link}		Bnext k5 l4
	{link}		Bnext l5 l4
	{link}		Bnext m5 l4
	{link}		Bnext n5 l4
	{link}		Bnext o5 l4
	{link}		Bnext l4 k4
	{link}		Bnext k4 j4
	{link}		Bnext j4 i4
	{link}		Bnext i4 i3
	{link}		Bnext i3 j3
	{link}		Bnext j3 k3
	{link}		Bnext k3 l3
	{link}		Bnext l3 m3
	{link}		Bnext m3 n3
	{link}		Bnext n3 o3
	{link}		Bnext o3 o4
	{link}		Bnext o4 p4
	{link}		Bnext p4 p3
	{link}		Bnext p3 p2
	{link}		Bnext p2 o2
	{link}		Bnext o2 o3

	( Cnext )
	{link}		Cnext p3 p4
	{link}		Cnext p4 o4
	{link}		Cnext o4 o3
	{link}		Cnext o3 n3
	{link}		Cnext n3 m3
	{link}		Cnext m3 l3
	{link}		Cnext l3 k3
	{link}		Cnext k3 j3
	{link}		Cnext j3 i3
	{link}		Cnext i3 h3

	( Dnext )
	{link}		Dnext p3 p2
	{link}		Dnext p2 o2
	{link}		Dnext o2 o3
	{link}		Dnext o3 n3
	{link}		Dnext n3 m3
	{link}		Dnext m3 l3
	{link}		Dnext l3 k3
	{link}		Dnext k3 j3
	{link}		Dnext j3 i3
	{link}		Dnext i3 h3

	( Next )
	{link}		Next q2 q3
	{link}		Next q3 q4

	( Top )
	{link}		Top j2 a2
	{link}		Top a2 a3
	{link}		Top a3 a4

	{link}		Top j4 b2
	{link}		Top b2 b3
	{link}		Top b3 b4

	{link}		Top l2 c2
	{link}		Top c2 c3
	{link}		Top c3 c4

	{link}		Top l4 d2
	{link}		Top d2 d3
	{link}		Top d3 d4

	{link}		Top o3 e2
	{link}		Top e2 e3
	{link}		Top e3 e4

	{link}		Top k3 f2
	{link}		Top f2 f3
	{link}		Top f3 f4

	{link}		Top n3 g2
	{link}		Top g2 g3
	{link}		Top g3 g4

directions}

{players
	{player}	Down    {random}
	{player}	Up      {random}
	{player}	?Dice	{random}
players}

{symmetries 
	Up		{symmetry} Afree Bfree
	Up		{symmetry} Anext Bnext
	Up		{symmetry} Cnext Dnext
symmetries}

{turn-order
	{turn}	Down
\	{repeat}
\	{turn}	?Dice	{of-type} clear-type
\	{turn}	?Dice	{of-type} drop-type
\	{turn}	?Dice	{of-type} drop-type
\	{turn}	?Dice	{of-type} drop-type
	{turn}	Up
\	{turn}	?Dice	{of-type} clear-type
\	{turn}	?Dice	{of-type} drop-type
\	{turn}	?Dice	{of-type} drop-type
\	{turn}	?Dice	{of-type} drop-type
\	{turn}	Down
turn-order}

h3	CONSTANT	endPosition

: common-move ( 'dir n -- )
	SWAP
	BEGIN
		DUP EXECUTE DROP SWAP
		1-  DUP
		0=  IF
			DROP
			TRUE
		ELSE
			SWAP
			FALSE
		ENDIF
	UNTIL
	empty?	IF
		from
		here
		move
		here endPosition
		= IF
			capture
		ENDIF
		add-move
	ENDIF
;

: i-move-1 ( -- ) ['] Anext 1 common-move ;
: i-move-2 ( -- ) ['] Anext 2 common-move ;
: i-move-3 ( -- ) ['] Anext 3 common-move ;
: i-move-4 ( -- ) ['] Anext 4 common-move ;
: p-move-1 ( -- ) ['] Cnext 1 common-move ;
: p-move-2 ( -- ) ['] Cnext 2 common-move ;
: p-move-3 ( -- ) ['] Cnext 3 common-move ;
: p-move-4 ( -- ) ['] Cnext 4 common-move ;

{moves i-moves
	{move} i-move-1
	{move} i-move-2
	{move} i-move-3
	{move} i-move-4
moves}

{moves p-moves
	{move} p-move-1
	{move} p-move-2
	{move} p-move-3
	{move} p-move-4
moves}

{pieces
	{piece}		uinitial	{moves} i-moves
	{piece}		upromouted	{moves} p-moves
	{piece}		dinitial	{moves} i-moves
	{piece}		dpromouted	{moves} p-moves
	{piece}		wdice
	{piece}		bdice
	{piece}		lock
	{piece}		ulock
	{piece}		dlock
pieces}

{board-setup
	{setup}	?Dice wdice q4
	{setup}	?Dice bdice q3
	{setup}	?Dice bdice q2

	{setup}	Up uinitial i5
	{setup}	Up uinitial j5
	{setup}	Up uinitial k5
	{setup}	Up uinitial l5
	{setup}	Up uinitial m5
	{setup}	Up uinitial n5
	{setup}	Up uinitial o5

	{setup}	Down dinitial i1
	{setup}	Down dinitial j1
	{setup}	Down dinitial k1
	{setup}	Down dinitial l1
	{setup}	Down dinitial m1
	{setup}	Down dinitial n1
	{setup}	Down dinitial o1
board-setup}
