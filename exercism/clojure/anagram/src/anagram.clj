(ns anagram
  (:require [clojure.string :as str]))

(defn anagram? [word other-word]
  (let [w (str/lower-case word)
        o (str/lower-case other-word)]
    (and (not= w o)
         (= (sort w) (sort o)))))

(defn anagrams-for [word prospect-list]
  (filter #(anagram? word %) prospect-list))
