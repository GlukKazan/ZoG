{moves p-moves
	{move} slide-nw
	{move} slide-ne
	{move} slide-sw
	{move} slide-se
	{move} slide-w
	{move} slide-e
	{move} exchange-1-nw
	{move} exchange-1-ne
	{move} exchange-1-sw
	{move} exchange-1-se
	{move} exchange-1-w
	{move} exchange-1-e
	{move} exchange-2-nw
	{move} exchange-2-ne
	{move} exchange-2-sw
	{move} exchange-2-se
	{move} exchange-2-w
	{move} exchange-2-e
	{move} exchange-3-nw
	{move} exchange-3-ne
	{move} exchange-3-sw
	{move} exchange-3-se
	{move} exchange-3-w
	{move} exchange-3-e
	{move} exchange-4-nw
	{move} exchange-4-ne
	{move} exchange-4-sw
	{move} exchange-4-se
	{move} exchange-4-w
	{move} exchange-4-e
	{move} exchange-5-nw
	{move} exchange-5-ne
	{move} exchange-5-sw
	{move} exchange-5-se
	{move} exchange-5-w
	{move} exchange-5-e
moves}

{pieces
	{piece}		MARK
	{piece}		p1	{moves} p-moves 6   {value}
	{piece}		p2	{moves} p-moves 5   {value}
	{piece}		p3	{moves} p-moves 4   {value}
	{piece}		p4	{moves} p-moves 3   {value}
	{piece}		p5	{moves} p-moves 2   {value}
	{piece}		p6	{moves} p-moves 1   {value}
pieces}

' MARK IS mark
