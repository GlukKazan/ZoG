{move-priorities
	{move-priority} normal-priority
	{move-priority} low-priority
move-priorities}

{moves p-moves
	{move} eat-nw-0		{move-type} normal-priority
	{move} eat-ne-0		{move-type} normal-priority
	{move} eat-sw-0		{move-type} normal-priority
	{move} eat-se-0		{move-type} normal-priority
	{move} eat-w-0		{move-type} normal-priority
	{move} eat-e-0		{move-type} normal-priority
	{move} eat-nw-1		{move-type} normal-priority
	{move} eat-ne-1		{move-type} normal-priority
	{move} eat-sw-1		{move-type} normal-priority
	{move} eat-se-1		{move-type} normal-priority
	{move} eat-w-1		{move-type} normal-priority
	{move} eat-e-1		{move-type} normal-priority
	{move} slide-nw		{move-type} normal-priority
	{move} slide-ne		{move-type} normal-priority
	{move} slide-sw		{move-type} normal-priority
	{move} slide-se		{move-type} normal-priority
	{move} slide-w		{move-type} normal-priority
	{move} slide-e		{move-type} normal-priority
	{move} exchange-1-nw	{move-type} normal-priority
	{move} exchange-1-ne	{move-type} normal-priority
	{move} exchange-1-sw	{move-type} normal-priority
	{move} exchange-1-se	{move-type} normal-priority
	{move} exchange-1-w	{move-type} normal-priority
	{move} exchange-1-e	{move-type} normal-priority
	{move} exchange-2-nw	{move-type} normal-priority
	{move} exchange-2-ne	{move-type} normal-priority
	{move} exchange-2-sw	{move-type} normal-priority
	{move} exchange-2-se	{move-type} normal-priority
	{move} exchange-2-w	{move-type} normal-priority
	{move} exchange-2-e	{move-type} normal-priority
	{move} exchange-3-nw	{move-type} normal-priority
	{move} exchange-3-ne	{move-type} normal-priority
	{move} exchange-3-sw	{move-type} normal-priority
	{move} exchange-3-se	{move-type} normal-priority
	{move} exchange-3-w	{move-type} normal-priority
	{move} exchange-3-e	{move-type} normal-priority
	{move} exchange-4-nw	{move-type} normal-priority
	{move} exchange-4-ne	{move-type} normal-priority
	{move} exchange-4-sw	{move-type} normal-priority
	{move} exchange-4-se	{move-type} normal-priority
	{move} exchange-4-w	{move-type} normal-priority
	{move} exchange-4-e	{move-type} normal-priority
	{move} exchange-5-nw	{move-type} normal-priority
	{move} exchange-5-ne	{move-type} normal-priority
	{move} exchange-5-sw	{move-type} normal-priority
	{move} exchange-5-se	{move-type} normal-priority
	{move} exchange-5-w	{move-type} normal-priority
	{move} exchange-5-e	{move-type} normal-priority
moves}

{moves m-drop
	{move} drop-m		{move-type} clear-mode
	{move} Pass		{move-type} low-priority
moves}

{pieces
	{piece}		m	{drops} m-drop
	{piece}		p1	{moves} p-moves 6   {value}
	{piece}		p2	{moves} p-moves 5   {value}
	{piece}		p3	{moves} p-moves 4   {value}
	{piece}		p4	{moves} p-moves 3   {value}
	{piece}		p5	{moves} p-moves 2   {value}
	{piece}		p6	{moves} p-moves 1   {value}
pieces}

' m IS mark
