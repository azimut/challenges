type 'a tree =
  | Node of 'a * 'a tree * 'a tree
  | Leaf

let find_closest needle tree =
  let closest target a b =
    if abs(target-a) < abs(target-b) then a else b in
  let rec f needle current = function
    | Leaf -> current
    | Node (hay, left, right) ->
       if needle > hay
       then f needle (closest needle current hay) right
       else f needle (closest needle current hay) left
  in f needle Int.max_int tree

let bst =
  Node (10,
        Node(5,
             Node(2,Node(1,Leaf,Leaf),Leaf),
             Node(5,Leaf,Leaf)),
        Node(15,
             Node(13,Leaf,Node(14,Leaf,Leaf)),
             Node(22,Leaf,Leaf)))
