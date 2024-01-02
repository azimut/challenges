(ns squeaky-clean
  (:require [clojure.string :as str]))

(defn omit-non-letters [s]
  (str/join (filter #(or (Character/isLetter %1) (= \_ %1)) s)))

(defn clean [s]
  (-> s
      (str/replace #"\s" "_")
      (str/replace #"\pC" "CTRL")
      (str/replace #"\-(.)" #(str/upper-case (second %)))
      (omit-non-letters)
      (str/replace #"[α-ω]" "")))
