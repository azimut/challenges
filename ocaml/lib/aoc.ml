let print_results silver gold =
  Printf.printf "silver:\t%10d\ngold:\t%10d\n" silver gold

let arg_or default =
  match Sys.argv with
  | [| _; "-emacs" |] -> default
  | [| _; filename |] -> filename
  | _ -> default
