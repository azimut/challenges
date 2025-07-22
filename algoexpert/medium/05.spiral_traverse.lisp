;; INCOMPLETE
(defparameter *square*
  #2A(( 1  2  3 4)
      (12 13 14 5)
      (11 16 15 6)
      (10  9  8 7)))

(defparameter *square2*
  #2A(( 1  2  3  4 5)
      (16 17 18 19 6)
      (15 24 25 20 7)
      (14 23 22 21 8)
      (13 12 11 10 9)))

(defparameter *rectangular*
  #2A(( 1  2  3  4 5)
      (14 15 16 17 6)
      (13 20 19 18 7)
      (12 11 10  9 8)))

(defun travel (arr layer cols rows &aux (result ()))
  ;; -> TOP
  (loop :for col :from layer :below (- cols layer)
        :do (push (aref arr layer col) result))
  ;; v  RIGHT
  (loop :for row :from (1+ layer) :below (1- (- rows layer))
        :do (push (aref arr row (1- (- cols layer))) result))
  ;; <- BOTTOM
  (loop :for col :from (1- (- cols layer)) :downto layer
        :do (push (aref arr (- rows layer 1) col) result))
  ;; ^  LEFT
  (loop :for row :from (- (- rows layer) 2) :downto (1+ layer)
        :do (push (aref arr row layer) result))
  (reverse result))

(defun solve (arr &aux (cols (array-dimension arr 1))
                       (rows (array-dimension arr 0)))
  (loop :repeat 2 ; TODO: figure out a value that works with rectangular and square
        :for layer :from 0
        :appending (travel arr layer cols rows)))

#+nil
(progn (solve *rectangular*)
       (solve *square*)
       (solve *square2*))
