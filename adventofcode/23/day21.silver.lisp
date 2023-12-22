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

(-> neighbours ((array character (* *)) (array boolean (* *)) Fixnum Fixnum) List)
(defun neighbours (map seen x y)
  (loop :for (dx dy) :in '((0 1) (1 0) (0 -1) (-1 0))
        :for nx = (+ x dx)
        :for ny = (+ y dy)
        :when (and (<= 0 nx (1- (array-dimension map 1)))
                   (<= 0 ny (1- (array-dimension map 0)))
                   (not (aref seen ny nx))
                   (not (eql #\# (aref map ny nx)))) ;; not a rock
          :collect `(,nx ,ny)))

(defun start-pos (map)
  (aops:each-index (x y)
    (when (eql #\S (aref map x y))
      (return-from start-pos `(,x ,y)))))

;; steps/map/garden plot(.)/rocks(#)/starting position (S)/tile/NSEW

(-> flip (character) character)
(defun flip (char)
  (ecase char
    (#\S #\O); start is lost in translation
    (#\. #\O)
    (#\O #\.)
    (#\# #\#)))

;; NOTE: might be I could reduce the search size using a radius and start positions
(defun flip-seen (map seen)
  (dotimes (x (array-dimension map 0))
    (dotimes (y (array-dimension map 1))
      (when (aref seen x y)
        (setf (aref map x y) (flip (aref map x y)))))))

(defun solve (map target-step
              &aux (queue (s:queue))
                   (seen (aops:make-array-like map :initial-element nil :element-type 'boolean)))

  (destructuring-bind (startx starty) (start-pos map)
    (s:enq `(,startx ,starty 0) queue))
  (print-2d-array map)
  (loop :until (s:queue-empty-p queue)
        :for (x y step) = (s:deq queue)
        :for i :from 0
        :with prev-step = 0
        :when (/= prev-step step)
          :do (flip-seen map seen)
        :when (/= step target-step)
          :do (setf (aref seen y x) t)
              (format t "i=~d s=~d q=~d~%" i step (s:qlen queue))
              (loop :for (nx ny) :in (neighbours map seen x y)
                    :do (s:enq `(,nx ,ny ,(+ step 1)) queue))
              ;;(print-2d-array map)
              ;;(print-2d-array seen (lambda (c) (if c "t" ".")))
              (setf prev-step step))
  (print-2d-array map)

  (s:summing
    (aops:each-index (x y)
      (when (eql #\O (aref map x y))
        (sum 1)))))

;; ------------------------------

(defun print-2d-array (map &optional (formatter #'identity))
  (dotimes (y (array-dimension map 0))
    (dotimes (x (array-dimension map 1))
      (format t "~a" (funcall formatter (aref map y x))))
    (terpri))
  (terpri))
