type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree

(* after hearing the explaination, before seeing code *)
let middle = function
  | [] -> None
  | xs -> Some List.(nth xs (length xs / 2))

let left xs =
  match middle xs with
  | Some middle -> List.filter ((>) middle) xs
  | None        -> []

let right xs =
  match middle xs with
  | Some middle -> List.filter ((<) middle) xs
  | None        -> []

let rec min_height xs =
  match middle xs with
  | Some mid ->
     Node (mid, min_height (left xs), min_height (right xs))
  | None     ->
     Leaf

let flat_tree = [1;2;5;7;10;13;14;15;22]
let possible_tree =
  Node(10,
       Node(2,
            Node(1, Leaf, Leaf),
            Node(5,
                 Leaf,
                 Node(7, Leaf, Leaf))),
       Node(14,
            Node(13, Leaf, Leaf),
            Node(15,
                 Leaf,
                 Node(22, Leaf, Leaf))))
