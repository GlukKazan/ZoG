{board
	ROWS COLS	{grid}
board}

{directions
	-1	 0	{direction} n
	 1	 0	{direction} s
	 0	 1	{direction} e
	 0	-1	{direction} w
	-1	-1	{direction} nw
	 1	-1	{direction} sw
	-1	 1	{direction} ne
	 1	 1	{direction} se

	 {link} n a4 a1
	 {link} n b4 b1
	 {link} n c4 c1
	 {link} n d4 d1
	 {link} n e4 e1
	 {link} n f4 f1
	 {link} n g4 g1
	 {link} n h4 h1

	 {link} s a1 a4
	 {link} s b1 b4
	 {link} s c1 c4
	 {link} s d1 d4
	 {link} s e1 e4
	 {link} s f1 f4
	 {link} s g1 g4
	 {link} s h1 h4

	 {link} e h1 a1
	 {link} e h2 a2
	 {link} e h3 a3
	 {link} e h4 a4

	 {link} w a1 h1
	 {link} w a2 h2
	 {link} w a3 h3
	 {link} w a4 h4

	 {link} nw a1 h2
	 {link} nw a2 h3
	 {link} nw a3 h4
	 {link} nw a4 h1
	 {link} nw b4 a1
	 {link} nw c4 b1
	 {link} nw d4 c1
	 {link} nw e4 d1
	 {link} nw f4 e1
	 {link} nw g4 f1
	 {link} nw h4 g1

	 {link} se h2 a1
	 {link} se h3 a2
	 {link} se h4 a3
	 {link} se h1 a4
	 {link} se a1 b4
	 {link} se b1 c4
	 {link} se c1 d4
	 {link} se d1 e4
	 {link} se e1 f4
	 {link} se f1 g4
	 {link} se g1 h4

	 {link} ne h1 a2
	 {link} ne h2 a3
	 {link} ne h3 a4
	 {link} ne h4 a1
	 {link} ne g4 h1
	 {link} ne f4 g1
	 {link} ne e4 f1
	 {link} ne d4 e1
	 {link} ne c4 d1
	 {link} ne b4 c1
	 {link} ne a4 b1

	 {link} sw a2 h1
	 {link} sw a3 h2
	 {link} sw a4 h3
	 {link} sw a1 h4
	 {link} sw h1 g4
	 {link} sw g1 f4
	 {link} sw f1 e4
	 {link} sw e1 d4
	 {link} sw d1 c4
	 {link} sw c1 b4
	 {link} sw b1 a4
directions}
