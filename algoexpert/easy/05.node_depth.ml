type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree

let depth_sum tree =
  let rec f depth = function
    | Leaf -> 0
    | Node (_,left,right) ->
       depth + f (depth+1) right + f (depth+1) left
  in
  f 0 tree

let atree =
  Node(1,
       Node(2,
            Node(4,
                 Node(8,Leaf,Leaf),
                 Node(9,Leaf,Leaf)),
            Node(5,Leaf,Leaf)),
       Node(3,
            Node(6,Leaf,Leaf),
            Node(7,Leaf,Leaf))
    )
