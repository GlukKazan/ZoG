{move-priorities
	{move-priority} normal-type
	{move-priority} pass-type
move-priorities}

{moves g-moves
	{move} slide-n	{move-type} normal-type
	{move} slide-s	{move-type} normal-type
	{move} slide-w	{move-type} normal-type
	{move} slide-e	{move-type} normal-type
	{move} slide-nw	{move-type} normal-type
	{move} slide-sw	{move-type} normal-type
	{move} slide-se	{move-type} normal-type
	{move} slide-ne	{move-type} normal-type
moves}

{moves d-moves
	{move} slide-n	{move-type} normal-type
	{move} slide-s	{move-type} normal-type
	{move} slide-w	{move-type} normal-type
	{move} slide-e	{move-type} normal-type
moves}

{moves o-moves
	{move} slide-nw	{move-type} normal-type
	{move} slide-sw	{move-type} normal-type
	{move} slide-se	{move-type} normal-type
	{move} slide-ne	{move-type} normal-type
moves}

{moves l-moves
	{move} move-n	{move-type} normal-type
	{move} move-s	{move-type} normal-type
	{move} move-w	{move-type} normal-type
	{move} move-e	{move-type} normal-type
	{move} move-nw	{move-type} normal-type
	{move} move-sw	{move-type} normal-type
	{move} move-se	{move-type} normal-type
	{move} move-ne	{move-type} normal-type
moves}

{moves p-moves
	{move} shoot-n	{move-type} normal-type
	{move} shoot-s	{move-type} normal-type
	{move} shoot-w	{move-type} normal-type
	{move} shoot-e	{move-type} normal-type
moves}

{moves h-moves
	{move} jump-nnw	{move-type} normal-type
	{move} jump-nne	{move-type} normal-type
	{move} jump-ssw	{move-type} normal-type
	{move} jump-sse	{move-type} normal-type
	{move} jump-wws	{move-type} normal-type
	{move} jump-wwn	{move-type} normal-type
	{move} jump-ees	{move-type} normal-type
	{move} jump-een	{move-type} normal-type
moves}

{moves a-moves
	{move} slide-4-n  {move-type} normal-type
	{move} slide-4-s  {move-type} normal-type
	{move} slide-4-w  {move-type} normal-type
	{move} slide-4-e  {move-type} normal-type
	{move} slide-4-nw {move-type} normal-type
	{move} slide-4-sw {move-type} normal-type
	{move} slide-4-se {move-type} normal-type
	{move} slide-4-ne {move-type} normal-type
moves}

{moves c-moves
	{move} slide-5-n  {move-type} normal-type
	{move} slide-5-s  {move-type} normal-type
	{move} slide-5-w  {move-type} normal-type
	{move} slide-5-e  {move-type} normal-type
	{move} slide-5-nw {move-type} normal-type
	{move} slide-5-sw {move-type} normal-type
	{move} slide-5-se {move-type} normal-type
	{move} slide-5-ne {move-type} normal-type
moves}

{moves s-moves
	{move} step-nw	{move-type} normal-type
	{move} step-ne	{move-type} normal-type
	{move} step-sw	{move-type} normal-type
	{move} step-se	{move-type} normal-type
moves}

{moves b-moves
	{move} step-n	{move-type} normal-type
	{move} step-s	{move-type} normal-type
	{move} step-w	{move-type} normal-type
	{move} step-e	{move-type} normal-type
moves}

{moves p-drops
	{move} Pass	{move-type} pass-type
moves}

{pieces
	{piece}		Z	{moves} g-moves
	{piece}		L	{moves} l-moves {drops} p-drops
	{piece}		G	{moves} g-moves 10 {value}
	{piece}		D	{moves} d-moves
	{piece}		O	{moves} o-moves
	{piece}		P	{moves} p-moves
	{piece}		H	{moves} h-moves
	{piece}		A	{moves} a-moves
	{piece}		C	{moves} c-moves 
	{piece}		S	{moves} s-moves
	{piece}		B	{moves} b-moves
pieces}

' G IS General
