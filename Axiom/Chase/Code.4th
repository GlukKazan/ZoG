: step ( 'dir -- )
	EXECUTE verify
	empty? verify
	from here move
	add-move
;

: step-nw ( -- ) ['] nw step ;
: step-sw ( -- ) ['] sw step ;
: step-ne ( -- ) ['] ne step ;
: step-se ( -- ) ['] se step ;
: step-w  ( -- ) ['] w  step ;
: step-e  ( -- ) ['] e  step ;
