;; INCOMPLETE
(eval-when (:execute)
  (ql:quickload
   '(:serapeum :cl-ppcre :defpackage-plus :cl-oju :array-operations :eazy-gnuplot)))

(defpackage+-1:defpackage+ #:day24.gold
  (:use #:cl)
  (:import-from #:cl-oju #:slurp #:take)
  (:import-from #:serapeum #:op #:~> #:~>> #:-> #:filter-map)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day24.gold)

(defstruct hail p1 vel p2)

(defun x (arr) (aref arr 0))
(defun y (arr) (aref arr 1))
(defun z (arr) (aref arr 2))

(defun input (filename &key (divisor 1) (multiplier 1))
  (flet ((f (s) (map 'vector #'parse-integer (re:split ", " s))))
    (s:collecting
      (re:do-register-groups ((#'f p1) (#'f vel))
          ("(.*) @ (.*)" (slurp filename))
        (let ((p1 (aops:each (op (round (/ _ divisor))) p1))
              (vel (aops:each (op (* multiplier _)) vel)))
          (collect (make-hail :p1 p1
                              :p2 (aops:each #'+ p1 vel)
                              :vel vel)))))))

;; hailstones/position@velocity/break/time=0/xyz/nanosecond/forwardintime/paths/intersect

(defun in-range-p (xyz min max &aux (x (aref xyz 0)) (y (aref xyz 1)))
  (and (<= min x max) (<= min y max)))

(defun future-point-p (hail intersection)
  (with-slots (p1 p2) hail
    (and (or (< (x p1) (x p2) (x intersection))
             (< (x intersection) (x p2) (x p1)))
         (or (< (y p1) (y p2) (y intersection))
             (< (y intersection) (y p2) (y p1))))))

(defun intersect (hail-pair)
  (let* ((hail-a (first hail-pair))
         (hail-b (second hail-pair))
         (p0 (hail-p1 hail-a))
         (p1 (hail-p2 hail-a))
         (p2 (hail-p1 hail-b))
         (p3 (hail-p2 hail-b))
         (a1 (- (y p1) (y p0)))
         (b1 (- (x p0) (x p1)))
         (c1 (+ (* a1 (x p0)) (* b1 (y p0))))
         (a2 (- (y p3) (y p2)))
         (b2 (- (x p2) (x p3)))
         (c2 (+ (* a2 (x p2)) (* b2 (y p2))))
         (denominator (- (* a1 b2) (* a2 b1)))
         (intersection
           (when (not (zerop denominator))
             (vector (float (/ (- (* b2 c1) (* b1 c2)) denominator))
                     (float (/ (- (* a1 c2) (* a2 c1)) denominator))))))
    (when intersection
      (and (future-point-p hail-a intersection)
           (future-point-p hail-b intersection)
           intersection))))

(defun combinations (lst)
  (s:collecting
    (a:map-combinations (lambda (e) (collect e)) lst :length 2)))

(defun nintersects-in-range (hails min max)
  (~>> (combinations hails)
       (filter-map #'intersect)
       (filter-map (op (in-range-p _ min max)))
       (length)))

(defun solve (filename &aux (hails (input filename)))
  (a:eswitch (filename :test #'string=)
    ("data/day24.test.txt" (nintersects-in-range hails 7 27))
    ("data/day24.txt"      (nintersects-in-range
                            hails
                            (* 2 (expt 10 14))
                            (* 4 (expt 10 14))))))


;;----------------------------------------

(defun hails2gp (hails)
  (dolist (hail hails)
    (eazy-gnuplot:gp :set :arrow
                     :from (coerce (hail-p1 hail) 'list)
                     :to (coerce (hail-p2 hail) 'list)
                     :arrowstyle 1)))

(in-package #:eazy-gnuplot)

;; https://stackoverflow.com/questions/15553988/how-to-draw-just-arrow-in-gnuplot
;;#+nil
(with-plots (*standard-output* :debug t)
  (gp-setup :terminal '(:x11))
  (gp :set :view '(114 40))
  (gp :set :border 4095)
  (gp :set :style :line 1 :lt 3 :lw 2)
  (gp :set :style :arrow 1 :head :ls 1)
  ;;(gp :set :arrow :from '(20 19 15) :to '(22 9 9) :arrowstyle 1)
  (day24.gold::hails2gp (day24.gold::input "data/day24.test.txt" :multiplier 10))
  (gp :set :xrange '(0 30))
  (gp :set :yrange '(0 40))
  (gp :set :zrange '(10 40))
  (splot "NaN")
  (format t "~&pause mouse close~%"))

(with-plots (*standard-output* :debug t)
  (gp-setup :terminal '(:x11))
  (gp :set :view '(114 40))
  (gp :set :border 4095)
  (gp :set :style :line 1 :lt 2 :lw 1)
  (gp :set :style :arrow 1 :nohead :ls 1)
  ;; (gp :set :arrow :from '(20 19 15) :to '(22 9 9) :nohead)
  ;;(gp :set :arrow :from '(20 19 15) :to '(22 9 9) :arrowstyle 1)
  (day24.gold::hails2gp (day24.gold::input "data/day24.txt" :divisor (expt 10 12) :multiplier 1))
  (gp :set :xrange (list -100 900))
  (gp :set :yrange (list -100 900))
  (gp :set :zrange (list 0 1000))
  (splot "NaN")
  (format t "~&pause mouse close~%"))
