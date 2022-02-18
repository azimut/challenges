(* https://www.codewars.com/kata/5667e8f4e3f572a8f2000039 *)

let accum (s:string): string =
  let stutter l n = String.(uppercase_ascii l ^ make n (get (lowercase_ascii l) 0)) in
  let butfirst s = String.(sub s 1 ((length s)-1)) in
  let rec f s acc i =
    match s with
    | "" -> acc
    | _  -> stutter (String.sub s 0 1) i
           :: f (butfirst s) acc (i+1)
  in
  f s [] 0 |> String.concat "-"

(* accum("abcd") -> "A-Bb-Ccc-Dddd" *)
(* accum("RqaEzty") -> "R-Qq-Aaa-Eeee-Zzzzz-Tttttt-Yyyyyyy" *)
(* accum("cwAt") -> "C-Ww-Aaa-Tttt" *)

module Tests = struct
  open OUnit
  open Printf
  let testAccum(s: string) (expectedOutput: string) =
    let act = accum s in
    print_string "input: ";
    print_string(s);
    print_string "\n";
    print_string "Expected: "; print_string(expectedOutput); print_endline "\n got ";
    print_string(act); print_endline "\n-----"; print_endline "";
    assert_equal expectedOutput act;;
  let suite = [
      "accum" >:::
        [
          "Basic tests" >:: (fun _ ->
            testAccum "ZpglnRxqenU" "Z-Pp-Ggg-Llll-Nnnnn-Rrrrrr-Xxxxxxx-Qqqqqqqq-Eeeeeeeee-Nnnnnnnnnn-Uuuuuuuuuuu";
            testAccum "NyffsGeyylB" "N-Yy-Fff-Ffff-Sssss-Gggggg-Eeeeeee-Yyyyyyyy-Yyyyyyyyy-Llllllllll-Bbbbbbbbbbb";
          );
        ]
    ]
end
