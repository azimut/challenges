type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree

let rec insert value = function
  | Leaf -> Node (value, Leaf, Leaf)
  | Node (hay,left,right) ->
     match compare value hay with
     | 0|1 -> Node (hay, left, (insert value right))
     | _   -> Node (hay, (insert value left), right)

let rec contains needle = function
  | Leaf ->
     false
  | Node (hay,_,_) when hay = needle ->
     true
  | Node (_, left, right) ->
     contains needle left || contains needle right

let rec smallest = function
  | Leaf                  -> failwith "empty tree"
  | Node (value, Leaf, _) -> value
  | Node (_, left, _)     -> smallest left

let rec remove needle = function
  | Leaf -> Leaf
  | Node (hay, Leaf, Leaf) when hay = needle -> Leaf
  | Node (hay, (Node _ as left), (Node _ as right))
       when hay = needle ->
     let small = smallest right in
     Node (small, left, remove small right)
  | Node (pv, l, Node (hay, Leaf, (Node _ as r)))
    | Node (pv, l, Node (hay, (Node _ as r), Leaf))
       when hay = needle ->
     Node (pv, l, r)
  | Node (pv, Node (hay, (Node _ as l), Leaf), r)
    | Node (pv, Node (hay, Leaf, (Node _ as l)), r)
       when hay = needle ->
     Node (pv, l, r)
  | Node (hay, left, right) ->
     Node (hay, remove needle left, remove needle right)

let atree =
  Node (12,
        Node(5,
             Node(2,
                  Node(1, Leaf, Leaf),
                  Leaf),
             Node(5, Leaf, Leaf)),
        Node(15,
             Node(13, Leaf, Node(14, Leaf, Leaf)),
             Node(22, Leaf, Leaf)))
