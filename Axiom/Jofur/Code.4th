: common-step ( 'dir -- )
	EXECUTE verify
	empty? verify
	from here move
	add-move
;

: step-n  ( -- ) ['] n  common-step ;
: step-e  ( -- ) ['] e  common-step ;
: step-s  ( -- ) ['] s  common-step ;
: step-w  ( -- ) ['] w  common-step ;
