{move-priorities
	{move-priority} high-priority
	{move-priority} normal-priority
	{move-priority} low-priority
move-priorities}

{moves p-drop
	{move} select-piece	{move-type} high-priority
	{move} drop-half-3 	{move-type} normal-priority
	{move} Pass		{move-type} low-priority
moves}

{moves h-move
	{move} move-half-n 	{move-type} normal-priority
	{move} move-half-s 	{move-type} normal-priority
	{move} move-half-w 	{move-type} normal-priority
	{move} move-half-e 	{move-type} normal-priority
	{move} move-half-nw 	{move-type} normal-priority
	{move} move-half-sw 	{move-type} normal-priority
	{move} move-half-ne 	{move-type} normal-priority
	{move} move-half-se 	{move-type} normal-priority
	{move} join-piece-n 	{move-type} normal-priority
	{move} join-piece-s 	{move-type} normal-priority
	{move} join-piece-w 	{move-type} normal-priority
	{move} join-piece-e 	{move-type} normal-priority
	{move} join-piece-nw 	{move-type} normal-priority
	{move} join-piece-sw 	{move-type} normal-priority
	{move} join-piece-ne 	{move-type} normal-priority
	{move} join-piece-se 	{move-type} normal-priority
moves}

{moves p-move
	{move} split-piece-n 	{move-type} normal-priority
	{move} split-piece-s 	{move-type} normal-priority
	{move} split-piece-w 	{move-type} normal-priority
	{move} split-piece-e 	{move-type} normal-priority
	{move} split-piece-nw 	{move-type} normal-priority
	{move} split-piece-sw 	{move-type} normal-priority
	{move} split-piece-ne 	{move-type} normal-priority
	{move} split-piece-se 	{move-type} normal-priority
moves}

{pieces
	{piece}		M	{drops} p-drop {moves} p-move
	{piece}		x1	{moves} h-move
	{piece}		o1	{moves} h-move
	{piece}		x2	{moves} h-move
	{piece}		o2	{moves} h-move
	{piece}		x3	{moves} h-move
	{piece}		o3	{moves} h-move
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
' x4	IS half
