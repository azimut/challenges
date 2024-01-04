(ns sublist)

(defn sublist? [xs ys]
  (not-empty
   (for [i (range (max 0 (+ 1 (- (count ys) (count xs)))))
         :when (= xs (->> ys (drop i) (take (count xs))))]
     true)))

(defn classify [xs ys]
  (cond
    (= xs ys)        :equal
    (sublist? xs ys) :sublist
    (sublist? ys xs) :superlist
    :else            :unequal))
