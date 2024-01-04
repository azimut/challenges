(ns pig-latin
  (:require [clojure.string :as str]))

(defn- translate-word [word]
  (cond
    (re-find #"^([aeiou]|xr|yt)" word) (str word "ay"); 1
    (re-find #"^[^aeiou]*qu"     word) (str/replace word #"^([^aeiou]*qu)(.*)" "$2$1ay"); 3
    (re-find #"^[^aeiou]+y"      word) (str/replace word #"^([^aeiou]+)(y.*)" "$2$1ay"); 4
    (re-find #"^(ch|[^aeiou]+)"  word) (str/replace word #"^(ch|[^aeiou]+)(.*)" "$2$1ay"); 2
    :else word))

(defn translate [phrase]
  (->> (str/split phrase #" ")
       (map translate-word)
       (str/join " ")))
