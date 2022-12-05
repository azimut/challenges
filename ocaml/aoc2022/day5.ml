open! Batteries

let input_file = Aoc.arg_or "day5.txt"

type movement = { qty : int; src : int; dst : int }

let movements file =
  File.with_file_in file IO.read_all
  |> String.split_on_string ~by:"\n\n"
  |> List.last
  |> String.trim
  |> String.split_on_char '\n'
  |> List.map (fun s ->
         Scanf.sscanf s "move %d from %d to %d" (fun qty src dst ->
             { qty; src; dst }))

let crane_9000_popper stack n =
  let ret = ref [] in
  for i = 0 to n - 1 do
    ret := Stack.pop stack :: !ret
  done;
  !ret |> List.rev

let pusher stack = List.iter (fun e -> Stack.push e stack)

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

let silver () =
  let stacks = input_stacks () in
  movements input_file
  |> List.iter (fun m ->
         let src_stack = List.at stacks (m.src - 1) in
         let dst_stack = List.at stacks (m.dst - 1) in
         let to_move = crane_9000_popper src_stack m.qty in
         pusher dst_stack to_move);
  stacks
  |> List.mapi (fun i s ->
         if Stack.length s != 0 then Printf.printf "%d: %c\n" i (Stack.top s)
         else Printf.printf "%d:\n" i)

let crane_9001_popper stack n =
  let ret = ref [] in
  for i = 0 to n - 1 do
    ret := Stack.pop stack :: !ret
  done;
  !ret

let gold () =
  let stacks = input_stacks () in
  movements input_file
  |> List.iter (fun m ->
         let src_stack = List.at stacks (m.src - 1) in
         let dst_stack = List.at stacks (m.dst - 1) in
         let to_move = crane_9001_popper src_stack m.qty in
         pusher dst_stack to_move);
  stacks
  |> List.mapi (fun i s ->
         if Stack.length s != 0 then Printf.printf "%d: %c\n" i (Stack.top s)
         else Printf.printf "%d:\n" i)
