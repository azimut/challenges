(* https://www.codewars.com/kata/55e7280b40e1c4a06d0000aa/train/ocaml *)

(* choose_best_sum(163, 3, [50; 55; 56; 57; 58])         -> 163 *)
(* choose_best_sum(163, 3, [50])                         -> -1  *)
(* choose_best_sum(230, 3, [91; 74; 73; 85; 73; 81; 87]) -> 228 *)

(* k  =   3 max towns *)
(* t  = 174 max miles *)
(* ls =  [] distances *)
(* max distance or -1 *)

let chooseBestSum (t : int) (k : int) (ls : int list) =
  (* : int = *)
  let rec combinations = function
    | [] -> [ [] ]
    | hd :: tl ->
        let hasnt = combinations tl in
        let hasit = hasnt |> List.map @@ List.cons hd in
        List.append hasit hasnt
  in
  combinations ls
  |> List.filter (fun l -> k = List.length l)
  |> List.map (List.fold_left ( + ) 0)
  |> List.filter (( >= ) t)
  |> List.sort compare |> List.rev
  |> (fun l -> List.nth_opt l 0)
  |> Option.value ~default:(-1)

module Tests = struct
  open OUnit
  open Printf

  let print_list l = List.iter (printf "%d ") l

  let testBestSum (t : int) (k : int) (ls : int list) (expectedOutput : int) =
    let act = chooseBestSum t k ls in
    print_string "input ";
    print_int t;
    print_string "\n";
    print_int k;
    print_string "\n";
    print_list ls;
    print_string "\n";
    print_string "Expected ";
    print_int expectedOutput;
    print_endline "\n got ";
    print_int act;
    print_endline "\n-----";
    print_endline "";
    assert_equal expectedOutput act

  let suite =
    [
      "smallest"
      >::: [
             ( "Basic tests" >:: fun _ ->
               testBestSum 230 3 [ 91; 74; 73; 85; 73; 81; 87 ] 228;
               testBestSum 331 2 [ 91; 74; 73; 85; 73; 81; 87 ] 178;
               testBestSum 331 4 [ 91; 74; 73; 85; 73; 81; 87 ] 331;
               testBestSum 331 5 [ 91; 74; 73; 85; 73; 81; 87 ] (-1) );
           ];
    ]
end

let _ = List.map OUnit.run_test_tt_main Tests.suite
