(* https://www.codewars.com/kata/573992c724fc289553000e95/train/ocaml *)

(* Input: digit *)
(* Output: "smallest_number index_took index_place" *)
(* let ndigits (n: int) = n |> float_of_int |> log10 |> (+.) 1. |> floor |> int_of_float in *)

let smallest(sn: string)= (* : string = *)
  let module S = BatString in
  let module L = BatList in
  let rec find_from_idx i = function
    | []     -> None
    | hd::tl -> if (min hd (L.min tl)) = hd
                then find_from_idx (i+1) tl
                else Some i
  in
  let digits = sn |> S.to_list in
  let from_idx = digits |> find_from_idx 0 in
  let to_replace = match from_idx with
    | None -> 0
    | Some fx -> digits |> L.(drop fx |> min) in
  [from_idx; to_replace]

module Tests = struct
  open OUnit
  open Printf
  let testing (s: string)(expectedOutput: string) =
    let act = smallest s in
    print_string "input "; print_string s;
    print_string "\n";
    print_string "Expected "; print_string expectedOutput; print_endline "\n got ";
    print_string act; print_endline "\n-----"; print_endline "";
    assert_equal expectedOutput act;;
  let suite = [
      "smallest" >:::
        [
          "Basic tests" >:: (fun _ ->
            testing  "261_235" "126_235 2 0";
            testing  "209_917"  "29_917 0 1";
            testing  "285_365" "238_565 3 1";
            testing  "269_045"  "26_945 3 0";
            testing  "296_837" "239_687 4 1";
          );
        ]
    ]
end
