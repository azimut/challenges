(eval-when (:execute)
  (ql:quickload
   '(:serapeum :cl-ppcre :defpackage-plus :cl-oju :array-operations #:sketch)))

(defpackage+-1:defpackage+ #:day24.silver
  (:use #:cl #:sketch)
  (:import-from #:cl-oju #:slurp #:take)
  (:import-from #:serapeum #:op #:~> #:~>> #:-> #:filter-map)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day24.silver)

(defstruct hail p1 vel p2)
(defun x (arr) (aref arr 0))
(defun y (arr) (aref arr 1))

(defun input (filename &optional (divisor 1))
  (flet ((f (s) (map 'vector #'parse-integer (re:split ", " s))))
    (s:collecting
      (re:do-register-groups ((#'f p1) (#'f vel))
          ("(.*) @ (.*)" (slurp filename))
        (let ((p1 (aops:each (op (round (/ _ divisor))) p1))
              (vel (aops:each (op (floor (/ _ divisor))) vel)))
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

;; Test Data
;;#+nil
(progn (defvar *tmp* (input "data/day24.test.txt"))
       (defsketch tutorial
           ((width  800)
            (height 800)
            (should-save-p t))

         (background +white+)
         (translate 100 100)
         (scale 20)

         (dolist (hail (take 999 *tmp*))
           (with-pen (make-pen :stroke +black+ :weight .1)
             (line (x (hail-p1 hail)) (y (hail-p1 hail))
                   (+ (* 100 (x (hail-vel hail))) (x (hail-p1 hail)))
                   (+ (* 100 (y (hail-vel hail))) (y (hail-p1 hail))))))

         (with-pen (make-pen :fill (rgb .2 .9 .2 .3))
           (rect 7 7 20 20))

         ;;#+nil
         (dotimes (i (length *tmp*))
           (dotimes (j (- (length *tmp*) 1))
             (a:when-let ((ipoint (intersect `(,(nth i *tmp*) ,(nth j *tmp*)))))
               (when (in-range-p ipoint 7 27)
                 (with-pen (make-pen :fill +red+)
                   (circle (+ -.6 (x ipoint))
                           (+ -.6 (y ipoint))
                           .7))))))

         (when should-save-p
           (setf should-save-p nil)
           (save-png "/home/sendai/day24.test.png"))))



#+nil
(defsketch tutorial
    ((width  800)
     (height 800)
     (should-save-p t))

  (background +white+)

  (translate 100 100)
  (scale 1)

  (dolist (hail (take 9 *tmp2*))
    (with-pen (make-pen :stroke +black+ :weight .5)
      (line (x (hail-p1 hail)) (y (hail-p1 hail))
            (+ (* 100 (x (hail-vel hail))) (x (hail-p1 hail)))
            (+ (* 100 (y (hail-vel hail))) (y (hail-p1 hail)))))
    #+nil
    (with-pen (make-pen :stroke +black+ :weight 1)
      (circle (x (hail-p1 hail))
              (y (hail-p1 hail))
              1)))

  ;; (dotimes (i (- (length (take 999 *tmp2*)) 2))
  ;;   (a:when-let ((ipoint (intersect (list (nth i *tmp2*)
  ;;                                         (nth (1+ i) *tmp2*)))))
  ;;     (with-pen (make-pen :stroke +red+ :weight 1)
  ;;       (circle (x ipoint)
  ;;               (y ipoint)
  ;;               1))))

  (with-pen (make-pen :fill (rgb .2 .7 .4 .3))
    (rect 200 200 200 200))

  #+nil
  (when should-save-p
    (setf should-save-p nil)
    (save-png "/home/sendai/day24.png"))

  )
