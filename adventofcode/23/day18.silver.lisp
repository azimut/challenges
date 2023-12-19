(eval-when (:execute)
  (ql:quickload '(:cl-ppcre :serapeum :defpackage-plus)))

(defpackage+-1:defpackage+ #:day18.silver
  (:use #:cl)
  (:import-from #:serapeum #:~>> #:~>)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day18.silver)

(defun dirvector (dir)
  (a:switch (dir :test #'string=)
    ("D" '( 0  1))
    ("U" '( 0 -1))
    ("R" '( 1  0))
    ("L" '(-1  0))))

(defun input (filename &aux (text (a:read-file-into-string filename)))
  (s:collecting
    (re:do-register-groups ((#'dirvector direction) (#'parse-integer distance))
        ("([UDLR]) ([0-9]+) \\(.*\\)" text) ;; R 6 (#70c710)
      (collect (list direction distance)))))

(defun positions (instructions)
  (loop :for ((dx dy) distance _) :in instructions
        :with x = 0 and y = 0
        :collecting (list (incf x (* distance dx))
                          (incf y (* distance dy)))
          :into positions
        :finally (return (cons '(0 0) positions))))

(defun shoelace (positions) ;; Shoelace's formula for internal area
  (loop :for ((x1 y1) (x2 y2)) :on (append positions (list (first positions)))
        :when (and x1 y1 x2 y2)
          :summing (- (* x1 y2) (* x2 y1))
            :into sum
        :finally (return (abs (/ sum 2)))))

(defun picks (instructions internal-area) ;; Pick's theorem
  (let ((b (reduce #'+ (mapcar #'second instructions))))
    (+ 1 internal-area (/ b 2))))

(defun solve (filename &aux (instructions (input filename)))
  (~>> (shoelace (positions instructions))
       (picks instructions)))
