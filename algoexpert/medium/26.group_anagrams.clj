;; INCOMPLETE

(def input '("yo" "act" "flop" "tac" "cat" "oy" "olfp"))

(defn naive [words]
  (let [nth-word #(nth words %)]
    (->> words
         (map sort)
         (map #(apply str %))
         (zipmap (range))
         (group-by #(second %))
         vals
         (map #(map first %))
         (map #(map nth-word %)))))

(defn idiomatic [words]
  (->> words (group-by set) vals))
