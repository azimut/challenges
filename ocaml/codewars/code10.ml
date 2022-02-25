(* https://www.codewars.com/kata/573992c724fc289553000e95/train/ocaml *)

(* Input: digit *)
(* Output: "smallest_number index_took index_place" *)


let smallest(sn: string)= (* : string = *)
  let digits = BatString.to_list sn in
  digits


let smallest(sn: string)= (* : string = *)
  let digits = BatString.to_list sn in
  digits
  |> BatList.mapi (fun i c ->
         match BatList.drop i digits |> BatList.fold_left min '9' with
         | exception Invalid_argument _ -> None
         | x when x = c                 -> None
         | min -> Some (i,min,BatList.index_of min digits))
  |> BatList.find BatOption.is_some
  |> (function
      | Some (from_idx, _, Some to_idx) ->
         Printf.sprintf "%d %d %d"
           (BatString.mapi (fun i c ->
                match i with
                | x when x = from_idx -> sn.[to_idx]
                | x when x = to_idx -> sn.[i-1]
                (* | x when x = from_idx && from_idx > to_idx -> sn.[i+1] *)
                (* | x when x = from_idx && from_idx < to_idx -> sn.[i-1] *)
                | y when (to_idx > from_idx
                          && y < to_idx
                          && y > from_idx)  -> sn.[i-1]
                | _ -> sn.[i])
              sn |> int_of_string)
           from_idx
           to_idx
      | _ -> "")

(* | x when x = from_idx -> sn.[to_idx] *)

let rec tailf f acc i = function
  | [] -> List.rev acc
  | hd::tl -> tailf f ((f i hd tl)::acc) (i+1) tl

let smallest(sn: string) = (* : string = *)
  let char2int c = int_of_char c - 48 in
  let str2list s = BatString.to_list s |> List.map char2int in
  let digits = str2list sn in
  digits
  |> tailf (fun i hd tl ->
         match List.fold_left min hd tl with
         | 9             -> None
         | m when m = hd -> None
         | n             ->
            let max_pos = List.find ((=) n) digits in
            Printf.sprintf "%d %d %d"  i max_pos
            Some (i,n))
       [] 0
  |> List.find Option.is_some

(* ????? *)
let smallest(sn: string) = (* : string = *)
  let char2int c = int_of_char c - 48 in
  let digits = BatString.to_list sn |> List.map char2int in
  digits
  |> List.mapi (fun pos_b big ->
         match BatList.findi
                 (fun pos_s m -> m < big && pos_s > pos_b) digits with
         | exception Not_found -> ""
         | (pos_s,_)           ->
            String.mapi (fun si c ->
              match si with
              | x when x = pos_s -> sn.[pos_b]
              | y when y = pos_b -> sn.[pos_s]
              | _                -> c)
              sn)

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
            testing  "261235" "126235 2 0";
            testing  "209917" "29917 0 1";
            testing  "285365" "238565 3 1";
            testing  "269045" "26945 3 0";
            testing  "296837" "239687 4 1";
          );
        ]
    ]
end
