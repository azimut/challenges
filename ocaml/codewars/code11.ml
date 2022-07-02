(* https://www.codewars.com/kata/55ab4f980f2d576c070000f4/train/ocaml *)

(*
1 2 3 4 5 6 7 8
2 3 4 5 6 7 8 9

1 2 3 4 5 6 7 8
3 4 5 6 7 8 9 10
*)

(* :string *)

let cellValue row col = Float.of_int row /. Float.of_int (row + col)

let game (n : int) =
  let sum = ref 1.0 in
  for col = 1 to n do
    for row = 1 to n do
      sum := !sum +. cellValue row col
    done
  done;
  !sum

module Tests = struct
  open OUnit
  open Printf

  let testing (n : int) (expectedOutput : string) =
    let act = game n in
    print_string "input: ";
    print_int n;
    print_string "\n";
    print_string "Expected: ";
    print_string expectedOutput;
    print_endline "\n got: ";
    print_string act;
    print_endline "\n-----";
    print_endline "";
    assert_equal expectedOutput act

  let suite =
    [
      "game"
      >::: [
             ( "Basic tests" >:: fun _ ->
               testing 1808 "[1634432]";
               testing 5014 "[12570098]" );
           ];
    ]
end

let _ = List.map OUnit.run_test_tt_main Tests.suite
