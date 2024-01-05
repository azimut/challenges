(ns say
  (:require [clojure.pprint :as pp]
            [clojure.string :as str]))

(defn number [num]
  (if (or (< num 0) (> num 999999999999))
    (throw (IllegalArgumentException. num))
    (-> (pp/cl-format false "~R" num)
        (str/replace "," ""))))
