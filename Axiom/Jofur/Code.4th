VARIABLE not-smelled
VARIABLE is-enemy?
VARIABLE is-friend?
VARIABLE is-smelled?

: get-smelled ( -- )
	TRUE not-smelled !
	piece piece-value
	7 / 7 MOD 2 = IF
		FALSE not-smelled !
	ENDIF
;

: get-friend ( n -- )
	current-player Light = IF
		3 = IF
			TRUE is-friend? !
		ENDIF
	ELSE
		4 = IF
			TRUE is-friend? !
		ENDIF
	ENDIF
;

: check-friend ( -- )
	FALSE is-friend? !
	piece piece-value
	DUP 7 MOD get-friend
	7 / DUP 7 MOD get-friend
	7 / get-friend
	is-friend? @ verify
;

: get-enemy ( n -- )
	current-player Dark = IF
		3 = IF
			TRUE is-enemy? !
		ENDIF
	ELSE
		4 = IF
			TRUE is-enemy? !
		ENDIF
	ENDIF
;

: check-smelled-dir ( 'dir -- )
	FALSE is-enemy? !
	EXECUTE from here <> AND empty? NOT AND IF
		piece piece-value
		DUP 7 MOD DUP get-enemy get-friend
		7 / DUP 7 MOD DUP DUP get-enemy get-friend
		SWAP 7 / DUP get-enemy get-friend
		2 = is-enemy? @ AND IF
			TRUE is-smelled? !
		ENDIF
	ENDIF
;

: check-smelled ( -- )
	not-smelled @ IF
		FALSE is-friend? !
		FALSE is-smelled? !
		here   ['] n  check-smelled-dir
		DUP to ['] s  check-smelled-dir
		DUP to ['] e  check-smelled-dir
		DUP to ['] w  check-smelled-dir
		DUP to ['] nw check-smelled-dir
		DUP to ['] ne check-smelled-dir
		DUP to ['] sw check-smelled-dir
		DUP to ['] se check-smelled-dir
		to is-smelled? @ NOT is-friend? @ OR verify
	ENDIF
;

: common-step ( 'dir -- )
	check-friend
	get-smelled
	check-smelled
	EXECUTE verify
	empty? verify
	check-smelled
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
	check-friend
	get-smelled
	check-smelled
	DUP EXECUTE verify
	empty? NOT verify
	EXECUTE verify
	empty? verify
	check-smelled
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
	check-friend
	get-smelled
	check-smelled
	BEGIN
		DUP EXECUTE empty? AND IF
			check-smelled
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
	check-friend
	get-smelled
	check-smelled
	BEGIN
		DUP EXECUTE empty? NOT AND IF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	empty? verify
	check-smelled
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
