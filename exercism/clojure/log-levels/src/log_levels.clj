(ns log-levels
  (:require [clojure.string :as str]))

(defn message
  "Takes a string representing a log line
   and returns its message with whitespace trimmed."
  [s]
  (str/trim (second (str/split s #":"))))

(defn log-level
  "Takes a string representing a log line
   and returns its level in lower-case."
  [s]
  (str/lower-case (second (re-find #"\[(\w+)\]" s))))

(defn reformat
  "Takes a string representing a log line and formats it
   with the message first and the log level in parentheses."
  [s]
  (format "%s (%s)" (message s) (log-level s)))
