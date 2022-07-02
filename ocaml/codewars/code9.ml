(* https://www.codewars.com/kata/5547cc7dcad755e480000004/train/ocaml *)

(* S = n(a + z)/2  *)
(* n > 0
   a*b      =  sum(n) - a - b
   a*b + b  =  sum(n) - a
   b(a+1)   =  sum(n) - a
   b        = (sum(n) - a) / (a + 1)
   Output: "(a,b) (b,a)" *)

(* let remov_nb (n: int): string = *)
(*   let sum = n * (n+1) / 2 in *)
(*   BatEnum.(--) 1 n *)
(*   |> BatEnum.fold (fun acc a -> *)
(*          let b = (sum - a) / (a + 1) in *)
(*          if (sum - a) mod (a + 1) = 0 && b <= a *)
(*          then (b,a)::acc *)
(*          else acc) [] *)
(*   |> (fun l -> l @ (l |> List.rev |> List.map (fun (a,b) -> (b,a)))) *)
(*   |> List.fold_left (fun s (a,b) -> s^Printf.sprintf "(%d, %d)" a b) "" *)

(* Timeout Version *)
(* let remov_nb (n: int): string = *)
(*   let sum = n * (n+1) / 2 in *)
(*   BatEnum.(cartesian_product (1 -- n) (1 -- n)) *)
(*   |> BatEnum.filter (fun (a,b) -> (a*b)=sum-a-b) *)
(*   |> BatEnum.fold (fun s (a,b) -> s ^ Printf.sprintf "(%d, %d)" b a) "" *)

(* Stack Overflow Version *)
let remov_nb (n: int): string =
  let sum = n * (n+1) / 2 in
  let numbers = List.init n succ in
  BatList.cartesian_product numbers numbers
  |> List.filter (fun (a,b) -> (a*b)=sum-a-b)
  |> List.fold_left (fun s (a,b) -> s ^ Printf.sprintf "(%d, %d)" a b) ""

module Tests = struct
  open OUnit
  let testing(n: int) (expectedOutput: string) =
    let act = remov_nb n in
    print_string "input ";
    print_int n;
    print_string "\n";
    print_string "Expected "; print_string expectedOutput; print_endline "\n got ";
    print_string act; print_endline "\n-----"; print_endline "";
    assert_equal expectedOutput act;;
  let suite = [
      "remov_nb" >:::
        [
          "Basic tests" >:: (fun _ ->
            testing 26  "(15, 21)(21, 15)";
            testing 100  "";
            testing 37  "(21, 31)(31, 21)";
            testing 101  "(55, 91)(91, 55)";
          );
        ]
    ]
end
let _ = List.map OUnit.run_test_tt_main Tests.suite
