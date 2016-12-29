(define slide-Y (
   $1
   (while empty?
      add
      $1
   )
   (if (piece? T)
      (add y)
   )
))

(define slide-y (
   (create T)
   $1
   (verify (or empty? (piece? T)))
   (if (piece? T)
      add
    else
      (add Y)
   )
))

(define push-Y (
   $1
   (verify (or (piece? B) (piece? b)))
   cascade
   (if (piece? b)
       (create y)
   )
   $1
   (verify (or empty? (piece? T)))
   (if empty?
       add
    else
       (add b)
   )
))

(define push-y (
   (create T)
   $1
   (verify (or (piece? B) (piece? b)))
   cascade
   (if (piece? b)
       (create y)
   )
   $1
   (verify (or empty? (piece? T)))
   (if empty?
       add
    else
       (add b)
   )
))

(define common-grid
   (start-rectangle 0 0 24 24)
   (directions (n 0 -1) (s 0 1) (w -1 0) (e 1 0) )
)

(define common-level
   (move-sound "Audio/Pickup.wav")
   (release-sound "Audio/Pickup.wav")
   (capture-sound "")

   (option "progressive levels" true)
   (option "prevent flipping" true)
   (option "animate captures" false)

   (players    You)
   (turn-order You)

   (piece
      (name W)
      (image You "../images/sokoban/w.bmp")
   )
   (piece
      (name B)
      (image You "../images/sokoban/b.bmp")
   )
   (piece
      (name b)
      (image You "../images/sokoban/b.bmp")
   )
   (piece
      (name T)
      (image You "../images/sokoban/t.bmp")
   )
   (piece
      (name Y)
      (image You "../images/sokoban/y.bmp")
      (moves
         (slide-Y n) (push-Y n)
         (slide-Y s) (push-Y s)
         (slide-Y w) (push-Y w)
         (slide-Y e) (push-Y e)
      )
   )
   (piece
      (name y)
      (image You "../images/sokoban/g.bmp")
      (moves
         (slide-y n) (push-y n)
         (slide-y s) (push-y s)
         (slide-y w) (push-y w)
         (slide-y e) (push-y e)
      )
   )

   (win-condition (You) (pieces-remaining 0 B) )
)

