
let josephus xs k =
  let rec loop xs ys i res =
    match xs,ys with
    | [],[]    -> List.rev res
    | [],_     -> loop (List.rev ys) xs i res
    | hd::tl,_ ->
       if i mod k = 0
       then loop tl      ys  (i+1) (hd::res)
       else loop tl (hd::ys) (i+1)      res
  in
  loop xs [] 1 []

module Tests = struct
  open OUnit
  let test_with string_of xs k expected=
    assert_equal expected (josephus xs k)
      ~msg: (Printf.sprintf "josephus %s %d" (String.concat "" ["[";(xs|>List.map string_of|>String.concat ";");"]"]) k)
      ~printer: (fun xs->String.concat "" ["[";(xs|>List.map string_of|>String.concat ";");"]"]);;
  let suite = [
      "josephus" >:::
        [
          "works with integers" >:: (fun _ ->
            let test_with=test_with string_of_int in
            test_with
              [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]
              1
              [1; 2; 3; 4; 5; 6; 7; 8; 9; 10];
            test_with
              [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]
              2
              [2; 4; 6; 8; 10; 3; 7; 1; 9; 5];
          );
          "works with char values" >:: (fun _ ->
            let test_with=test_with (String.make 1) in
            let chars_of=(fun s->s|>String.to_seq|>List.of_seq) in
            test_with (chars_of "CodeWars") 4 (chars_of "esWoCdra");
          );
        ]
    ]
end
