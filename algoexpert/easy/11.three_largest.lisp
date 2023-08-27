(defparameter *input-11*
  '(141 1 17 -7 -17 -27 18 541 8 7 7))

(defun solve-subseq (lst &aux (size (length lst)))
  (subseq (sort lst #'<) (- size 3) size))

(defun solve-subseq-reverse (lst)
  (reverse
   (subseq (sort lst #'>) 0 3)))

(defun solve-nthcdr (lst)
  (nthcdr (max 0 (- (length lst) 3))
          (sort lst #'<)))

(defun solve-loop (lst)
  (reverse
   (loop :repeat 3
         :for el :in (sort lst #'>)
         :collect el)))

;; NOTE: COPY-SEQ due SORT is destructive
(solve-subseq-reverse (copy-seq *input-11*))
(solve-subseq         (copy-seq *input-11*))
(solve-nthcdr         (copy-seq *input-11*))
(solve-loop           (copy-seq *input-11*))
