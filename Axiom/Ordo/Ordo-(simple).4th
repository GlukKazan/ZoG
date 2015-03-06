LOAD	Common.4th

: slide-n	( -- ) ['] n slide ;
: slide-s	( -- ) ['] s slide ;
: slide-e	( -- ) ['] e slide ;
: slide-w	( -- ) ['] w slide ;

: slide-nw	( -- ) ['] nw slide ;
: slide-sw	( -- ) ['] sw slide ;
: slide-ne	( -- ) ['] ne slide ;
: slide-se	( -- ) ['] se slide ;

{moves man-moves
	{move} slide-n	{move-type} normal-type
	{move} slide-w	{move-type} normal-type
	{move} slide-e	{move-type} normal-type
	{move} slide-nw	{move-type} normal-type
	{move} slide-ne	{move-type} normal-type
	{move} slide-s	{move-type} repair-type
	{move} slide-sw	{move-type} repair-type
	{move} slide-se	{move-type} repair-type
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
