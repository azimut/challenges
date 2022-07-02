(* https://www.codewars.com/kata/52bc74d4ac05d0945d00054e *)

let char_counts (chars : char list) : (char * int) list =
  List.fold_left (fun acc char ->
         let key = Char.lowercase_ascii char in
         match List.assoc_opt key acc with
         | None   -> (key,1)   :: acc
         | Some i -> (key,i+1) :: List.remove_assoc key acc)
       [] chars
  |> List.filter (fun (_,v) -> v = 1)

let first_non_repeating_letter s : char option =
  let chars = s |> String.to_seq |> List.of_seq in
  let counts = char_counts chars in
  List.find_opt (fun c ->
      List.mem_assoc (Char.lowercase_ascii c) counts)
    chars

module Tests = struct
  open OUnit
  let suite = [
      "Simple Tests" >:::
        [
          "a" >:: (fun _ ->
            assert_equal (first_non_repeating_letter "a") (Some 'a')
          );
          "stress" >:: (fun _ ->
            assert_equal (first_non_repeating_letter "stress") (Some 't');
          );
          "moonmen" >:: (fun _ ->
            assert_equal (first_non_repeating_letter "moonmen") (Some 'e');
          )
        ]
    ]
end
let _ = List.map OUnit.run_test_tt_main Tests.suite
