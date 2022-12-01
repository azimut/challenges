open Batteries

let silver =
  File.with_file_in "aoc2022/day1.txt" IO.read_all
  |> String.split_on_string ~by:"\n\n"
  |> List.map (String.split_on_char '\n')
  |> List.map (List.map (fun s -> try int_of_string s with _ -> 0))
  |> List.map (List.reduce ( + ))
  |> List.max

let gold =
  File.with_file_in "aoc2022/day1.txt" IO.read_all
  |> String.split_on_string ~by:"\n\n"
  |> List.map (String.split_on_char '\n')
  |> List.map (List.map (fun s -> try int_of_string s with _ -> 0))
  |> List.map (List.reduce ( + ))
  |> List.sort compare |> List.rev |> List.take 3 |> List.reduce ( + )

let main = Printf.printf "silver: %d gold: %d\n" silver gold
