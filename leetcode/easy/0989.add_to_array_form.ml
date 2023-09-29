
let add num lst =
  let rec f n input output =
    match input with
    | x :: xs      -> let n' = n mod 10 + x in
                      f ((n/10) + (n'/10)) xs (n' mod 10 :: output)
    | _ when n = 0 -> output
    | []           -> f (n/10) [] (n mod 10 :: output)
  in
  f num (List.rev lst) []
