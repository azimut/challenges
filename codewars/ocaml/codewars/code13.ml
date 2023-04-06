(* https://www.codewars.com/kata/5556282156230d0e5e000089/train/ocaml

   DeoxyriboNucleic acid, DNA is the primary information storage
   molecule in biological systems. It is composed of 4(four) nucleic acid
   bases Guanine ('G'), Cytosine ('C'), Adenine ('A'), and Thymine
   ('T').

   Ribonucleic acid, RNA, is the primary messenger molecule in
   cells. RNA differs slightly from DNA its chemical structure and
   contains no Thymine. In RNA Thymine is replaced by another nucleic
   acid Uracil ('U').

   Create a function which translates a given DNA string into RNA.

   For example:

   "GCAT" => "GCAU"

   The input string can be of arbitrary length - in particular, it may
   be empty. All input is guaranteed to be valid, i.e. each input
   string will only ever consist of 'G', 'C', 'A' and/or 'T'.
*)

let dna_to_rna str = String.map (function 'T' -> 'U' | c -> c) str

module Tests = struct
  open OUnit

  let test_with str expected =
    assert_equal expected (dna_to_rna str)
      ~msg:(Printf.sprintf "dna_to_rna %s" str) ~printer:(fun s -> s)

  let suite =
    [
      "Test Suite"
      >::: [
             ( "Basic Tests" >:: fun _ ->
               test_with "TTTT" "UUUU";
               test_with "GCAT" "GCAU";
               test_with "" "";
               test_with "T" "U";
               test_with "GACCGCCGCC" "GACCGCCGCC";
               test_with "GATTCCACCGACTTCCCAAGTACCGGAAGCGCGACCAACTCGCACAGC"
                 "GAUUCCACCGACUUCCCAAGUACCGGAAGCGCGACCAACUCGCACAGC";
               test_with
                 "CACGACATACGGAGCAGCGCACGGTTAGTACAGCTGTCGGTGAACTCCATGACA"
                 "CACGACAUACGGAGCAGCGCACGGUUAGUACAGCUGUCGGUGAACUCCAUGACA";
               test_with
                 "CACGACATACGGAGCAGCGCACGGTTAGTACAGCTGTCGGTGAACTCCATGACA"
                 "CACGACAUACGGAGCAGCGCACGGUUAGUACAGCUGUCGGUGAACUCCAUGACA";
               test_with
                 "AACCCTGTCCACCAGTAACGTAGGCCGACGGGAAAAATAAACGATCTGTCAATG"
                 "AACCCUGUCCACCAGUAACGUAGGCCGACGGGAAAAAUAAACGAUCUGUCAAUG" );
           ];
    ]
end
