LOAD board.4th

: slide-1-n  ( -- ) ['] North     1 slide ;
: slide-1-s  ( -- ) ['] South     1 slide ;
: slide-1-e  ( -- ) ['] East      1 slide ;
: slide-1-w  ( -- ) ['] West      1 slide ;
: slide-1-ne ( -- ) ['] Northeast 1 slide ;
: slide-1-se ( -- ) ['] Southeast 1 slide ;
: slide-1-nw ( -- ) ['] Northwest 1 slide ;
: slide-1-sw ( -- ) ['] Southwest 1 slide ;

: slide-3-n  ( -- ) ['] North     3 slide ;
: slide-3-s  ( -- ) ['] South     3 slide ;
: slide-3-e  ( -- ) ['] East      3 slide ;
: slide-3-w  ( -- ) ['] West      3 slide ;
: slide-3-ne ( -- ) ['] Northeast 3 slide ;
: slide-3-se ( -- ) ['] Southeast 3 slide ;
: slide-3-nw ( -- ) ['] Northwest 3 slide ;
: slide-3-sw ( -- ) ['] Southwest 3 slide ;

: r-slide-3-ne ( -- ) ['] Southeast ['] Northwest ['] North ['] East ['] Northeast 3 r-slide ;
: r-slide-3-se ( -- ) ['] Northwest ['] Southwest ['] South ['] East ['] Southeast 3 r-slide ;
: r-slide-3-nw ( -- ) ['] Southwest ['] Northeast ['] North ['] West ['] Northwest 3 r-slide ;
: r-slide-3-sw ( -- ) ['] Northwest ['] Southeast ['] South ['] West ['] Southwest 3 r-slide ;

: slide-b-n  ( -- ) ['] North     ROWS slide ;
: slide-b-s  ( -- ) ['] South     ROWS slide ;
: slide-b-e  ( -- ) ['] East      ROWS slide ;
: slide-b-w  ( -- ) ['] West      ROWS slide ;
: slide-b-ne ( -- ) ['] Northeast ROWS slide ;
: slide-b-se ( -- ) ['] Southeast ROWS slide ;
: slide-b-nw ( -- ) ['] Northwest ROWS slide ;
: slide-b-sw ( -- ) ['] Southwest ROWS slide ;

: r-slide-b-ne ( -- ) ['] Southeast ['] Northwest ['] North ['] East ['] Northeast ROWS r-slide ;
: r-slide-b-se ( -- ) ['] Northwest ['] Southwest ['] South ['] East ['] Southeast ROWS r-slide ;
: r-slide-b-nw ( -- ) ['] Southwest ['] Northeast ['] North ['] West ['] Northwest ROWS r-slide ;
: r-slide-b-sw ( -- ) ['] Northwest ['] Southeast ['] South ['] West ['] Southwest ROWS r-slide ;

: jump-1-nnw ( -- ) ['] North ['] Northwest 1 jump;
: jump-1-nne ( -- ) ['] North ['] Northeast 1 jump;
: jump-1-ene ( -- ) ['] East  ['] Northeast 1 jump;
: jump-1-ese ( -- ) ['] East  ['] Southeast 1 jump;
: jump-1-ssw ( -- ) ['] South ['] Southwest 1 jump;
: jump-1-sse ( -- ) ['] South ['] Southeast 1 jump;
: jump-1-wnw ( -- ) ['] West  ['] Northwest 1 jump;
: jump-1-wsw ( -- ) ['] West  ['] Southwest 1 jump;

: jump-b-nnw ( -- ) ['] North ['] Northwest ROWS jump;
: jump-b-nne ( -- ) ['] North ['] Northeast ROWS jump;
: jump-b-ene ( -- ) ['] East  ['] Northeast ROWS jump;
: jump-b-ese ( -- ) ['] East  ['] Southeast ROWS jump;
: jump-b-ssw ( -- ) ['] South ['] Southwest ROWS jump;
: jump-b-sse ( -- ) ['] South ['] Southeast ROWS jump;
: jump-b-wnw ( -- ) ['] West  ['] Northwest ROWS jump;
: jump-b-wsw ( -- ) ['] West  ['] Southwest ROWS jump;

: a-slide-1-n  ( -- ) ['] North-around     1 slide ;
: a-slide-1-s  ( -- ) ['] South-around     1 slide ;
: a-slide-1-e  ( -- ) ['] East-around      1 slide ;
: a-slide-1-w  ( -- ) ['] West-around      1 slide ;
: a-slide-1-ne ( -- ) ['] Northeast-around 1 slide ;
: a-slide-1-se ( -- ) ['] Southeast-around 1 slide ;
: a-slide-1-nw ( -- ) ['] Northwest-around 1 slide ;
: a-slide-1-sw ( -- ) ['] Southwest-around 1 slide ;

: a-slide-3-n  ( -- ) ['] North-around     3 slide ;
: a-slide-3-s  ( -- ) ['] South-around     3 slide ;
: a-slide-3-e  ( -- ) ['] East-around      3 slide ;
: a-slide-3-w  ( -- ) ['] West-around      3 slide ;
: a-slide-3-ne ( -- ) ['] Northeast-around 3 slide ;
: a-slide-3-se ( -- ) ['] Southeast-around 3 slide ;
: a-slide-3-nw ( -- ) ['] Northwest-around 3 slide ;
: a-slide-3-sw ( -- ) ['] Southwest-around 3 slide ;

: a-jump-1-nnw ( -- ) ['] North-around ['] Northwest-around 1 jump;
: a-jump-1-nne ( -- ) ['] North-around ['] Northeast-around 1 jump;
: a-jump-1-ene ( -- ) ['] East-around  ['] Northeast-around 1 jump;
: a-jump-1-ese ( -- ) ['] East-around  ['] Southeast-around 1 jump;
: a-jump-1-ssw ( -- ) ['] South-around ['] Southwest-around 1 jump;
: a-jump-1-sse ( -- ) ['] South-around ['] Southeast-around 1 jump;
: a-jump-1-wnw ( -- ) ['] West-around  ['] Northwest-around 1 jump;
: a-jump-1-wsw ( -- ) ['] West-around  ['] Southwest-around 1 jump;

: a-jump-b-nnw ( -- ) ['] North-around ['] Northwest-around ROWS jump;
: a-jump-b-nne ( -- ) ['] North-around ['] Northeast-around ROWS jump;
: a-jump-b-ene ( -- ) ['] East-around  ['] Northeast-around ROWS jump;
: a-jump-b-ese ( -- ) ['] East-around  ['] Southeast-around ROWS jump;
: a-jump-b-ssw ( -- ) ['] South-around ['] Southwest-around ROWS jump;
: a-jump-b-sse ( -- ) ['] South-around ['] Southeast-around ROWS jump;
: a-jump-b-wnw ( -- ) ['] West-around  ['] Northwest-around ROWS jump;
: a-jump-b-wsw ( -- ) ['] West-around  ['] Southwest-around ROWS jump;

{moves drops-only
	{move}	drop-piece	{move-type} normal-type
moves}

{moves base-moves
	{move}	drop-piece	{move-type} normal-type
	{move}	Pass		{move-type} pass-type
moves}

{moves mobile-moves
	{move}	slide-1-n	{move-type} normal-type
	{move}	slide-1-s	{move-type} normal-type
	{move}	slide-1-e	{move-type} normal-type
	{move}	slide-1-w	{move-type} normal-type
	{move}	slide-1-ne	{move-type} normal-type
	{move}	slide-1-se	{move-type} normal-type
	{move}	slide-1-nw	{move-type} normal-type
	{move}	slide-1-sw	{move-type} normal-type
	{move}	Pass		{move-type} pass-type
moves}

{moves king-moves
	{move}	slide-1-n	{move-type} normal-type
	{move}	slide-1-s	{move-type} normal-type
	{move}	slide-1-e	{move-type} normal-type
	{move}	slide-1-w	{move-type} normal-type
	{move}	slide-1-ne	{move-type} normal-type
	{move}	slide-1-se	{move-type} normal-type
	{move}	slide-1-nw	{move-type} normal-type
	{move}	slide-1-sw	{move-type} normal-type
moves}

{moves bishop-moves
	{move}	slide-3-ne	{move-type} normal-type
	{move}	slide-3-se	{move-type} normal-type
	{move}	slide-3-nw	{move-type} normal-type
	{move}	slide-3-sw	{move-type} normal-type
moves}

{moves r-bishop-moves
	{move}	r-slide-3-ne	{move-type} normal-type
	{move}	r-slide-3-se	{move-type} normal-type
	{move}	r-slide-3-nw	{move-type} normal-type
	{move}	r-slide-3-sw	{move-type} normal-type
moves}

{moves rook-moves
	{move}	slide-3-n	{move-type} normal-type
	{move}	slide-3-s	{move-type} normal-type
	{move}	slide-3-e	{move-type} normal-type
	{move}	slide-3-w	{move-type} normal-type
moves}

{moves knight-moves
	{move}	jump-1-nnw	{move-type} normal-type
	{move}	jump-1-nne	{move-type} normal-type
	{move}	jump-1-ene	{move-type} normal-type
	{move}	jump-1-ese	{move-type} normal-type
	{move}	jump-1-ssw	{move-type} normal-type
	{move}	jump-1-sse	{move-type} normal-type
	{move}	jump-1-wnw	{move-type} normal-type
	{move}	jump-1-wsw	{move-type} normal-type
moves}

{moves queen-moves
	{move}	slide-3-n	{move-type} normal-type
	{move}	slide-3-s	{move-type} normal-type
	{move}	slide-3-e	{move-type} normal-type
	{move}	slide-3-w	{move-type} normal-type
	{move}	slide-3-ne	{move-type} normal-type
	{move}	slide-3-se	{move-type} normal-type
	{move}	slide-3-nw	{move-type} normal-type
	{move}	slide-3-sw	{move-type} normal-type
moves}

{moves r-queen-moves
	{move}	slide-3-n	{move-type} normal-type
	{move}	slide-3-s	{move-type} normal-type
	{move}	slide-3-e	{move-type} normal-type
	{move}	slide-3-w	{move-type} normal-type
	{move}	r-slide-3-ne	{move-type} normal-type
	{move}	r-slide-3-se	{move-type} normal-type
	{move}	r-slide-3-nw	{move-type} normal-type
	{move}	r-slide-3-sw	{move-type} normal-type
moves}

{moves archbishop-moves
	{move}	slide-3-ne	{move-type} normal-type
	{move}	slide-3-se	{move-type} normal-type
	{move}	slide-3-nw	{move-type} normal-type
	{move}	slide-3-sw	{move-type} normal-type
	{move}	jump-1-nnw	{move-type} normal-type
	{move}	jump-1-nne	{move-type} normal-type
	{move}	jump-1-ene	{move-type} normal-type
	{move}	jump-1-ese	{move-type} normal-type
	{move}	jump-1-ssw	{move-type} normal-type
	{move}	jump-1-sse	{move-type} normal-type
	{move}	jump-1-wnw	{move-type} normal-type
	{move}	jump-1-wsw	{move-type} normal-type
moves}

{moves r-archbishop-moves
	{move}	r-slide-3-ne	{move-type} normal-type
	{move}	r-slide-3-se	{move-type} normal-type
	{move}	r-slide-3-nw	{move-type} normal-type
	{move}	r-slide-3-sw	{move-type} normal-type
	{move}	jump-1-nnw	{move-type} normal-type
	{move}	jump-1-nne	{move-type} normal-type
	{move}	jump-1-ene	{move-type} normal-type
	{move}	jump-1-ese	{move-type} normal-type
	{move}	jump-1-ssw	{move-type} normal-type
	{move}	jump-1-sse	{move-type} normal-type
	{move}	jump-1-wnw	{move-type} normal-type
	{move}	jump-1-wsw	{move-type} normal-type
moves}

{moves cancelor-moves
	{move}	slide-3-n	{move-type} normal-type
	{move}	slide-3-s	{move-type} normal-type
	{move}	slide-3-e	{move-type} normal-type
	{move}	slide-3-w	{move-type} normal-type
	{move}	jump-1-nnw	{move-type} normal-type
	{move}	jump-1-nne	{move-type} normal-type
	{move}	jump-1-ene	{move-type} normal-type
	{move}	jump-1-ese	{move-type} normal-type
	{move}	jump-1-ssw	{move-type} normal-type
	{move}	jump-1-sse	{move-type} normal-type
	{move}	jump-1-wnw	{move-type} normal-type
	{move}	jump-1-wsw	{move-type} normal-type
moves}

{moves amazon-moves
	{move}	slide-3-n	{move-type} normal-type
	{move}	slide-3-s	{move-type} normal-type
	{move}	slide-3-e	{move-type} normal-type
	{move}	slide-3-w	{move-type} normal-type
	{move}	slide-3-ne	{move-type} normal-type
	{move}	slide-3-se	{move-type} normal-type
	{move}	slide-3-nw	{move-type} normal-type
	{move}	slide-3-sw	{move-type} normal-type
	{move}	jump-1-nnw	{move-type} normal-type
	{move}	jump-1-nne	{move-type} normal-type
	{move}	jump-1-ene	{move-type} normal-type
	{move}	jump-1-ese	{move-type} normal-type
	{move}	jump-1-ssw	{move-type} normal-type
	{move}	jump-1-sse	{move-type} normal-type
	{move}	jump-1-wnw	{move-type} normal-type
	{move}	jump-1-wsw	{move-type} normal-type
moves}

{moves r-amazon-moves
	{move}	slide-3-n	{move-type} normal-type
	{move}	slide-3-s	{move-type} normal-type
	{move}	slide-3-e	{move-type} normal-type
	{move}	slide-3-w	{move-type} normal-type
	{move}	r-slide-3-ne	{move-type} normal-type
	{move}	r-slide-3-se	{move-type} normal-type
	{move}	r-slide-3-nw	{move-type} normal-type
	{move}	r-slide-3-sw	{move-type} normal-type
	{move}	jump-1-nnw	{move-type} normal-type
	{move}	jump-1-nne	{move-type} normal-type
	{move}	jump-1-ene	{move-type} normal-type
	{move}	jump-1-ese	{move-type} normal-type
	{move}	jump-1-ssw	{move-type} normal-type
	{move}	jump-1-sse	{move-type} normal-type
	{move}	jump-1-wnw	{move-type} normal-type
	{move}	jump-1-wsw	{move-type} normal-type
moves}

{moves b-bishop-moves
	{move}	slide-b-ne	{move-type} normal-type
	{move}	slide-b-se	{move-type} normal-type
	{move}	slide-b-nw	{move-type} normal-type
	{move}	slide-b-sw	{move-type} normal-type
moves}

{moves rb-bishop-moves
	{move}	r-slide-b-ne	{move-type} normal-type
	{move}	r-slide-b-se	{move-type} normal-type
	{move}	r-slide-b-nw	{move-type} normal-type
	{move}	r-slide-b-sw	{move-type} normal-type
moves}

{moves b-rook-moves
	{move}	slide-b-n	{move-type} normal-type
	{move}	slide-b-s	{move-type} normal-type
	{move}	slide-b-e	{move-type} normal-type
	{move}	slide-b-w	{move-type} normal-type
moves}

{moves b-knight-moves
	{move}	jump-b-nnw	{move-type} normal-type
	{move}	jump-b-nne	{move-type} normal-type
	{move}	jump-b-ene	{move-type} normal-type
	{move}	jump-b-ese	{move-type} normal-type
	{move}	jump-b-ssw	{move-type} normal-type
	{move}	jump-b-sse	{move-type} normal-type
	{move}	jump-b-wnw	{move-type} normal-type
	{move}	jump-b-wsw	{move-type} normal-type
moves}

{moves b-queen-moves
	{move}	slide-b-n	{move-type} normal-type
	{move}	slide-b-s	{move-type} normal-type
	{move}	slide-b-e	{move-type} normal-type
	{move}	slide-b-w	{move-type} normal-type
	{move}	slide-b-ne	{move-type} normal-type
	{move}	slide-b-se	{move-type} normal-type
	{move}	slide-b-nw	{move-type} normal-type
	{move}	slide-b-sw	{move-type} normal-type
moves}

{moves rb-queen-moves
	{move}	slide-b-n	{move-type} normal-type
	{move}	slide-b-s	{move-type} normal-type
	{move}	slide-b-e	{move-type} normal-type
	{move}	slide-b-w	{move-type} normal-type
	{move}	r-slide-b-ne	{move-type} normal-type
	{move}	r-slide-b-se	{move-type} normal-type
	{move}	r-slide-b-nw	{move-type} normal-type
	{move}	r-slide-b-sw	{move-type} normal-type
moves}

{moves b-archbishop-moves
	{move}	slide-b-ne	{move-type} normal-type
	{move}	slide-b-se	{move-type} normal-type
	{move}	slide-b-nw	{move-type} normal-type
	{move}	slide-b-sw	{move-type} normal-type
	{move}	jump-b-nnw	{move-type} normal-type
	{move}	jump-b-nne	{move-type} normal-type
	{move}	jump-b-ene	{move-type} normal-type
	{move}	jump-b-ese	{move-type} normal-type
	{move}	jump-b-ssw	{move-type} normal-type
	{move}	jump-b-sse	{move-type} normal-type
	{move}	jump-b-wnw	{move-type} normal-type
	{move}	jump-b-wsw	{move-type} normal-type
moves}

{moves rb-archbishop-moves
	{move}	r-slide-b-ne	{move-type} normal-type
	{move}	r-slide-b-se	{move-type} normal-type
	{move}	r-slide-b-nw	{move-type} normal-type
	{move}	r-slide-b-sw	{move-type} normal-type
	{move}	jump-b-nnw	{move-type} normal-type
	{move}	jump-b-nne	{move-type} normal-type
	{move}	jump-b-ene	{move-type} normal-type
	{move}	jump-b-ese	{move-type} normal-type
	{move}	jump-b-ssw	{move-type} normal-type
	{move}	jump-b-sse	{move-type} normal-type
	{move}	jump-b-wnw	{move-type} normal-type
	{move}	jump-b-wsw	{move-type} normal-type
moves}

{moves b-cancelor-moves
	{move}	slide-b-n	{move-type} normal-type
	{move}	slide-b-s	{move-type} normal-type
	{move}	slide-b-e	{move-type} normal-type
	{move}	slide-b-w	{move-type} normal-type
	{move}	jump-b-nnw	{move-type} normal-type
	{move}	jump-b-nne	{move-type} normal-type
	{move}	jump-b-ene	{move-type} normal-type
	{move}	jump-b-ese	{move-type} normal-type
	{move}	jump-b-ssw	{move-type} normal-type
	{move}	jump-b-sse	{move-type} normal-type
	{move}	jump-b-wnw	{move-type} normal-type
	{move}	jump-b-wsw	{move-type} normal-type
moves}

{moves b-amazon-moves
	{move}	slide-b-n	{move-type} normal-type
	{move}	slide-b-s	{move-type} normal-type
	{move}	slide-b-e	{move-type} normal-type
	{move}	slide-b-w	{move-type} normal-type
	{move}	slide-b-ne	{move-type} normal-type
	{move}	slide-b-se	{move-type} normal-type
	{move}	slide-b-nw	{move-type} normal-type
	{move}	slide-b-sw	{move-type} normal-type
	{move}	jump-b-nnw	{move-type} normal-type
	{move}	jump-b-nne	{move-type} normal-type
	{move}	jump-b-ene	{move-type} normal-type
	{move}	jump-b-ese	{move-type} normal-type
	{move}	jump-b-ssw	{move-type} normal-type
	{move}	jump-b-sse	{move-type} normal-type
	{move}	jump-b-wnw	{move-type} normal-type
	{move}	jump-b-wsw	{move-type} normal-type
moves}

{moves rb-amazon-moves
	{move}	slide-b-n	{move-type} normal-type
	{move}	slide-b-s	{move-type} normal-type
	{move}	slide-b-e	{move-type} normal-type
	{move}	slide-b-w	{move-type} normal-type
	{move}	r-slide-b-ne	{move-type} normal-type
	{move}	r-slide-b-se	{move-type} normal-type
	{move}	r-slide-b-nw	{move-type} normal-type
	{move}	r-slide-b-sw	{move-type} normal-type
	{move}	jump-b-nnw	{move-type} normal-type
	{move}	jump-b-nne	{move-type} normal-type
	{move}	jump-b-ene	{move-type} normal-type
	{move}	jump-b-ese	{move-type} normal-type
	{move}	jump-b-ssw	{move-type} normal-type
	{move}	jump-b-sse	{move-type} normal-type
	{move}	jump-b-wnw	{move-type} normal-type
	{move}	jump-b-wsw	{move-type} normal-type
moves}

{moves a-king-moves
	{move}	a-slide-1-n	{move-type} normal-type
	{move}	a-slide-1-s	{move-type} normal-type
	{move}	a-slide-1-e	{move-type} normal-type
	{move}	a-slide-1-w	{move-type} normal-type
	{move}	a-slide-1-ne	{move-type} normal-type
	{move}	a-slide-1-se	{move-type} normal-type
	{move}	a-slide-1-nw	{move-type} normal-type
	{move}	a-slide-1-sw	{move-type} normal-type
moves}

{moves a-bishop-moves
	{move}	a-slide-3-ne	{move-type} normal-type
	{move}	a-slide-3-se	{move-type} normal-type
	{move}	a-slide-3-nw	{move-type} normal-type
	{move}	a-slide-3-sw	{move-type} normal-type
moves}

{moves a-rook-moves
	{move}	a-slide-3-n	{move-type} normal-type
	{move}	a-slide-3-s	{move-type} normal-type
	{move}	a-slide-3-e	{move-type} normal-type
	{move}	a-slide-3-w	{move-type} normal-type
moves}

{moves a-knight-moves
	{move}	a-jump-1-nnw	{move-type} normal-type
	{move}	a-jump-1-nne	{move-type} normal-type
	{move}	a-jump-1-ene	{move-type} normal-type
	{move}	a-jump-1-ese	{move-type} normal-type
	{move}	a-jump-1-ssw	{move-type} normal-type
	{move}	a-jump-1-sse	{move-type} normal-type
	{move}	a-jump-1-wnw	{move-type} normal-type
	{move}	a-jump-1-wsw	{move-type} normal-type
moves}

{moves a-queen-moves
	{move}	a-slide-3-n	{move-type} normal-type
	{move}	a-slide-3-s	{move-type} normal-type
	{move}	a-slide-3-e	{move-type} normal-type
	{move}	a-slide-3-w	{move-type} normal-type
	{move}	a-slide-3-ne	{move-type} normal-type
	{move}	a-slide-3-se	{move-type} normal-type
	{move}	a-slide-3-nw	{move-type} normal-type
	{move}	a-slide-3-sw	{move-type} normal-type
moves}

{moves a-archbishop-moves
	{move}	a-slide-3-ne	{move-type} normal-type
	{move}	a-slide-3-se	{move-type} normal-type
	{move}	a-slide-3-nw	{move-type} normal-type
	{move}	a-slide-3-sw	{move-type} normal-type
	{move}	a-jump-1-nnw	{move-type} normal-type
	{move}	a-jump-1-nne	{move-type} normal-type
	{move}	a-jump-1-ene	{move-type} normal-type
	{move}	a-jump-1-ese	{move-type} normal-type
	{move}	a-jump-1-ssw	{move-type} normal-type
	{move}	a-jump-1-sse	{move-type} normal-type
	{move}	a-jump-1-wnw	{move-type} normal-type
	{move}	a-jump-1-wsw	{move-type} normal-type
moves}

{moves a-cancelor-moves
	{move}	a-slide-3-n	{move-type} normal-type
	{move}	a-slide-3-s	{move-type} normal-type
	{move}	a-slide-3-e	{move-type} normal-type
	{move}	a-slide-3-w	{move-type} normal-type
	{move}	a-jump-1-nnw	{move-type} normal-type
	{move}	a-jump-1-nne	{move-type} normal-type
	{move}	a-jump-1-ene	{move-type} normal-type
	{move}	a-jump-1-ese	{move-type} normal-type
	{move}	a-jump-1-ssw	{move-type} normal-type
	{move}	a-jump-1-sse	{move-type} normal-type
	{move}	a-jump-1-wnw	{move-type} normal-type
	{move}	a-jump-1-wsw	{move-type} normal-type
moves}

{moves a-amazon-moves
	{move}	a-slide-3-n	{move-type} normal-type
	{move}	a-slide-3-s	{move-type} normal-type
	{move}	a-slide-3-e	{move-type} normal-type
	{move}	a-slide-3-w	{move-type} normal-type
	{move}	a-slide-3-ne	{move-type} normal-type
	{move}	a-slide-3-se	{move-type} normal-type
	{move}	a-slide-3-nw	{move-type} normal-type
	{move}	a-slide-3-sw	{move-type} normal-type
	{move}	a-jump-1-nnw	{move-type} normal-type
	{move}	a-jump-1-nne	{move-type} normal-type
	{move}	a-jump-1-ene	{move-type} normal-type
	{move}	a-jump-1-ese	{move-type} normal-type
	{move}	a-jump-1-ssw	{move-type} normal-type
	{move}	a-jump-1-sse	{move-type} normal-type
	{move}	a-jump-1-wnw	{move-type} normal-type
	{move}	a-jump-1-wsw	{move-type} normal-type
moves}

{moves ab-bishop-moves
	{move}	a-slide-b-ne	{move-type} normal-type
	{move}	a-slide-b-se	{move-type} normal-type
	{move}	a-slide-b-nw	{move-type} normal-type
	{move}	a-slide-b-sw	{move-type} normal-type
moves}

{moves ab-rook-moves
	{move}	a-slide-b-n	{move-type} normal-type
	{move}	a-slide-b-s	{move-type} normal-type
	{move}	a-slide-b-e	{move-type} normal-type
	{move}	a-slide-b-w	{move-type} normal-type
moves}

{moves ab-knight-moves
	{move}	a-jump-b-nnw	{move-type} normal-type
	{move}	a-jump-b-nne	{move-type} normal-type
	{move}	a-jump-b-ene	{move-type} normal-type
	{move}	a-jump-b-ese	{move-type} normal-type
	{move}	a-jump-b-ssw	{move-type} normal-type
	{move}	a-jump-b-sse	{move-type} normal-type
	{move}	a-jump-b-wnw	{move-type} normal-type
	{move}	a-jump-b-wsw	{move-type} normal-type
moves}

{moves ab-queen-moves
	{move}	a-slide-b-n	{move-type} normal-type
	{move}	a-slide-b-s	{move-type} normal-type
	{move}	a-slide-b-e	{move-type} normal-type
	{move}	a-slide-b-w	{move-type} normal-type
	{move}	a-slide-b-ne	{move-type} normal-type
	{move}	a-slide-b-se	{move-type} normal-type
	{move}	a-slide-b-nw	{move-type} normal-type
	{move}	a-slide-b-sw	{move-type} normal-type
moves}

{moves ab-archbishop-moves
	{move}	a-slide-b-ne	{move-type} normal-type
	{move}	a-slide-b-se	{move-type} normal-type
	{move}	a-slide-b-nw	{move-type} normal-type
	{move}	a-slide-b-sw	{move-type} normal-type
	{move}	a-jump-b-nnw	{move-type} normal-type
	{move}	a-jump-b-nne	{move-type} normal-type
	{move}	a-jump-b-ene	{move-type} normal-type
	{move}	a-jump-b-ese	{move-type} normal-type
	{move}	a-jump-b-ssw	{move-type} normal-type
	{move}	a-jump-b-sse	{move-type} normal-type
	{move}	a-jump-b-wnw	{move-type} normal-type
	{move}	a-jump-b-wsw	{move-type} normal-type
moves}

{moves ab-cancelor-moves
	{move}	a-slide-b-n	{move-type} normal-type
	{move}	a-slide-b-s	{move-type} normal-type
	{move}	a-slide-b-e	{move-type} normal-type
	{move}	a-slide-b-w	{move-type} normal-type
	{move}	a-jump-b-nnw	{move-type} normal-type
	{move}	a-jump-b-nne	{move-type} normal-type
	{move}	a-jump-b-ene	{move-type} normal-type
	{move}	a-jump-b-ese	{move-type} normal-type
	{move}	a-jump-b-ssw	{move-type} normal-type
	{move}	a-jump-b-sse	{move-type} normal-type
	{move}	a-jump-b-wnw	{move-type} normal-type
	{move}	a-jump-b-wsw	{move-type} normal-type
moves}

{moves ab-amazon-moves
	{move}	a-slide-b-n	{move-type} normal-type
	{move}	a-slide-b-s	{move-type} normal-type
	{move}	a-slide-b-e	{move-type} normal-type
	{move}	a-slide-b-w	{move-type} normal-type
	{move}	a-slide-b-ne	{move-type} normal-type
	{move}	a-slide-b-se	{move-type} normal-type
	{move}	a-slide-b-nw	{move-type} normal-type
	{move}	a-slide-b-sw	{move-type} normal-type
	{move}	a-jump-b-nnw	{move-type} normal-type
	{move}	a-jump-b-nne	{move-type} normal-type
	{move}	a-jump-b-ene	{move-type} normal-type
	{move}	a-jump-b-ese	{move-type} normal-type
	{move}	a-jump-b-ssw	{move-type} normal-type
	{move}	a-jump-b-sse	{move-type} normal-type
	{move}	a-jump-b-wnw	{move-type} normal-type
	{move}	a-jump-b-wsw	{move-type} normal-type
moves}

{move-priorities
	{move-priority} normal-type
	{move-priority} pass-type
move-priorities}

{pieces
	{piece}	B		{moves} bishop-moves
	{piece}	R		{moves} rook-moves
	{piece}	K		{moves} knight-moves
	{piece}	BR		{moves} queen-moves
	{piece}	BK		{moves} archbishop-moves
	{piece}	RK		{moves} cancelor-moves
	{piece}	BRK		{moves} amazon-moves

	{piece}	bB		{moves} b-bishop-moves
	{piece}	bR		{moves} b-rook-moves
	{piece}	bK		{moves} b-knight-moves
	{piece}	bBR		{moves} b-queen-moves
	{piece}	bBK		{moves} b-archbishop-moves
	{piece}	bRK		{moves} b-cancelor-moves
	{piece}	bBRK		{moves} b-amazon-moves

	{piece}	wB		{moves} king-moves
	{piece}	wR		{moves} king-moves
	{piece}	wK		{moves} king-moves
	{piece}	wBR		{moves} king-moves
	{piece}	wBK		{moves} king-moves
	{piece}	wRK		{moves} king-moves
	{piece}	wBRK		{moves} king-moves

	{piece}	zB
	{piece}	zR
	{piece}	zK
	{piece}	zBR
	{piece}	zBK
	{piece}	zRK
	{piece}	zBRK

	{piece}	rB		{moves} r-bishop-moves
	{piece}	rR		{moves} rook-moves
	{piece}	rK		{moves} knight-moves
	{piece}	rBR		{moves} r-queen-moves
	{piece}	rBK		{moves} r-archbishop-moves
	{piece}	rRK		{moves} cancelor-moves
	{piece}	rBRK		{moves} r-amazon-moves

	{piece}	rbB		{moves} rb-bishop-moves
	{piece}	rbR		{moves} b-rook-moves
	{piece}	rbK		{moves} b-knight-moves
	{piece}	rbBR		{moves} rb-queen-moves
	{piece}	rbBK		{moves} rb-archbishop-moves
	{piece}	rbRK		{moves} b-cancelor-moves
	{piece}	rbBRK		{moves} rb-amazon-moves

	{piece}	rwB		{moves} king-moves
	{piece}	rwR		{moves} king-moves
	{piece}	rwK		{moves} king-moves
	{piece}	rwBR		{moves} king-moves
	{piece}	rwBK		{moves} king-moves
	{piece}	rwRK		{moves} king-moves
	{piece}	rwBRK		{moves} king-moves

	{piece}	rzB
	{piece}	rzR
	{piece}	rzK
	{piece}	rzBR
	{piece}	rzBK
	{piece}	rzRK
	{piece}	rzBRK

	{piece}	aB		{moves} a-bishop-moves
	{piece}	aR		{moves} a-rook-moves
	{piece}	aK		{moves} a-knight-moves
	{piece}	aBR		{moves} a-queen-moves
	{piece}	aBK		{moves} a-archbishop-moves
	{piece}	aRK		{moves} a-cancelor-moves
	{piece}	aBRK		{moves} a-amazon-moves

	{piece}	abB		{moves} ab-bishop-moves
	{piece}	abR		{moves} ab-rook-moves
	{piece}	abK		{moves} ab-knight-moves
	{piece}	abBR		{moves} ab-queen-moves
	{piece}	abBK		{moves} ab-archbishop-moves
	{piece}	abRK		{moves} ab-cancelor-moves
	{piece}	abBRK		{moves} ab-amazon-moves

	{piece}	awB		{moves} a-king-moves
	{piece}	awR		{moves} a-king-moves
	{piece}	awK		{moves} a-king-moves
	{piece}	awBR		{moves} a-king-moves
	{piece}	awBK		{moves} a-king-moves
	{piece}	awRK		{moves} a-king-moves
	{piece}	awBRK		{moves} a-king-moves

	{piece}	azB
	{piece}	azR
	{piece}	azK
	{piece}	azBR
	{piece}	azBK
	{piece}	azRK
	{piece}	azBRK

	{piece}	W		{moves} drops-only
	{piece}	S		{moves} drops-only
	{piece}	X		{moves} drops-only
	{piece}	WX
	{piece}	SX

	{piece}	fB		{moves} bishop-moves
	{piece}	fR		{moves} rook-moves
	{piece}	fK		{moves} knight-moves
	{piece}	fBR		{moves} queen-moves
	{piece}	fBK		{moves} archbishop-moves
	{piece}	fRK		{moves} cancelor-moves
	{piece}	fBRK		{moves} amazon-moves

	{piece}	fbB		{moves} b-bishop-moves
	{piece}	fbR		{moves} b-rook-moves
	{piece}	fbK		{moves} b-knight-moves
	{piece}	fbBR		{moves} b-queen-moves
	{piece}	fbBK		{moves} b-archbishop-moves
	{piece}	fbRK		{moves} b-cancelor-moves
	{piece}	fbBRK		{moves} b-amazon-moves

	{piece}	fwB		{moves} king-moves
	{piece}	fwR		{moves} king-moves
	{piece}	fwK		{moves} king-moves
	{piece}	fwBR		{moves} king-moves
	{piece}	fwBK		{moves} king-moves
	{piece}	fwRK		{moves} king-moves
	{piece}	fwBRK		{moves} king-moves

	{piece}	fzB
	{piece}	fzR
	{piece}	fzK
	{piece}	fzBR
	{piece}	fzBK
	{piece}	fzRK
	{piece}	fzBRK

	{piece}	frB		{moves} r-bishop-moves
	{piece}	frR		{moves} rook-moves
	{piece}	frK		{moves} knight-moves
	{piece}	frBR		{moves} r-queen-moves
	{piece}	frBK		{moves} r-archbishop-moves
	{piece}	frRK		{moves} cancelor-moves
	{piece}	frBRK		{moves} r-amazon-moves

	{piece}	frbB		{moves} rb-bishop-moves
	{piece}	frbR		{moves} b-rook-moves
	{piece}	frbK		{moves} b-knight-moves
	{piece}	frbBR		{moves} rb-queen-moves
	{piece}	frbBK		{moves} rb-archbishop-moves
	{piece}	frbRK		{moves} b-cancelor-moves
	{piece}	frbBRK		{moves} rb-amazon-moves

	{piece}	frwB		{moves} king-moves
	{piece}	frwR		{moves} king-moves
	{piece}	frwK		{moves} king-moves
	{piece}	frwBR		{moves} king-moves
	{piece}	frwBK		{moves} king-moves
	{piece}	frwRK		{moves} king-moves
	{piece}	frwBRK		{moves} king-moves

	{piece}	frzB
	{piece}	frzR
	{piece}	frzK
	{piece}	frzBR
	{piece}	frzBK
	{piece}	frzRK
	{piece}	frzBRK

	{piece}	faB		{moves} a-bishop-moves
	{piece}	faR		{moves} a-rook-moves
	{piece}	faK		{moves} a-knight-moves
	{piece}	faBR		{moves} a-queen-moves
	{piece}	faBK		{moves} a-archbishop-moves
	{piece}	faRK		{moves} a-cancelor-moves
	{piece}	faBRK		{moves} a-amazon-moves

	{piece}	fabB		{moves} ab-bishop-moves
	{piece}	fabR		{moves} ab-rook-moves
	{piece}	fabK		{moves} ab-knight-moves
	{piece}	fabBR		{moves} ab-queen-moves
	{piece}	fabBK		{moves} ab-archbishop-moves
	{piece}	fabRK		{moves} ab-cancelor-moves
	{piece}	fabBRK		{moves} ab-amazon-moves

	{piece}	fawB		{moves} a-king-moves
	{piece}	fawR		{moves} a-king-moves
	{piece}	fawK		{moves} a-king-moves
	{piece}	fawBR		{moves} a-king-moves
	{piece}	fawBK		{moves} a-king-moves
	{piece}	fawRK		{moves} a-king-moves
	{piece}	fawBRK		{moves} a-king-moves

	{piece}	fazB
	{piece}	fazR
	{piece}	fazK
	{piece}	fazBR
	{piece}	fazBK
	{piece}	fazRK
	{piece}	fazBRK

	{piece}	fW		{moves} drops-only
	{piece}	fS		{moves} drops-only

	{piece}	Base		{moves} base-moves
	{piece}	Mobile		{moves} mobile-moves
	{piece}	Clear		{moves} drops-only
	{piece}	Boost		{moves} drops-only
	{piece}	Weak		{moves} drops-only
	{piece}	Freeze		{moves} drops-only
	{piece}	Kill		{moves} drops-only
	{piece}	Ricochet	{moves} drops-only
	{piece}	Around		{moves} drops-only
	{piece}	MassClear	{moves} drops-only
	{piece}	MassBoost	{moves} drops-only
	{piece}	MassWeak	{moves} drops-only
	{piece}	MassFreeze	{moves} drops-only
	{piece}	Fix		{moves} drops-only
pieces}
