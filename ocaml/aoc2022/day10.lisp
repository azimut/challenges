(ql:quickload '(#:defpackage-plus #:alexandria #:serapeum #:cl-ppcre))

(defpackage+-1:defpackage+ #:aoc2022-day10
  (:use #:cl)
  (:import-from #:serapeum #:->)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:aoc2022-day10)

(defstruct cpu (cycle 0 :type fixnum) (x 0 :type fixnum))


#|
x controls the HORIZONTAL position of a SPRITE
SPRITE is 3(three) pixels wide
x sets the HORIZONTAL position of the middle of the sprite

CRT pixels 40x6 - 40 wide 6 high
draws from top to bottom, from left to right (0-39)
draws a pixel on each cycle
240 cycles to draw the whole screen (1-40/41-80/81-120/121-160/161-200/201-240)
|#

(-> instructions (String) List)
(defun instructions (filename)
  (with-open-file (fd filename)
    (loop
      :for line := (read-line fd nil nil)
      :while line
      :with cycle := 1
      :with x := 1
      :collect
      (let ((words (re:split " " line)))
        (if (a:length= 2 words)
            (make-cpu :cycle (incf cycle 2) :x (incf x (parse-integer (second words))))
            (make-cpu :cycle (incf cycle)   :x x))))))

(-> silver (List) Fixnum)
(defun silver (instructions &aux (ri (reverse instructions)) (signal-cycles '(20 60 100 140 180 220)))
  (s:~>> (loop :for signal-cycle :in signal-cycles
               :collect (find signal-cycle ri :key #'cpu-cycle :test #'>=))
         (remove-if #'null)
         (mapcar #'cpu-x)
         (mapcar #'* signal-cycles)
         (reduce #'+)))

(defun gold () 0)
