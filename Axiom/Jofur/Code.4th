DEFER	 mark

VARIABLE not-smelled
VARIABLE is-enemy?
VARIABLE is-friend?
VARIABLE is-smelled?
6 []	 part[]

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
	FALSE is-smelled? !
	EXECUTE from here <> AND empty? NOT AND IF
		piece piece-value
		DUP 7 MOD get-enemy
		7 / DUP 7 MOD DUP get-enemy
		2 = IF
			TRUE is-smelled? !
		ENDIF
		7 / get-enemy
	ENDIF
	is-enemy? @ is-smelled? @ AND NOT verify
;

: check-smelled ( -- )
	not-smelled @ IF
		here   ['] n  check-smelled-dir
		DUP to ['] s  check-smelled-dir
		DUP to ['] e  check-smelled-dir
		DUP to ['] w  check-smelled-dir
		DUP to ['] nw check-smelled-dir
		DUP to ['] ne check-smelled-dir
		DUP to ['] sw check-smelled-dir
		DUP to ['] se check-smelled-dir
		to
	ENDIF
;

: common-step ( 'dir -- )
	check-friend
	is-friend? @ verify
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
	is-friend? @ verify
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
	is-friend? @ verify
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
	is-friend? @ verify
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

: parse ( n -- )
	empty? IF
		0
	ELSE
		piece piece-value
	ENDIF
	OVER OVER 7 MOD SWAP part[] ! 7 / SWAP 1+ SWAP
	OVER OVER 7 MOD SWAP part[] ! 7 / SWAP 1+ SWAP
	SWAP part[] !
;

: assemble ( n -- n )
	0 OVER part[] @ + SWAP 1+ SWAP
	OVER part[] @ 7 * + SWAP 1+ SWAP
	SWAP part[] @ 49 * +
;

: n-to-piece ( n -- piece-type )
	113
	OVER 324 <= IF 2  - ENDIF
	OVER 317 <= IF 2  - ENDIF
	OVER 275 <= IF 2  - ENDIF
	OVER 268 <= IF 2  - ENDIF
	OVER 240 <= IF 2  - ENDIF
	OVER 233 <= IF 2  - ENDIF
	OVER 216 <= IF 14 - ENDIF
	OVER 212 <= IF 2  - ENDIF
	OVER 205 <= IF 2  - ENDIF
	OVER 198 <= IF 2  - ENDIF
	OVER 191 <= IF 2  - ENDIF
	OVER 184 <= IF 2  - ENDIF
	OVER 167 <= IF 14 - ENDIF
	OVER 163 <= IF 2  - ENDIF
	OVER 156 <= IF 2  - ENDIF
	OVER 149 <= IF 2  - ENDIF
	OVER 97  <= IF 49 - ENDIF
	OVER 79  <= IF 2  - ENDIF
	OVER 72  <= IF 2  - ENDIF
	OVER 30  <= IF 2  - ENDIF
	OVER 23  <= IF 2  - ENDIF
	- mark +
;

: move-part ( -- )
	2 BEGIN
		DUP 0 >= verify
		DUP 3 + part[] @ 0= verify
		DUP part[] @ 0> IF
			DUP part[] @
			OVER 3 + part[] !
			0 OVER part[] !
			TRUE
		ELSE			
			1- FALSE
		ENDIF
	UNTIL DROP
;

: common-hanoy ( 'dir -- )
	check-friend
	get-smelled
	check-smelled
	0 parse
	EXECUTE verify
	is-friend? @ IF
		empty? NOT verify
	ENDIF
	check-smelled
	3 parse
	move-part
	from here move
	3 assemble n-to-piece ?Owner SWAP create-player-piece-type
	from to 0 assemble DUP 0> IF
		n-to-piece ?Owner SWAP create-player-piece-type
	ELSE
		DROP
	ENDIF
	add-move
;

: hanoy-n  ( -- ) ['] n  common-hanoy ;
: hanoy-e  ( -- ) ['] e  common-hanoy ;
: hanoy-s  ( -- ) ['] s  common-hanoy ;
: hanoy-w  ( -- ) ['] w  common-hanoy ;

: hanoy-nw ( -- ) ['] nw common-hanoy ;
: hanoy-ne ( -- ) ['] ne common-hanoy ;
: hanoy-sw ( -- ) ['] sw common-hanoy ;
: hanoy-se ( -- ) ['] se common-hanoy ;
