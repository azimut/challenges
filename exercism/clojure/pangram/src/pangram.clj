(ns pangram
  (:require [clojure.string :as str]))

(defn pangram? [phrase]
  (->> (str/lower-case phrase)
       (re-seq #"[a-z]")
       (distinct)
       (count)
       (= 26)))
