(defun solve (lst &key (depth 1) (sum 0))
  (loop :for x :in lst
        :if (listp x)
          :do (incf sum (solve x :depth (1+ depth)))
        :else
          :do (incf sum x)
        :finally (return (* depth sum))))

(solve '(1 2 3 (1 3) 3))
