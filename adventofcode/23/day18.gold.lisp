(eval-when (:execute)
  (ql:quickload '(:cl-ppcre :serapeum :defpackage-plus)))

(defpackage+-1:defpackage+ #:day18.gold
  (:use #:cl)
  (:import-from #:serapeum #:~>> #:~>)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day18.gold)

(defun dirvector (dir)
  (a:switch (dir :test #'string=)
    ("D" '( 0  1))
    ("U" '( 0 -1))
    ("R" '( 1  0))
    ("L" '(-1  0))))

(defun hexa2instruction (hexa &aux (len (1- (length hexa))))
  (let ((dir (~> (subseq hexa len) parse-integer
                 (s:assocadr '((0 "R") (1 "D") (2 "L") (3 "U"))))))
    `(,(dirvector dir)
      ,(~> (subseq hexa 1 len) (parse-integer :radix 16))
      ,dir)))

(defun input (filename &aux (text (a:read-file-into-string filename)))
  (s:collecting
    (re:do-register-groups ((#'hexa2instruction instruction))
        ("[UDLR] [0-9]+ \\((.*)\\)" text) ;; R 6 (#70c710)
      (collect instruction))))

(defun positions (instructions)
  (loop :for ((dx dy) distance _) :in instructions
        :with x = 0 and y = 0
        :collecting (list (incf x (* distance dx)) (incf y (* distance dy)))
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
    (+ internal-area
       1
       (/ b 2))))

(defun solve (filename &aux (instructions (input filename)))
  (~>> (shoelace (positions instructions))
       (picks instructions)))

(eval-when (:execute) (print (solve "data/day18.txt")))
