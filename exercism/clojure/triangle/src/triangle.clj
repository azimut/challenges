(ns triangle)

(defn is-valid? [a b c]
  (and (every? pos? [a b c])
       (>= (+ b c) a)
       (>= (+ a c) b)
       (>= (+ a b) c)))

(defn equilateral? [a b c]
  (and (is-valid? a b c)
       (= a b c)))

(defn scalene? [a b c]
  (and (is-valid? a b c)
       (not= a c) (not= a b) (not= b c)))

(defn isosceles? [a b c]
  (and (is-valid? a b c)
       (or (= a b) (= b c) (= a c))))
