(* https://www.codewars.com/kata/55ab4f980f2d576c070000f4/train/ocaml *)
(* Solution: took from https://www.sitepoint.com/community/t/need-explanation-on-a-coding-challenge/367827/8 *)

let game (n : int) : string =
  match n mod 2 with
  | 0 -> Printf.sprintf "[%d]" @@ Float.(to_int (div (pow (of_int n) 2.) 2.))
  | _ -> Printf.sprintf "[%d,2]" @@ (n * n)

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
               testing 5014 "[12570098]";
               (* Took from after *)
               testing 0 "[0]";
               testing 1 "[1,2]";
               testing 101 "[10201,2]" );
           ];
    ]
end

let _ = List.map OUnit.run_test_tt_main Tests.suite
