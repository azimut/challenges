type item =
  | Value of int
  | Item of item list

let prod_sum lst =
  let rec f acc depth = function
    | Value (n) :: xs -> f (n+acc) depth xs
    | Item  (x) :: xs -> f acc (depth) xs + f 0 (depth+1) x
    | []              -> acc * depth
  in
  f 0 1 lst
