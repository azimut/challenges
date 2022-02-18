(* https://www.codewars.com/kata/5552101f47fc5178b1000050/train/ocaml *)
(* Is there an integer k such as : (a ^ p + b ^ (p+1) + c ^(p+2) + d ^ (p+3) + ...) = n * k *)
(* n and p > 0 *)
(* Return k or -1 *)

let explode (s: string) : int list =
  let char2int c = Char.(code c - code '0') in
  List.init (String.length s) (String.get s)
  |> List.map char2int

let max_k (n: int) (p: int): int =
  Printf.sprintf "%d" n
  |> explode
  |> List.mapi (fun i d -> float d ** float (p+i))
  |> List.fold_left (+.) 0.
  |> int_of_float

let dig_pow (n: int) (p: int): int =
  let res = (max_k n p) in
  if res mod n = 0 then res / n
  else -1

(* digPow(89, 1) should return 1 *)
(* digPow(92, 1) should return -1 *)
(* digPow(695, 2) should return 2 *)
(* digPow(46288, 3) should return 51 *)
(* digPow(46288, 5) should return -1 *)
