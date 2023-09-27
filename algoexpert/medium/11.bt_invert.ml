type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree

let rec tree_mirror = function
  | Leaf -> Leaf
  | Node (x, l, r) -> Node (x, tree_mirror r, tree_mirror l)

let atree =
  Node(1,
       Node(2,
            Node(4,
                 Node(8, Leaf, Leaf),
                 Node(9, Leaf, Leaf)),
            Node(5, Leaf, Leaf)),
       Node(3,
            Node(6, Leaf, Leaf),
            Node(7, Leaf, Leaf)))
