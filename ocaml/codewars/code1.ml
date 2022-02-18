(* https://www.codewars.com/kata/54dc6f5a224c26032800005c/train/ocaml *)
(* #require "ounit2";; *)

let add_book h b =
  let code = String.sub b 0 1 in
  let qty  = String.split_on_char ' ' b |> List.rev |> List.hd |> int_of_string in
  Hashtbl.add h code qty

let print_sum h c =
  let sum = Hashtbl.find_all h c |> List.fold_left (+) 0 in
  Printf.sprintf "(%s : %d)" c sum

let stock_list (lart: string array) (lcat: string array) =
  match Array.length lart, Array.length lcat with
  | 0,_ | _,0 -> ""
  | _ -> let hash = Hashtbl.create 23 in
        lart |> Array.iter (fun book -> add_book hash book);
        lcat |> Array.to_list |> List.map (fun s -> print_sum hash s) |> String.concat " - "

module Tests = struct(*37*)
  open OUnit
  let testing(lart: string array) (lcat: string array) (expectedOutput: string) =
    let act = stock_list lart lcat in
    print_string "input: ";
    let slart = lart |> Array.to_list |> String.concat ","
    and slcat = lcat |> Array.to_list |> String.concat "," in
    print_string(slart);
    print_string ";\n";
    print_string(slcat);
    print_string ";\n";
    print_string "Expected: "; print_string(expectedOutput); print_endline "\n got ";
    print_string(act); print_endline "\n-----"; print_endline "";
    assert_equal expectedOutput act;;

  let suite = [
      "stock_list" >:::
        [
          "Basic tests" >:: (fun _ ->
            let b = [|"BBAR 150"; "CDXE 515"; "BKWR 250"; "BTSQ 890"; "DRTY 600"|] in
            let c = [|"A"; "B"; "C"; "D"|] in (*87*)
            let res = "(A : 0) - (B : 1290) - (C : 515) - (D : 600)" in
            testing b c res;
            let b = [|"ABAR 200"; "CDXE 500"; "BKWR 250"; "BTSQ 890"; "DRTY 600"|] in
            let c = [|"A"; "B"|] in
            let res = "(A : 200) - (B : 1140)" in
            testing b c res;
          );
        ]
    ]
  ;;
end
