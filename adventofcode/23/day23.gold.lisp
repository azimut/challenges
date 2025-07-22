;; INCOMPLETE
;; map/hikingtrails/(.)paths/(#)forest/(^>v<)steepslopes(icy)/downhill/tile/row/start/goal/scenichike

(eval-when (:execute)
  (ql:quickload '(:serapeum :cl-ppcre :defpackage-plus :array-operations :select :cl-oju)))

(defpackage+-1:defpackage+ #:day23.gold
  (:use #:cl)
  (:import-from #:cl-oju #:slurp #:spit)
  (:import-from #:serapeum #:op #:~> #:~>> #:->)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day23.gold)

(defvar *count* 0)
(defvar *what* ())

(defun input (filename)
  (let* ((content   (slurp filename))
         (width     (position #\NewLine content))
         (map       (~> (remove #\NewLine content) (aops:reshape `(,width t))))
         (start-pos (complex (position #\. (select:select map  0 t)) 0))
         (end-pos   (complex (position #\. (select:select map -1 t)) (1- (array-dimension map 0)))))
    (values map start-pos end-pos)))

;; This changes from silver
(defun neighbours (map pos &aux (width (array-dimension map 0))); assumes square
  (loop :for dt :in '(#C(0 1) #C(0 -1) #C(1 0) #C(-1 0))
        :for new-pos = (+ pos dt)
        :for nx = (realpart new-pos)
        :for ny = (imagpart new-pos)
        :when (and (<= 0 nx (1- width))
                   (<= 0 ny (1- width))
                   (not (eql #\# (aref map ny nx))))
          :collect (complex nx ny)));; x y

(defun hike (map pos travel end-pos)
  ;;  (print-map map travel)
  ;;  (format t "pos=~a~%" pos)
  (if (= pos end-pos)
      (progn
        ;;(spit-map map travel (format nil "day23.silver.~5,'0d.~4,'0d.txt" (length travel) (incf *count*)))
        (push (length travel) *what*))
      (loop :for neighbour :in (neighbours map pos)
            ;;,:do (format t "pos=~a ne=~a~%" pos neighbour)
            :unless (position neighbour travel)
              :do (hike map neighbour (cons neighbour travel) end-pos))))

(defun solve (map start-pos end-pos)
  (setf *what* ())
  (setf *count* 0)
  (hike map start-pos '() end-pos)
  (print (apply #'max *what*)))

;;----------------------------------------

(defun format-2d-array (map &optional (formatter #'identity))
  (with-output-to-string (out)
    (dotimes (y (array-dimension map 0))
      (dotimes (x (array-dimension map 1))
        (format out "~a" (funcall formatter (aref map y x))))
      (terpri out))
    (terpri out)))

(defun format-map (map travel &aux (map-copy (a:copy-array map)))
  (loop :for pos :in travel
        :for x = (realpart pos)
        :for y = (imagpart pos)
        :do (setf (aref map-copy y x) #\o))
  (flet ((f (c)
           (ecase c
             (#\o #\o)
             (#\# "░")
             (#\. " ")
             (#\^ "↑")
             (#\> "→")
             (#\< "←")
             (#\v "↓"))))
    (format-2d-array map-copy #'f)))

(defun spit-map (map travel filename)
  (spit filename (format-map map travel))
  (values))
