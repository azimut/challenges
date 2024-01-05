(ns isogram
  (:require [clojure.string :as str]))

(defn isogram? [word]
  (let [word (-> word (str/lower-case) (str/replace #"[\s-]" ""))]
    (= (count word) (count (set word)))))
