let snd_opt lst = List.nth_opt lst 1

module Aoc = struct
  let arg_or default =
    Sys.argv |> Array.to_list |> snd_opt |> Option.value ~default
end
