(ns armstrong-numbers
  (:require [clojure.string :as str]))

(defn armstrong? [num]
  (->> (str/split (str num) #"")
       (map read-string)
       (map #(Math/pow % (count (str num))))
       (reduce +)
       (== num)))
