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
: step-nw ( -- ) ['] nw common-step ;
: step-ne ( -- ) ['] ne common-step ;
: step-sw ( -- ) ['] sw common-step ;
: step-se ( -- ) ['] se common-step ;

: common-jump ( 'dir -- )
	DUP EXECUTE verify
	empty? NOT verify
	EXECUTE verify
	empty? verify
	from here move
	add-move
;

: jump-n  ( -- ) ['] n  common-jump ;
: jump-e  ( -- ) ['] e  common-jump ;
: jump-s  ( -- ) ['] s  common-jump ;
: jump-w  ( -- ) ['] w  common-jump ;
: jump-nw ( -- ) ['] nw common-jump ;
: jump-ne ( -- ) ['] ne common-jump ;
: jump-sw ( -- ) ['] sw common-jump ;
: jump-se ( -- ) ['] se common-jump ;

: common-slide ( 'dir -- )
	BEGIN
		DUP EXECUTE empty? AND IF
			from here move
			add-move
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
;

: slide-n  ( -- ) ['] n  common-slide ;
: slide-e  ( -- ) ['] e  common-slide ;
: slide-s  ( -- ) ['] s  common-slide ;
: slide-w  ( -- ) ['] w  common-slide ;

: slide-nw ( -- ) ['] nw common-slide ;
: slide-ne ( -- ) ['] ne common-slide ;
: slide-sw ( -- ) ['] sw common-slide ;
: slide-se ( -- ) ['] se common-slide ;

: common-fly ( 'dir -- )
	BEGIN
		DUP EXECUTE empty? NOT AND IF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	empty? verify
	from here move
	add-move
;

: fly-n  ( -- ) ['] n  common-fly ;
: fly-e  ( -- ) ['] e  common-fly ;
: fly-s  ( -- ) ['] s  common-fly ;
: fly-w  ( -- ) ['] w  common-fly ;

: fly-nw ( -- ) ['] nw common-fly ;
: fly-ne ( -- ) ['] ne common-fly ;
: fly-sw ( -- ) ['] sw common-fly ;
: fly-se ( -- ) ['] se common-fly ;
