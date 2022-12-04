open Batteries
open Aoc

let input_file = Aoc.arg_or "day4.txt"

let numbers_to_section lst =
  let section = BitSet.create 100 in
  List.iter (fun n -> BitSet.set section n) lst;
  section

let does_one_fully_overlap a b =
  BitSet.count (BitSet.diff a b) = 0 || BitSet.count (BitSet.diff b a) = 0

(* silver = 2 *)
let silver =
  File.lines_of input_file
  |> List.of_enum
  |> List.map (String.split_on_char ',')
  |> List.map (List.map (String.split_on_char '-'))
  |> List.map (List.map (List.map String.to_int))
  |> List.map
       (List.map (fun [ a; b ] -> List.range a `To b |> numbers_to_section))
  |> List.map (fun [ elf1; elf2 ] -> does_one_fully_overlap elf1 elf2)
  |> List.filter (fun b -> b = true)
  |> List.length

let do_overlap a b =
  let tmp = BitSet.copy a in
  BitSet.differentiate a b;
  BitSet.equal a tmp

(* gold = 4 *)
let gold =
  File.lines_of input_file
  |> List.of_enum
  |> List.map (String.split_on_char ',')
  |> List.map (List.map (String.split_on_char '-'))
  |> List.map (List.map (List.map String.to_int))
  |> List.map
       (List.map (fun [ a; b ] -> List.range a `To b |> numbers_to_section))
  |> List.map (fun [ elf1; elf2 ] -> do_overlap elf1 elf2)
  |> List.filter (fun b -> b = false)
  |> List.length

let main = Aoc.print_results silver gold
