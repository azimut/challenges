(eval-when (:execute)
  (ql:quickload '(:serapeum :cl-ppcre :defpackage-plus :array-operations)))

(defpackage+-1:defpackage+ #:day21.silver
  (:use #:cl)
  (:import-from #:serapeum #:op #:~> #:~>>)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day21.silver)

(defun input (filename)
  (let* ((content (alexandria:read-file-into-string filename))
         (width   (position #\NewLine content)))
    (~> (remove #\NewLine content)
        (aops:reshape (list width t)))))

(defun neighbours (map x y &aux (directions '((0 1) (1 0) (0 -1) (-1 0))))
  (loop :for (dx dy) :in directions
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

(defun solve (map target-step

              &aux (aseen (aops:make-array-like map :initial-element 0 :element-type 'fixnum))
                   (queue (s:queue)))

  (destructuring-bind (startx starty) (start-pos map)
    (s:enq `(,startx ,starty 0) queue))

  (loop :until (s:queue-empty-p queue)
        :for (x y step) = (s:deq queue)
        :if (= target-step step)
          :do (incf (aref aseen x y))
        :else
          :do (loop :for (nx ny) :in (neighbours map x y)
                    :do (s:enq `(,nx ,ny ,(+ 1 step)) queue)))

  (s:summing
    (aops:each-index (x y)
      (when (plusp (aref aseen x y))
        (sum 1)))))

;; ------------------------------

(defun print-2d-array (map &optional (formatter #'identity))
  (dotimes (y (array-dimension map 0))
    (dotimes (x (array-dimension map 1))
      (format t "~a" (funcall formatter (aref map y x))))
    (terpri))
  (terpri))
