;; TODO: INCOMPLETE, missing tl call
(defn solve-incomplete [lst]
  (loop [[hd & tl] lst
         sum 0 depth 1]
    (cond
      (list?   hd) (recur hd 0 (inc depth))
      (number? hd) (recur tl (+ sum hd) depth)
      :else        (* depth sum))))

(defn solve
  ([lst] (solve lst 1))
  ([lst depth]
   (->> (for [x lst]
          (if (number? x)
            x
            (solve x (inc depth))))
        (reduce +)
        (* depth))))

;; 6 + (4*2) + 3
;; 9 + (8)
;; 17
(solve-incomplete '(1 2 3 (1 3) 3))
(solve '(1 2 3 (1 3) 3))
