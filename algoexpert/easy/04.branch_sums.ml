type tree =
  | Leaf
  | Node of int * tree * tree

(* Note: Is a BST but root node is the minium *)
let atree =
  Node (1,
        Node(2,
             Node(4,
                  Node(8,Leaf,Leaf),
                  Node(9,Leaf,Leaf)),
             Node(5,
                  Node(10,Leaf,Leaf),
                  Leaf)),
        Node(3,
             Node(6,Leaf,Leaf),
             Node(7,Leaf,Leaf)))

(* O(n) time *)
(* O(N) space*)
(* returns a list of a the sums of all the values
   in each branch in a BST *)
let rec branch_sums tree sum sums =
  match tree with
  | Leaf ->
     sums
  | Node(value, Leaf, Leaf) ->
     (value + sum) :: sums
  | Node(value, left, right) ->
     branch_sums left (value + sum) []
     @ branch_sums right (value + sum) []

let _ = branch_sums atree 0 []
