(ns acronym
  (:require [clojure.string :as str]))

(defn acronym
  "Converts phrase to its acronym."
  [phrase]
  (-> phrase
      (str/split #":") (first)                              ; recursive acronyms
      (str/replace-first #"." #(str/upper-case %))          ; capitalize
      (str/replace #"[\s-](.)" #(str/upper-case (second %))); uppercase after break
      (str/replace #"[^A-Z]" "")))                          ; keep only upcases
