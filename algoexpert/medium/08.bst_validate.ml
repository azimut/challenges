type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree

(* from the algoexpert explaination *)
let validate tree =
  let rec f min max = function
    | Node (x,_,_) when x < min || x > max ->
       false
    | Node (x, left, right) ->
       f min x left && f x max right
    | Leaf ->
       true
  in
  f Int.min_int Int.max_int tree

(* my blind solution *)
let rec validate' = function
  | Node (x, Leaf, Node (r,_,_))
       when x > r ->
     false
  | Node (x, Node (l,_,_), Leaf)
       when x <= l ->
     false
  | Node (hay, Node (lhay,_,_), Node(rhay,_,_))
       when hay <= lhay || hay > rhay ->
     false
  | Node (_, left, right) ->
     validate' left && validate' right
  | Leaf -> true

let atree =
  Node(10,
       Node(5,
            Node(2,
                 Node(1, Leaf, Leaf),
                 Leaf),
            Node(5, Leaf, Leaf)),
       Node(15,
            Node(13,
                 Leaf,
                  Node(14, Leaf, Leaf)),
            Node(22, Leaf, Leaf)))
