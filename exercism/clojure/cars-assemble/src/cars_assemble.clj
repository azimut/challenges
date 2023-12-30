(ns cars-assemble)

(defn production-rate
  "Returns the assembly line's production rate per hour,
   taking into account its success rate"
  [speed]
  (double
   (cond (= speed 10) (* speed 221 0.77)
         (= speed  9) (* speed 221 0.80)
         (> speed  4) (* speed 221 0.90)
         :else (* speed 221))))

(defn working-items
  "Calculates how many working cars are produced per minute"
  [speed]
  (int (/ (production-rate speed) 60)))
