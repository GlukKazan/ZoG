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
	{piece}		M
	{piece}		x1	{drops} p-drop
	{piece}		o1	{drops} p-drop
	{piece}		x2	{drops} p-drop
	{piece}		o2	{drops} p-drop
	{piece}		x3	{drops} p-drop
	{piece}		o3	{drops} p-drop
	{piece}		x4	{drops} p-drop
	{piece}		o4	{drops} p-drop
	{piece}		x5	{drops} p-drop
	{piece}		X1
	{piece}		O1
	{piece}		X2
	{piece}		O2
	{piece}		X3
	{piece}		O3
	{piece}		X4
	{piece}		O4
	{piece}		X5
pieces}

' M	IS mark
