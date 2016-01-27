{move-priorities
	{move-priority} high-priority
	{move-priority} normal-priority
	{move-priority} low-priority
move-priorities}

{moves p-drop
	{move} drop-half  {move-type} normal-priority
	{move} drop-piece {move-type} normal-priority
	{move} Pass	  {move-type} low-priority
moves}

{pieces
	{piece}		M	{drops} p-drop
	{piece}		x1
	{piece}		o1
	{piece}		x2
	{piece}		o2
	{piece}		x3
	{piece}		o3
	{piece}		x4
	{piece}		o4
	{piece}		x5
	{piece}		X1	1 {value}
	{piece}		O1	1 {value}
	{piece}		X2	2 {value}
	{piece}		O2	2 {value}
	{piece}		X3	3 {value}
	{piece}		O3	3 {value}
	{piece}		X4	4 {value}
	{piece}		O4	4 {value}
	{piece}		X5	5 {value}
pieces}

' M	IS mark
