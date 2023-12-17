;;(ql:quickload '(:serapeum :alexandria :defpackage-plus :arrows :cl-ppcre :array-operations))

(defpackage+-1:defpackage+ #:day17silver
  (:use #:cl #:arrows)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day17silver)

(defparameter *min-score* 0)
(defparameter *input*
  "data/day17.test.txt")

(defun make-array-from-list-of-list (xss &aux (width (length xss)) (height (length (first xss))))
  (make-array `(,width ,height) :initial-contents xss))

(defun words (string) (re:split #\newline string))
(defun slurp (filename) (a:read-file-into-string filename))
(defun parse-input (filename)
  (->> filename slurp words
       (mapcar (s:op (map 'list #'digit-char-p _)))
       (make-array-from-list-of-list)))

(defun map-at (map x y) (aref map y x))
(defun visited-p (visits x y) (position `(,x ,y) visits :test #'equal))
(defun inside-map-p (map x y)
  (destructuring-bind (xdim ydim) (array-dimensions map)
    (and (< x xdim) (< y ydim) (>= x 0) (>= y 0))))

(defun 2arrow (orientation)
  (ecase orientation
    (#\U #\^)
    (#\D #\v)
    (#\L #\<)
    (#\R #\>)))

(defun solve (file &aux (input (parse-input file)))
  (setf *min-score* 0)
  (walk input 0 0 #\R)
  (walk input 0 0 #\D))

(defun print-map (map)
  (dotimes (y (array-dimension map 0))
    (dotimes (x (array-dimension map 1))
      (format t "~a" (aref map y x)))
    (terpri))
  (terpri))

(defun walk (map x y orientation &optional (acc 0) (counter 0) (visits ())
                                           (view (aops:make-array-like map :initial-element #\.)))

  (when (visited-p visits x y)       (return-from walk))
  (when (not (inside-map-p map x y)) (return-from walk))
  ;; (print (list x y orientation counter visits))
  ;; (print-map view)
  ;; (sleep 3)
  (when (and (= x (1- (array-dimension map 1))) (= y (1- (array-dimension map 0))))
    (print-map view)
    (print (list "ended" (+ acc (map-at map x y))))
    (setf *min-score* (min *min-score* (+ acc (map-at map x y))))
    (return-from walk))

  (setf (aref view y x) (2arrow orientation))

  (let* ((visits    (cons `(,x ,y) visits))
         (loss      (map-at map x y))
         (acc       (+ acc (if (= x y 0) 0 loss)))
         (counter+1 (+ counter 1)))

    (ecase orientation
      (#\U (progn
             (if (> counter 2) (walk map x (- y 1) orientation acc counter+1 (copy-seq visits) (a:copy-array view)))
             (walk map (- x 1) y #\L acc 0 (copy-seq visits) (a:copy-array view))
             (walk map (+ x 1) y #\R acc 0 (copy-seq visits) (a:copy-array view))))
      (#\D (progn
             (if (> counter 2) (walk map x (+ y 1) orientation acc counter+1 (copy-seq visits) (a:copy-array view)))
             (walk map (- x 1) y #\L acc 0 (copy-seq visits) (a:copy-array view))
             (walk map (+ x 1) y #\R acc 0 (copy-seq visits) (a:copy-array view))))
      (#\L (progn
             (if (> counter 2) (walk map (- x 1) y orientation acc counter+1 (copy-seq visits) (a:copy-array view)))
             (walk map x (+ y 1) #\D acc 0 (copy-seq visits) (a:copy-array view))
             (walk map x (- y 1) #\U acc 0 (copy-seq visits) (a:copy-array view))))
      (#\R (progn
             (if (> counter 2) (walk map (+ x 1) y orientation acc counter+1 (copy-seq visits) (a:copy-array view)))
             (walk map x (+ y 1) #\D acc 0 (copy-seq visits) (a:copy-array view))
             (walk map x (- y 1) #\U acc 0 (copy-seq visits) (a:copy-array view)))))))
