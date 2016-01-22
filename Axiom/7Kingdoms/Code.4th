DEFER	General

: common-end ( -- )
	friend? NOT verify
	empty? NOT IF
		piece-type General >= verify
	ENDIF
	from here move
	add-move
;

: common-step ( 'dir -- )
	EXECUTE verify
	common-end
;

: step-n  ( -- ) ['] n  common-step ;
: step-e  ( -- ) ['] e  common-step ;
: step-s  ( -- ) ['] s  common-step ;
: step-w  ( -- ) ['] w  common-step ;

: step-nw ( -- ) ['] nw common-step ;
: step-ne ( -- ) ['] ne common-step ;
: step-sw ( -- ) ['] sw common-step ;
: step-se ( -- ) ['] se common-step ;

: common-move ( 'dir -- )
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

: move-n  ( -- ) ['] n  common-move ;
: move-e  ( -- ) ['] e  common-move ;
: move-s  ( -- ) ['] s  common-move ;
: move-w  ( -- ) ['] w  common-move ;

: move-nw ( -- ) ['] nw common-move ;
: move-ne ( -- ) ['] ne common-move ;
: move-sw ( -- ) ['] sw common-move ;
: move-se ( -- ) ['] se common-move ;

: common-slide ( 'dir -- )
	common-move
	common-end
;

: slide-n  ( -- ) ['] n  common-slide ;
: slide-e  ( -- ) ['] e  common-slide ;
: slide-s  ( -- ) ['] s  common-slide ;
: slide-w  ( -- ) ['] w  common-slide ;

: slide-nw ( -- ) ['] nw common-slide ;
: slide-ne ( -- ) ['] ne common-slide ;
: slide-sw ( -- ) ['] sw common-slide ;
: slide-se ( -- ) ['] se common-slide ;

: common-shoot ( 'dir -- )
	DUP
	common-move
	empty? NOT  verify
	DUP EXECUTE verify
	friend? NOT verify
	empty? IF
		BEGIN
			DUP EXECUTE empty? AND NOT 
		UNTIL DROP
	ENDIF
	common-end
;

: shoot-n  ( -- ) ['] n  common-shoot ;
: shoot-e  ( -- ) ['] e  common-shoot ;
: shoot-s  ( -- ) ['] s  common-shoot ;
: shoot-w  ( -- ) ['] w  common-shoot ;

: common-jump ( 'dir 'dir -- )
	EXECUTE verify
	empty?  verify
	EXECUTE verify
	common-end
;

: jump-nnw ( -- ) ['] nw ['] n common-jump ;
: jump-nne ( -- ) ['] ne ['] n common-jump ;
: jump-ssw ( -- ) ['] sw ['] s common-jump ;
: jump-sse ( -- ) ['] se ['] s common-jump ;
: jump-wws ( -- ) ['] sw ['] w common-jump ;
: jump-wwn ( -- ) ['] nw ['] w common-jump ;
: jump-ees ( -- ) ['] se ['] e common-jump ;
: jump-een ( -- ) ['] ne ['] e common-jump ;

: common-range ( 'dir n -- )
	BEGIN
		OVER EXECUTE empty? AND IF
			from here move
			add-move
			1- DUP 0=
		ELSE
			TRUE
		ENDIF
	UNTIL 0> verify DROP
	common-end
;

: slide-4-n  ( -- ) ['] n  4 common-range ;
: slide-4-s  ( -- ) ['] s  4 common-range ;
: slide-4-w  ( -- ) ['] w  4 common-range ;
: slide-4-e  ( -- ) ['] e  4 common-range ;

: slide-4-nw ( -- ) ['] nw 4 common-range ;
: slide-4-sw ( -- ) ['] sw 4 common-range ;
: slide-4-ne ( -- ) ['] ne 4 common-range ;
: slide-4-se ( -- ) ['] se 4 common-range ;

: slide-5-n  ( -- ) ['] n  5 common-range ;
: slide-5-s  ( -- ) ['] s  5 common-range ;
: slide-5-w  ( -- ) ['] w  5 common-range ;
: slide-5-e  ( -- ) ['] e  5 common-range ;

: slide-5-nw ( -- ) ['] nw 5 common-range ;
: slide-5-sw ( -- ) ['] sw 5 common-range ;
: slide-5-ne ( -- ) ['] ne 5 common-range ;
: slide-5-se ( -- ) ['] se 5 common-range ;
