open Batteries

(* silver test = 157 *)

let priority item =
  match (Char.is_letter item, Char.is_uppercase item) with
  | true, true -> Char.code item - 38
  | true, false -> Char.code item - 96
  | false, _ -> failwith "got a non letter!?"

let split2 l = List.(split_at (length l / 2) l)
let intersect2 (l1, l2) = Set.(intersect (of_list l1) (of_list l2) |> to_list)

let silver =
  File.lines_of "day3.txt"
  |> List.of_enum
  |> List.map String.explode
  |> List.map split2
  |> List.map intersect2
  |> List.flatten
  |> List.map priority
  |> List.reduce ( + )

(* https://stackoverflow.com/q/48713886 *)
let group_by_3 lst =
  let accum = ([], [], 0) in
  let f (all_groups, current_group, size) x =
    if size = 3 then (List.rev current_group :: all_groups, [ x ], 1)
    else (all_groups, x :: current_group, size + 1)
  in
  let groups, last, _ = List.fold_left f accum lst in
  List.rev (List.rev last :: groups)

let intersect3 [ l1; l2; l3 ] =
  Set.(intersect (of_list l1) (of_list l2) |> intersect (of_list l3) |> to_list)

(* gold test = 70 *)
let gold =
  File.lines_of "day3.txt"
  |> List.of_enum
  |> List.map String.explode
  |> group_by_3
  |> List.map intersect3
  |> List.flatten
  |> List.map priority
  |> List.reduce ( + )

let main = Printf.printf "silver:\t%10d\ngold:\t%10d\n" silver gold
