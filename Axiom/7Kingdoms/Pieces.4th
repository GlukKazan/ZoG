{moves g-moves
	{move} slide-n
	{move} slide-s
	{move} slide-w
	{move} slide-e
	{move} slide-nw
	{move} slide-sw
	{move} slide-se
	{move} slide-ne
moves}

{moves d-moves
	{move} slide-n
	{move} slide-s
	{move} slide-w
	{move} slide-e
moves}

{moves o-moves
	{move} slide-nw
	{move} slide-sw
	{move} slide-se
	{move} slide-ne
moves}

{moves l-moves
	{move} move-n
	{move} move-s
	{move} move-w
	{move} move-e
	{move} move-nw
	{move} move-sw
	{move} move-se
	{move} move-ne
moves}

{moves p-moves
	{move} shoot-n
	{move} shoot-s
	{move} shoot-w
	{move} shoot-e
moves}

{moves h-moves
	{move} jump-nnw
	{move} jump-nne
	{move} jump-ssw
	{move} jump-sse
	{move} jump-wws
	{move} jump-wwn
	{move} jump-ees
	{move} jump-een
moves}

{moves a-moves
	{move} slide-4-n
	{move} slide-4-s
	{move} slide-4-w
	{move} slide-4-e
	{move} slide-4-nw
	{move} slide-4-sw
	{move} slide-4-se
	{move} slide-4-ne
moves}

{moves c-moves
	{move} slide-5-n
	{move} slide-5-s
	{move} slide-5-w
	{move} slide-5-e
	{move} slide-5-nw
	{move} slide-5-sw
	{move} slide-5-se
	{move} slide-5-ne
moves}

{moves s-moves
	{move} step-nw
	{move} step-ne
	{move} step-sw
	{move} step-se
moves}

{moves b-moves
	{move} step-n
	{move} step-s
	{move} step-w
	{move} step-e
moves}

{pieces
	{piece}		Z	{moves} g-moves
	{piece}		L	{moves} l-moves
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

' G	IS General
