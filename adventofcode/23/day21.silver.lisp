(eval-when (:execute)
  (ql:quickload '(:serapeum :cl-ppcre :defpackage-plus :array-operations)))

(defpackage+-1:defpackage+ #:day21.silver
  (:use #:cl)
  (:import-from #:serapeum #:op #:~> #:~>> #:->)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day21.silver)

(defun input (filename)
  (let* ((content (alexandria:read-file-into-string filename))
         (width   (position #\NewLine content)))
    (~> (remove #\NewLine content)
        (aops:reshape (list width t)))))

(-> neighbours ((array character (* *)) Fixnum Fixnum) List)
(defun neighbours (map x y)
  (loop :for (dx dy) :in '((0 1) (1 0) (0 -1) (-1 0))
        :for nx = (+ x dx)
        :for ny = (+ y dy)
        :when (and (<= 0 nx (1- (array-dimension map 1)))
                   (<= 0 ny (1- (array-dimension map 0)))
                   (not (eql #\# (aref map ny nx)))) ;; not a rock
          :collect `(,nx ,ny)))

(defun start-pos (map)
  (aops:each-index (x y)
    (when (eql #\S (aref map x y))
      (return-from start-pos `(,x ,y)))))

;; steps/map/garden plot(.)/rocks(#)/starting position (S)/tile/NSEW

(-> travel ((array character (* *)) Fixnum Fixnum Fixnum Fixnum (array fixnum (* *))) (values))
(defun travel (map x y target-step step seen)
  (declare (optimize (speed 3)))
  (loop :for (nx ny) :in (neighbours map x y)
        :if (= step target-step)
          :do (when (zerop (aref seen x y))
                (incf (aref seen x y)))
        :else
          :do (travel map nx ny target-step (+ step 1) seen))
  (values))

(defun solve (map target-step)
  (let ((seen (aops:make-array-like map :initial-element 0 :element-type 'fixnum)))
    (destructuring-bind (startx starty) (start-pos map)
      (travel map startx starty target-step 0 seen))
    (s:summing
      (aops:each-index (x y)
        (when (plusp (aref seen x y))
          (sum 1))))))

;; ------------------------------

(defun print-2d-array (map &optional (formatter #'identity))
  (dotimes (y (array-dimension map 0))
    (dotimes (x (array-dimension map 1))
      (format t "~a" (funcall formatter (aref map y x))))
    (terpri))
  (terpri))
