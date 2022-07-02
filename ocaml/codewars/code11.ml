(* https://www.codewars.com/kata/55ab4f980f2d576c070000f4/train/ocaml *)

(*
1 2 3 4 5 6 7 8
2 3 4 5 6 7 8 9

1 2 3 4 5 6 7 8
3 4 5 6 7 8 9 10
*)

(* :string *)

let makeRow (nRow : int) (width : int) =
  List.init width (fun i -> (i + 1, i + nRow))

let game (n : int) =
  List.init n (fun r -> makeRow (r + 2) (n + 1))
  |> List.concat
  |> List.map (fun (n, d) -> Float.of_int n /. Float.of_int d)
  |> List.fold_left ( +. ) 0.

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
