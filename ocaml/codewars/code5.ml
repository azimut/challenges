(* https://www.codewars.com/kata/541c8630095125aba6000c00/train/ocaml *)

(*     16 -> 1 + 6 = 7 *)
(*    942 -> 9 + 4 + 2 = 15  -->  1 + 5 = 6 *)
(* 132189 -> 1 + 3 + 2 + 1 + 8 + 9 = 24  -->  2 + 4 = 6 *)
(* 493193 -> 4 + 9 + 3 + 1 + 9 + 3 = 29  -->  2 + 9 = 11  -->  1 + 1 = 2 *)

(* let foo n = *)
(*   (n - 1) mod 9 + 1 *)

let digits (n: int): int list =
  let rec loop n acc =
    if n = 0 then acc
    else loop (n/10) (n mod 10 :: acc)
  in
  loop n []

let rec digital_root (n : int): int =
  match n > 9 with
  | true  -> digital_root (digits n |> List.fold_left (+) 0)
  | false -> n

module Tests = struct
  open OUnit
  let suite =
    let test_with input expected =
      let format_input = Printf.sprintf "n = %d" in
      assert_equal expected (digital_root input) ~msg:(format_input input) ~printer:string_of_int
    in [
        "Fixed tests" >:: (fun _ ->
          test_with 16 7;
          test_with 195 6;
          test_with 992 2;
          test_with 999999999 9;
          test_with 167346 9;
          test_with 0 0;
        );
      ]
end
