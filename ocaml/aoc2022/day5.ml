open! Batteries

let input_file = Aoc.arg_or "day5.test.txt"

type movement = { qty : int; src : int; dst : int }

let movements file =
  File.with_file_in file IO.read_all
  |> String.split_on_string ~by:"\n\n"
  |> List.last
  |> String.trim
  |> String.split_on_char '\n'
  |> List.map (fun s ->
         Scanf.sscanf s "move %d from %d to %d" (fun qty src dst ->
             { qty; src = src - 1; dst = dst - 1 }))

let input_stacks () =
  match input_file with
  | "day5.txt" ->
      [
        [ 'H'; 'B'; 'V'; 'W'; 'N'; 'M'; 'L'; 'P' ];
        [ 'M'; 'Q'; 'H' ];
        [ 'N'; 'D'; 'B'; 'G'; 'F'; 'Q'; 'M'; 'L' ];
        [ 'Z'; 'T'; 'F'; 'Q'; 'M'; 'W'; 'G' ];
        [ 'M'; 'T'; 'H'; 'P' ];
        [ 'C'; 'B'; 'M'; 'J'; 'D'; 'H'; 'G'; 'T' ];
        [ 'M'; 'N'; 'B'; 'F'; 'V'; 'R' ];
        [ 'P'; 'L'; 'H'; 'M'; 'R'; 'G'; 'S' ];
        [ 'P'; 'D'; 'B'; 'C'; 'N' ];
      ]
      |> List.map (fun lst -> lst |> List.enum |> Stack.of_enum)
  | "day5.test.txt" ->
      [ [ 'Z'; 'N' ]; [ 'M'; 'C'; 'D' ]; [ 'P' ] ]
      |> List.map (fun lst -> lst |> List.enum |> Stack.of_enum)
  | _ -> failwith "unknown input ????"

let popper stack n =
  let ret = ref [] in
  for i = 0 to n - 1 do
    ret := Stack.pop stack :: !ret
  done;
  !ret

let pusher stack = List.iter (fun e -> Stack.push e stack)

let silver () =
  let stacks = input_stacks () in
  movements input_file
  |> List.iter (fun m ->
         let src_stack = List.at stacks m.src in
         let dst_stack = List.at stacks m.dst in
         let to_move = popper src_stack m.qty |> List.rev in
         pusher dst_stack to_move);
  stacks
  |> List.map (fun s -> if Stack.length s = 0 then ' ' else Stack.top s)
  |> String.implode

let gold () =
  let stacks = input_stacks () in
  movements input_file
  |> List.iter (fun m ->
         let src_stack = List.at stacks m.src in
         let dst_stack = List.at stacks m.dst in
         let to_move = popper src_stack m.qty in
         pusher dst_stack to_move);
  stacks
  |> List.map (fun s -> if Stack.length s = 0 then ' ' else Stack.top s)
  |> String.implode
