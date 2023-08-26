(* 1 - recursive *)
let rec fib = function
  | 2 -> 1
  | 1 -> 1
  | n -> fib (n-1) + fib (n-2)

(* 2 - recursive, with hash table *)
let fib_memo n =
  let cache = Hashtbl.create 1000 in
  Hashtbl.add cache 2 1;
  Hashtbl.add cache 1 1;
  let rec f n =
    if Hashtbl.mem cache n then
      Hashtbl.find cache n
    else
      let a = f (n-1) in
      let b = f (n-2) in
      Hashtbl.add cache (n-1) a;
      Hashtbl.add cache (n-2) b;
      a + b
  in
  f n

(* 2 - recursive, with hash table *)
let fib_memo' n =
  let cache = Hashtbl.create 1000 in
  Hashtbl.add cache 2 1;
  Hashtbl.add cache 1 1;
  let rec f n =
    if Hashtbl.mem cache n then
      Hashtbl.find cache n
    else
      let a = f (n-1) + f(n-2) in
      Hashtbl.add cache n a;
      a
  in
  f n

(* 3 - iterative *)
let fib_iter n =
  let sum a = Array.fold_left (+) 0 a in
  let arr = [| 0; 1 |] in
  let tmp = ref 0 in
  for i = 3 to n do
    tmp := arr.(1);
    arr.(1) <- sum(arr);
    arr.(0) <- !tmp;
  done;
  sum arr
