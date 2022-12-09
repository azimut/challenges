(ql:quickload '(#:defpackage-plus #:alexandria #:str #:serapeum #:rtg-math))

(defpackage+-1:defpackage+ #:aoc2022-day9
  (:use #:cl #:rtg-math)
  (:export #:main)
  (:import-from #:serapeum #:->)
  (:local-nicknames (#:a #:alexandria)
                    (#:s #:serapeum)
                    (#:u #:uiop)
                    (#:re #:cl-ppcre)))

(in-package #:aoc2022-day9)

#+nil
(progn
  rope bridge
  gorge
  river
  ROPE PHYSICS
  rope has a knot at each end, mark the HEAD and the TAIL
  rope is pulled in one goes far away from the other

  INPUT = series of motions for the HEAD, you can determine where the TAIL will move

  rope HEAD and TAIL must be ALWAYS touching, diagonally or adjacent or overlapping
  if the TAIL is away in X direction of the HEAD
  - the TAIL will move i position in that direction
  - if the TAIL is not even on the same col/row it will move diagonally to the HEAD
  - which is 1 horizontal and 1 vertical move
  - HEAD and TAIL start the same position overlapping

  Part 2
  - rope of 10 (ten) knots
  - 1 is the HEAD
  - each other (9) knot follows the knot in front according to how we were doint it
  - tail is the nine knot that is not the head

  PART 1 OUTPUT = count the N of positions the TAIL visited at least once, counting STARTING position
  PART 1 = 13 = 5858

  PART 2 OUTPUT = same as 1
  (larger example provided)
  PART 2 = 36

  NOT 2598 too low
  )

(-> motions () list)
(defun motions (&aux motions)
  (flet ((f (s)
           (a:eswitch (s :test #'string=)
             ("U" (v!  0  1))
             ("D" (v!  0 -1))
             ("L" (v! -1  0))
             ("R" (v!  1  0)))))
    (nreverse
     (re:do-register-groups ((#'f dir) (#'parse-integer num))
         ("([UDLR]+) (\\d+)"
          (a:read-file-into-string "day9.txt")
          motions)
       (push `(,dir ,num) motions)))))

(-> new-position (rtg-math.types:vec2 rtg-math.types:vec2)
    rtg-math.types:vec2)
(defun new-position (tail head &aux (diff (v2:- head tail)))
  (flet ((f (i) (cond ((> i 0)  1) ((< i 0) -1) ((= i 0)  0))))
    (if (>= (v2:distance head tail)
            2.0)
        (v2:+ tail (v! (f (x diff)) (f (y diff))))
        tail)))

(-> silver () fixnum)
(defun silver (&aux (visits ()) (head (v! 0 0)) (tail (v! 0 0)))
  (dolist (motion (motions))
    (destructuring-bind (direction by) motion
      (dotimes (i by)
        (v2:incf head direction)
        (push (setf tail (new-position tail head))
              visits))))
  (length
   (remove-duplicates
    (cons (v! 0 0) visits) :test #'v2:=)))

(s:-> move-tails (list rtg-math.types:vec2)
      list)
(defun move-tails (tails head)
  (loop :for tail :in tails
        :with tmp-head := head
        :with ret := ()
        :do (setf tmp-head (car (push (new-position tail tmp-head) ret)))
        :finally (return (nreverse ret))))

(defun gold (&aux (visits ()) (head (v! 0 0)) (tails (make-list 9 :initial-element (v! 0 0))))
  (dolist (motion (motions))
    (destructuring-bind (direction by) motion
      (dotimes (i by)
        (plot-coordinates tails)
        (v2:incf head direction)
        (push (a:lastcar (setf tails (move-tails tails head)))
              visits))))
  (length
   (remove-duplicates
    (cons (v! 0 0) visits) :test #'v2:=)))

(defun main ()
  (parse (or (s:take 1 (uiop:command-line-arguments))
             "day9.txt")))
