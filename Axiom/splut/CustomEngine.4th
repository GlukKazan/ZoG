LOAD Board.4th ( Load the Board Definitions )

VARIABLE	BestScore
VARIABLE	Nodes
VARIABLE	BaseScore

: get-score-at ( pos -- score )
	DUP not-empty-at? IF
		DUP friend-at? IF
			DROP
			0
		ELSE
			piece-at piece-value
		ENDIF
	ELSE
		DROP
		0
	ENDIF
;

: Score ( -- score )
	a5 get-score-at
	b4 get-score-at +
	b5 get-score-at +
	b6 get-score-at +
	c3 get-score-at +
	c4 get-score-at +
	c5 get-score-at +
	c6 get-score-at +
	c7 get-score-at +
	d2 get-score-at +
	d3 get-score-at +
	d4 get-score-at +
	d5 get-score-at +
	d6 get-score-at +
	d7 get-score-at +
	d8 get-score-at +
	e1 get-score-at +
	e2 get-score-at +
	e3 get-score-at +
	e4 get-score-at +
	e5 get-score-at +
	e6 get-score-at +
	e7 get-score-at +
	e8 get-score-at +
	e9 get-score-at +
	f2 get-score-at +
	f3 get-score-at +
	f4 get-score-at +
	f5 get-score-at +
	f6 get-score-at +
	f7 get-score-at +
	f8 get-score-at +
	g3 get-score-at +
	g4 get-score-at +
	g5 get-score-at +
	g6 get-score-at +
	g7 get-score-at +
	h4 get-score-at +
	h5 get-score-at +
	h6 get-score-at +
	i5 get-score-at +
;

: Custom-Engine ( -- )
	-1000 BestScore !
	0 Nodes !
	Score BaseScore !
	$FirstMove
	BEGIN
		$CloneBoard
		DUP $MoveString CurrentMove!
		DUP .moveCFA EXECUTE
		BaseScore @ Score -
		BestScore @ OVER <
		IF
			DUP BestScore !
			Score!
			DUP $MoveString BestMove!
		ELSE
			DROP
		ENDIF
		$DeallocateBoard
		Nodes ++
		Nodes @ Nodes!
		$Yield
		$NextMove
		DUP NOT
	UNTIL
	DROP
;
