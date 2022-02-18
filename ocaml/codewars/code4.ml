let lines = String.split_on_char '\n'

let string_rev s =
  String.to_seq s
  |> List.of_seq
  |> List.rev
  |> List.map (String.make 1)
  |> String.concat ""

let rot(s: string): string =
  lines s
  |> List.map string_rev
  |> List.rev
  |> String.concat "\n"

let selfie_and_rot (s: string): string =
  let dots = String.(make (index s '\n') '.') in
  let normal = String.(    s |> lines |> concat @@ dots^"\n") in
  let revert = String.(rot s |> lines |> concat @@ "\n"^dots) in
  normal ^ dots ^ "\n" ^ dots ^ revert

let oper f s = f s

module Tests = struct
  open OUnit
  open Printf
  let testrot(s: string) (expectedOutput: string) =
    let act = oper rot s in
    print_string "input ";
    print_string(s);
    print_string "\n";
    print_string "Expected "; print_string(expectedOutput); print_endline "\n got ";
    print_string(act); print_endline "\n-----"; print_endline "";
    assert_equal expectedOutput act;;
  let testselfieandrot(s: string) (expectedOutput: string) =
    let act = oper selfie_and_rot s in
    print_string "input ";
    print_string(s);
    print_string "\n";
    print_string "Expected "; print_string(expectedOutput); print_endline "\n got ";
    print_string(act); print_endline "\n-----"; print_endline "";
    assert_equal expectedOutput act;;
  let suite = [
      "oper" >:::
        [
          "Basic tests oper rot" >:: (fun _ ->
            testrot
              "rkKv\ncofM\nzXkh\nflCB"
              "BClf\nhkXz\nMfoc\nvKkr";
            testrot
              "fijuoo\nCqYVct\nDrPmMJ\nerfpBA\nkWjFUG\nCVUfyL"
              "LyfUVC\nGUFjWk\nABpfre\nJMmPrD\ntcVYqC\nooujif";
          );
          "Basic tests oper selfie_and_rot" >:: (fun _ ->
            testselfieandrot
              "xZBV\njsbS\nJcpN\nfVnP"
              "xZBV....\njsbS....\nJcpN....\nfVnP....\n....PnVf\n....NpcJ\n....Sbsj\n....VBZx";
            testselfieandrot
              "uLcq\nJkuL\nYirX\nnwMB"
              "uLcq....\nJkuL....\nYirX....\nnwMB....\n....BMwn\n....XriY\n....LukJ\n....qcLu";
          );

        ]
    ]
end
