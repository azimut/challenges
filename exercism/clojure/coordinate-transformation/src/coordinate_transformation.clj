(ns coordinate-transformation)

(defn translate2d
  "Returns a function making use of a closure to
   perform a repeatable 2d translation of a coordinate pair."
  [dx dy]
  (fn [x y] (vector (+ dx x) (+ dy y))))

(defn scale2d
  "Returns a function making use of a closure to
   perform a repeatable 2d scale of a coordinate pair."
  [sx sy]
  (fn [x y] (vector (* sx x) (* sy y))))

(defn compose-transform
  "Create a composition function that returns a function that
   combines two functions to perform a repeatable transformation."
  [f g]
  (fn [x y] (apply g (f x y))))

(defn memoize-transform
  "Returns a function that memoizes the last result.
   If the arguments are the same as the last call,
   the memoized result is returned."
  [f]
  (let [prev (atom ())]
    (fn [& args]
      (if (= (first @prev) args)
        (second @prev)
        (let [ret (apply f args)]
          (reset! prev (list args ret))
          ret)))))
