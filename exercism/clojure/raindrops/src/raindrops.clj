(ns raindrops)

(defn convert [num]
  (let [res (str (when (zero? (mod num 3)) "Pling")
                 (when (zero? (mod num 5)) "Plang")
                 (when (zero? (mod num 7)) "Plong"))]
    (if (empty? res) (str num) res)))
