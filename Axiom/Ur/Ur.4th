{board
	{position}	i4
	{position}	j4
	{position}	k4
	{position}	l4
	{position}	m4
	{position}	n4
	{position}	o4
	{position}	z4
	{position}	a4
	{position}	b4
	{position}	c4
	{position}	d4
	{position}	e4
	{position}	f4
	{position}	g4
	{position}	h4
	{position}	x4
	{position}	i3
	{position}	j3
	{position}	k3
	{position}	l3
	{position}	m3
	{position}	n3
	{position}	o3
	{position}	z3
	{position}	a3
	{position}	b3
	{position}	c3
	{position}	d3
	{position}	e3
	{position}	f3
	{position}	g3
	{position}	h3
	{position}	x3
	{position}	i2
	{position}	j2
	{position}	k2
	{position}	l2
	{position}	m2
	{position}	n2
	{position}	o2
	{position}	z2
	{position}	a2
	{position}	b2
	{position}	c2
	{position}	d2
	{position}	e2
	{position}	f2
	{position}	g2
	{position}	h2
	{position}	x2
	{position}	i1
	{position}	j1
	{position}	k1
	{position}	l1
	{position}	m1
	{position}	n1
	{position}	o1
	{position}	z1
	{position}	a1
	{position}	b1
	{position}	c1
	{position}	d1
	{position}	e1
	{position}	f1
	{position}	g1
	{position}	h1
	{position}	x1
	{position}	i0
	{position}	j0
	{position}	k0
	{position}	l0
	{position}	m0
	{position}	n0
	{position}	o0
	{position}	z0
	{position}	a0
	{position}	b0
	{position}	c0
	{position}	d0
	{position}	e0
	{position}	f0
	{position}	g0
	{position}	h0
	{position}	x0
	{position}	offboard
board}

{players
	{player}	Up
	{player}	Down
	{player}	?Dice	{random}
players}

{pieces
	{piece}		wdice
	{piece}		bdice
	{piece}		lock
	{piece}		ulock
	{piece}		dlock
	{piece}		uinitial
	{piece}		upromouted
	{piece}		dinitial
	{piece}		dpromouted
	{piece}		Dummy
pieces}

{turn-order
	{turn}	Down
	{repeat}
	{turn}	?Dice	{of-type} clear-type
	{turn}	?Dice	{of-type} drop-type
	{turn}	?Dice	{of-type} drop-type
	{turn}	?Dice	{of-type} drop-type
	{turn}	Up
	{turn}	?Dice	{of-type} clear-type
	{turn}	?Dice	{of-type} drop-type
	{turn}	?Dice	{of-type} drop-type
	{turn}	?Dice	{of-type} drop-type
	{turn}	Down
turn-order}

{board-setup
	{setup}	?Dice wdice x3
	{setup}	?Dice bdice x2
	{setup}	?Dice bdice x1

	{setup}	Up uinitial a4
	{setup}	Up uinitial b4
	{setup}	Up uinitial c4
	{setup}	Up uinitial d4
	{setup}	Up uinitial e4
	{setup}	Up uinitial f4
	{setup}	Up uinitial g4

	{setup}	Down dinitial a0
	{setup}	Down dinitial b0
	{setup}	Down dinitial c0
	{setup}	Down dinitial d0
	{setup}	Down dinitial e0
	{setup}	Down dinitial f0
	{setup}	Down dinitial g0
board-setup}

