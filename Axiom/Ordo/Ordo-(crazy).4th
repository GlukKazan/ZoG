LOAD	Common.4th

: slide-n	( -- ) ['] n slide ;
: slide-s	( -- ) ['] s slide ;
: slide-e	( -- ) ['] e slide ;
: slide-w	( -- ) ['] w slide ;

: slide-nw	( -- ) ['] nw slide ;
: slide-sw	( -- ) ['] sw slide ;
: slide-ne	( -- ) ['] ne slide ;
: slide-se	( -- ) ['] se slide ;

: ordo-en	( -- ) ['] e ['] n ordo ;
: ordo-se	( -- ) ['] s ['] e ordo ;
: ordo-sw	( -- ) ['] s ['] w ordo ;
: ordo-es	( -- ) ['] e ['] s ordo ;
: ordo-sn	( -- ) ['] s ['] n ordo ;
: ordo-ew	( -- ) ['] e ['] w ordo ;
: ordo-we	( -- ) ['] w ['] e ordo ;
: ordo-ns	( -- ) ['] n ['] s ordo ;

: ordo-snw	( -- ) ['] s ['] nw ordo ;
: ordo-sne	( -- ) ['] s ['] ne ordo ;
: ordo-ssw	( -- ) ['] s ['] sw ordo ;
: ordo-sse	( -- ) ['] s ['] se ordo ;

: ordo-enw	( -- ) ['] e ['] nw ordo ;
: ordo-ene	( -- ) ['] e ['] ne ordo ;
: ordo-esw	( -- ) ['] e ['] sw ordo ;
: ordo-ese	( -- ) ['] e ['] se ordo ;

: ordo-swne	( -- ) ['] sw ['] ne ordo ;
: ordo-senw	( -- ) ['] se ['] nw ordo ;
: ordo-nwse	( -- ) ['] nw ['] se ordo ;
: ordo-nesw	( -- ) ['] ne ['] sw ordo ;

: ordo-swn	( -- ) ['] sw ['] n ordo ;
: ordo-swe	( -- ) ['] sw ['] e ordo ;
: ordo-sww	( -- ) ['] sw ['] w ordo ;
: ordo-sws	( -- ) ['] sw ['] s ordo ;

: ordo-sen	( -- ) ['] se ['] n ordo ;
: ordo-see	( -- ) ['] se ['] e ordo ;
: ordo-sew	( -- ) ['] se ['] w ordo ;
: ordo-ses	( -- ) ['] se ['] s ordo ;

{moves man-moves
	{move} slide-n	 {move-type} normal-type
	{move} slide-w	 {move-type} normal-type
	{move} slide-e	 {move-type} normal-type
	{move} slide-nw	 {move-type} normal-type
	{move} slide-ne	 {move-type} normal-type
	{move} slide-s	 {move-type} repair-type
	{move} slide-sw	 {move-type} repair-type
	{move} slide-se	 {move-type} repair-type
	{move} ordo-en	 {move-type} normal-type
	{move} ordo-se	 {move-type} normal-type
	{move} ordo-sw	 {move-type} normal-type
	{move} ordo-es	 {move-type} repair-type
	{move} ordo-sn	 {move-type} normal-type
	{move} ordo-ew	 {move-type} normal-type
	{move} ordo-we	 {move-type} normal-type
	{move} ordo-ns	 {move-type} repair-type
	{move} ordo-snw	 {move-type} normal-type
	{move} ordo-sne	 {move-type} normal-type
	{move} ordo-ssw	 {move-type} repair-type
	{move} ordo-sse	 {move-type} repair-type
	{move} ordo-enw	 {move-type} normal-type
	{move} ordo-ene	 {move-type} normal-type
	{move} ordo-esw	 {move-type} repair-type
	{move} ordo-ese	 {move-type} repair-type
	{move} ordo-swne {move-type} normal-type
	{move} ordo-senw {move-type} normal-type
	{move} ordo-nwse {move-type} repair-type
	{move} ordo-nesw {move-type} repair-type
	{move} ordo-swn	 {move-type} normal-type
	{move} ordo-swe	 {move-type} normal-type
	{move} ordo-sww	 {move-type} normal-type
	{move} ordo-sws	 {move-type} repair-type
	{move} ordo-sen	 {move-type} normal-type
	{move} ordo-see	 {move-type} normal-type
	{move} ordo-sew	 {move-type} normal-type
	{move} ordo-ses	 {move-type} repair-type
moves}


{move-priorities
	{move-priority} normal-type
	{move-priority} repair-type
move-priorities}

{pieces
	{piece}		Man		{moves} man-moves
pieces}

' Man	IS MAN

LOAD	AI.4th
