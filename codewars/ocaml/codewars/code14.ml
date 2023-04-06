(* https://www.codewars.com/kata/56ed20a2c4e5d69155000301/train/ocaml

     You are given a string of n lines, each substring being n characters
     long. For example:

     s = "abcd\nefgh\nijkl\nmnop"

     We will study the "horizontal" and the "vertical" scaling of this
     square of strings.

     A k-horizontal scaling of a string consists of replicating k times
     each character of the string (except '\n').

     Example: 2-horizontal scaling of s: => "aabbccdd\neeffgghh\niijjkkll\nmmnnoopp"

     A v-vertical scaling of a string consists of replicating v times
     each part of the squared string.

     Example: 2-vertical scaling of s: => "abcd\nabcd\nefgh\nefgh\nijkl\nijkl\nmnop\nmnop"

     Function scale(strng, k, v) will perform a k-horizontal scaling and
     a v-vertical scaling.

     Example: a = "abcd\nefgh\nijkl\nmnop"
     scale(a, 2, 3) --> "aabbccdd\naabbccdd\naabbccdd\neeffgghh\neeffgghh\neeffgghh\niijjkkll\niijjkkll\niijjkkll\nmmnnoopp\nmmnnoopp\nmmnnoopp"

   Printed:

   abcd   ----->   aabbccdd
   efgh            aabbccdd
   ijkl            aabbccdd
   mnop            eeffgghh
                   eeffgghh
                   eeffgghh
                   iijjkkll
                   iijjkkll
                   iijjkkll
                   mmnnoopp
                   mmnnoopp
                   mmnnoopp

   Task:

       Write function scale(strng, k, v) k and v will be positive integers. If strng == "" return "".
*)

let stutter n s =
  BatString.(
    fold_right
      (fun c acc -> (match c with '\n' -> "\n" | _ -> make n c) ^ acc)
      s "")

let repeat n s =
  String.split_on_char '\n' s
  |> List.map (fun row -> BatList.make n row |> BatString.join "\n")
  |> BatString.join "\n"

let scale (s : string) (hcount : int) (vcount : int) =
  if s = "" then "" else stutter hcount s |> repeat vcount

module Tests = struct
  open OUnit
  open Printf

  let testScale (s : string) (hcount : int) (vcount : int)
      (expectedOutput : string) =
    let act = scale s hcount vcount in
    print_string "input: ";
    print_string s;
    print_string "\n";
    print_int hcount;
    print_string "\n";
    print_int vcount;
    print_string "\n";
    print_string "Expected: ";
    print_string expectedOutput;
    print_endline "\n got ";
    print_string act;
    print_endline "\n-----";
    print_endline "";
    assert_equal expectedOutput act

  let suite =
    [
      "scale"
      >::: [
             ( "Basic tests" >:: fun _ ->
               testScale "Kj\nSH" 1 2 "Kj\nKj\nSH\nSH";
               testScale "lxnT\nqiut\nZZll\nFElq" 1 2
                 "lxnT\nlxnT\nqiut\nqiut\nZZll\nZZll\nFElq\nFElq";
               testScale "CG\nla" 2 3 "CCGG\nCCGG\nCCGG\nllaa\nllaa\nllaa" );
           ];
    ]
end
