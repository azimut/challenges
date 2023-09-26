type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree

let rec in_order = function
  | Leaf -> []
  | Node (x, left, right) ->
     in_order left @ [x] @ in_order right

let rec pre_order = function
  | Leaf -> []
  | Node (x, left, right) ->
     [x] @ pre_order left @ pre_order right

let rec post_order = function
  | Leaf -> []
  | Node (x, left, right) ->
     post_order left @ post_order right @ [x]

let atree =
  Node(10,
       Node(5,
            Node(2,
                 Node(1, Leaf, Leaf),
                 Leaf),
            Node(5, Leaf, Leaf)),
       Node(15,
            Leaf,
            Node(22, Leaf, Leaf)))
