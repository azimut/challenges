open! Batteries

(* OUTPUT:
   SUM sizes of all directories with size < 100_000
   ...counting files more than once...
*)

(* NOTE: this works because I know logs cd's to something meaninful before ls *)

type dirtree = File of string * int | Dir of string * dirtree list * int

let rec map f = function
  | Dir (dirname, x :: xs, size) ->
      f (Dir (dirname, f x :: List.map (fun x -> map f x) xs, size))
  | Dir (_, [], _) as dir -> f dir
  | File _ as file -> f file

let rec fold f acc = function
  | Dir (_, x :: xs, _) as dir ->
      f (fold f (List.fold_left (fold f) acc xs) x) dir
  | Dir (_, [], _) as dir -> f acc dir
  | File _ as file -> f acc file

let insert' at_dir new_dt old_dt =
  match old_dt with
  | Dir (name, subpaths, size) when name = at_dir ->
      Dir (name, new_dt :: subpaths, size)
  | Dir _ as dir -> dir
  | File _ as file -> file

let insert at_dir new_dt = map (insert' at_dir new_dt)

let parsed =
  File.with_file_in "day7.test.txt" IO.read_all
  |> String.trim
  |> String.split_on_char '\n'
  |> List.filter (( <> ) "$ ls")
  |> List.filter (( <> ) "$ cd ..")

let read_cd s = Scanf.sscanf s "$ cd %s" Fun.id
let read_dir s = Dir (Scanf.sscanf s "dir %s" Fun.id, [], 0)
let read_file s = Scanf.sscanf s "%d %s" (fun size name -> File (name, size))

let btest accumulator = function
  | File (_, size) -> size + accumulator
  | Dir _ -> accumulator

let update_dir_size' = function
  | Dir (name, subdirs, _) as dir -> Dir (name, subdirs, fold btest 0 dir)
  | File _ as f -> f

let init_immediate_dirsizes = map update_dir_size'

(* NOTE: this works because i know the first one is $ cd / *)
let rec silver current_dir dt lst =
  match lst with
  | "$ cd /" :: xs -> silver current_dir dt xs
  | cd :: xs when String.starts_with cd "$ cd" -> silver (read_cd cd) dt xs
  | dir :: xs when String.starts_with dir "dir " ->
      silver current_dir (insert current_dir (read_dir dir) dt) xs
  | file :: xs when Str.string_match (Str.regexp "[0-9].*") file 0 ->
      silver current_dir (insert current_dir (read_file file) dt) xs
  | [] -> dt
  | _ -> assert false
