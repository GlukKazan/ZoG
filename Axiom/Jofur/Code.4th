$passTurnForced ON

DEFER	 mark

VARIABLE max-val
VARIABLE not-smelled?
VARIABLE not-from?
VARIABLE is-enemy?
VARIABLE is-friend?
VARIABLE is-smelled?
VARIABLE is-locked?
VARIABLE my-here
6 []	 part[]

: my-value ( pos -- value )
	DUP from = IF
		DROP
		0 part[] @
		1 part[] @ 7 * +
		2 part[] @ 49 * +
	ELSE
		DUP my-here @ = IF
			DROP
			3 part[] @
			4 part[] @ 7 * +
			5 part[] @ 49 * +
		ELSE
			DUP empty-at? IF
				DROP 0
			ELSE
				piece-at piece-value
			ENDIF
		ENDIF
	ENDIF
;

: is-player? ( n value -- ? )
	2DUP 7 MOD = IF
		2DROP TRUE
	ELSE
		7 /
		2DUP 7 MOD = IF
			2DROP TRUE
		ELSE
			7 / =
		ENDIF
	ENDIF
;

: check-dir ( 'dir -- )
	EXECUTE IF
		here my-value
		DUP 0> IF
			current-player Light = IF 3 ELSE 4 ENDIF
			OVER is-player? IF
				DUP 7 / 7 MOD 2 = IF
					TRUE is-locked? !
				ENDIF
			ENDIF
		ENDIF DROP
	ENDIF
;

: check-locked ( -- ? )
	TRUE is-locked? !
	here ALL BEGIN
		1-
		DUP my-value
		DUP 0> IF

			FALSE is-locked? ! ( ??? )

			current-player Light = IF 4 ELSE 3 ENDIF
			OVER is-player? IF
				FALSE is-locked? !
				DUP 7 / 7 MOD 2 <> IF
					OVER to ['] n  check-dir
					OVER to ['] s  check-dir
					OVER to ['] w  check-dir
					OVER to ['] e  check-dir
					OVER to ['] nw check-dir
					OVER to ['] sw check-dir
					OVER to ['] ne check-dir
					OVER to ['] se check-dir
				ENDIF
			ENDIF
		ENDIF DROP
		DUP 0= is-locked? @ OR
	UNTIL DROP to
	is-locked? @
;


: calc-rang ( n -- n )
	0 
	OVER 7 MOD 
	DUP 0> IF
		DUP 3 > IF 
			3 - 
		ELSE 
			DROP 1 
		ENDIF +
	ELSE
		DROP
	ENDIF 
	SWAP 7 / SWAP
	OVER 7 MOD 
	DUP 0> IF
		DUP 3 > IF 
			3 - 
		ELSE 
			DROP 1 
		ENDIF +
	ELSE
		DROP
	ENDIF 
	SWAP 7 /
	DUP 0> IF
		DUP 3 > IF 
			3 - 
		ELSE
			DROP 1 
		ENDIF +
	ELSE
		DROP
	ENDIF
;

: calc-pass ( n -- n )
	0 max-val !
	ALL BEGIN
		1-
		DUP empty-at? NOT OVER my-value 0> AND IF
			2DUP my-value 
			is-player? IF
				DUP my-value
				DUP max-val @ > IF
					max-val !
				ELSE
					DROP
				ENDIF
			ENDIF
		ENDIF
		DUP 0=
	UNTIL DROP
	max-val @ calc-rang
;

: check-pass ( -- )
	here my-here !
	current-player Light = IF
		l-pass @ 0= verify
		d-pass @
		DUP 0> IF
			DUP 1- COMPILE-LITERAL
			COMPILE d-pass-set
		ENDIF
		1 <= IF
			4 calc-pass
			check-locked IF
				DROP 0
			ENDIF
			DUP 0> IF
				COMPILE-LITERAL
				COMPILE l-pass-set
				0 COMPILE-LITERAL
				COMPILE d-pass-set
			ELSE
				1 COMPILE-LITERAL
				COMPILE d-pass-set
			ENDIF
		ENDIF
	ELSE
		d-pass @ 0= verify
		l-pass @
		DUP 0> IF
			DUP 1- COMPILE-LITERAL
			COMPILE l-pass-set
		ENDIF
		1 <= IF
			3 calc-pass
			check-locked IF
				DROP 0
			ENDIF
			DUP 0> IF
				COMPILE-LITERAL
				COMPILE d-pass-set
				0 COMPILE-LITERAL
				COMPILE l-pass-set
			ELSE
				1 COMPILE-LITERAL
				COMPILE l-pass-set
			ENDIF
		ENDIF
	ENDIF
;

: get-smelled ( -- )
	TRUE not-from? !
	TRUE not-smelled? !
	piece piece-value ABS
	7 / 7 MOD 2 = IF
		FALSE not-smelled? !
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
	piece piece-value ABS
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
	EXECUTE
	not-from? @ IF
		from here <> AND
	ENDIF
	empty? NOT AND IF
		piece piece-value ABS
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
	not-smelled? @ IF
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

: parse ( n -- )
	empty? IF
		0
	ELSE
		piece piece-value ABS
	ENDIF
	OVER OVER 7 MOD SWAP part[] ! 7 / SWAP 1+ SWAP
	OVER OVER 7 MOD SWAP part[] ! 7 / SWAP 1+ SWAP
	SWAP part[] !
;

: common-step ( 'dir -- )
	FALSE is-friend? !
	check-friend
	is-friend? @ verify
	get-smelled
	check-smelled
	3 parse
	EXECUTE verify
	empty? verify
	check-smelled
	0 parse
	from here move
	check-pass
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
	FALSE is-friend? !
	check-friend
	is-friend? @ verify
	get-smelled
	check-smelled
	3 parse
	DUP EXECUTE verify
	empty? NOT verify
	EXECUTE verify
	empty? verify
	check-smelled
	0 parse
	from here move
	check-pass
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
	FALSE is-friend? !
	check-friend
	is-friend? @ verify
	get-smelled
	check-smelled
	3 parse
	BEGIN
		DUP EXECUTE empty? AND IF
			check-smelled
			0 parse
			from here move
			check-pass
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
	FALSE is-friend? !
	check-friend
	is-friend? @ verify
	get-smelled
	check-smelled
	3 parse
	BEGIN
		DUP EXECUTE empty? NOT AND IF
			FALSE
		ELSE
			TRUE
		ENDIF
	UNTIL DROP
	empty? verify
	check-smelled
	0 parse
	from here move
	check-pass
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

: check-correct-part ( ? n n -- ? )
	part[] @ = IF
		verify
		FALSE
	ENDIF
;

: check-correct ( -- )
	TRUE
	3 3 check-correct-part
	3 4 check-correct-part
	3 5 check-correct-part
	4 3 check-correct-part
	4 4 check-correct-part
	4 5 check-correct-part
	DROP
;

: check-friend-dir ( 'dir -- )
	here SWAP EXECUTE IF
		check-friend
	ENDIF to
;

: check-friend-neigbor ( -- )
	FALSE is-friend? !
	check-friend
	['] n  check-friend-dir
	['] s  check-friend-dir
	['] w  check-friend-dir
	['] e  check-friend-dir
	['] nw check-friend-dir
	['] sw check-friend-dir
	['] ne check-friend-dir
	['] se check-friend-dir
	is-friend? @ verify
;

: common-hanoy ( ? 'dir -- )
	check-friend-neigbor
	TRUE not-smelled? !
	FALSE not-from? !
	check-smelled
	0 parse
	EXECUTE verify
	IF empty? NOT verify ENDIF
	check-friend-neigbor
	check-smelled
	3 parse
	move-part
	check-correct
	from here move
	check-pass
	3 assemble n-to-piece ?Owner SWAP create-player-piece-type
	from to 0 assemble DUP 0> IF
		n-to-piece ?Owner SWAP create-player-piece-type
	ELSE
		DROP
	ENDIF
	add-move
;

: hanoy-wc-n  ( -- ) TRUE ['] n  common-hanoy ;
: hanoy-wc-e  ( -- ) TRUE ['] e  common-hanoy ;
: hanoy-wc-s  ( -- ) TRUE ['] s  common-hanoy ;
: hanoy-wc-w  ( -- ) TRUE ['] w  common-hanoy ;

: hanoy-wc-nw ( -- ) TRUE ['] nw common-hanoy ;
: hanoy-wc-ne ( -- ) TRUE ['] ne common-hanoy ;
: hanoy-wc-sw ( -- ) TRUE ['] sw common-hanoy ;
: hanoy-wc-se ( -- ) TRUE ['] se common-hanoy ;

: hanoy-nc-n  ( -- ) FALSE ['] n  common-hanoy ;
: hanoy-nc-e  ( -- ) FALSE ['] e  common-hanoy ;
: hanoy-nc-s  ( -- ) FALSE ['] s  common-hanoy ;
: hanoy-nc-w  ( -- ) FALSE ['] w  common-hanoy ;

: hanoy-nc-nw ( -- ) FALSE ['] nw common-hanoy ;
: hanoy-nc-ne ( -- ) FALSE ['] ne common-hanoy ;
: hanoy-nc-sw ( -- ) FALSE ['] sw common-hanoy ;
: hanoy-nc-se ( -- ) FALSE ['] se common-hanoy ;

: drop-piece ( n -- )
	BEGIN
		0 ALL 1- RAND-WITHIN
		DUP empty-at? OVER here <> AND IF
			OVER mark SWAP -
			OVER create-piece-type-at
		ENDIF
	UNTIL DROP
;

: common-drop ( n n n n -- )
	empty? verify
	drop
	drop-piece
	drop-piece
	drop-piece
	drop-piece
	add-move
;

: drop-mode-1 ( -- ) 10 10 9 8 common-drop ;
: drop-mode-2 ( -- ) 10 11 9 8 common-drop ;
: drop-mode-3 ( -- ) 7  7  5 4 common-drop ;
: drop-mode-4 ( -- ) 11 6  5 5 common-drop ;
: drop-mode-5 ( -- ) 3  2  2 1 common-drop ;
: drop-mode-6 ( -- ) 2  2  2 1 common-drop ;
