(defn solve [xs]
  (->> xs sort (take-last 3)))

(solve '(141 1 17 -7 -17 -27 18 541 8 7 7))
