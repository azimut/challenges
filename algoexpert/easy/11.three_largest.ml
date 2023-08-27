let solve xs =
  match List.sort (fun a b -> Int.compare b a) xs with
  | a :: b :: c :: _ -> [c;b;a]
  | _ -> failwith "too few arguments"

let _ = solve [141; 1; 17; -7; -17; -27; 18; 541; 8; 7; 7]
