open! Batteries

(*
  hidden
  tree house

  patch/grid
  tall trees

  count the N of trees visible from outside the grid
  when looking directly along a row/column

  map of tree heights
  0 = shortest
  9 = tallest

  tree is "VISIBLE" if all trees around are shorter
  - no diagonals
  - no equal (if equal does not count as visible from there)
  all trees at the border ARE VISIBLE

  OUTPUT
  How Many trees are visible?
  = 21

  PART 1 = 1801
*)

type forest = { width : int; height : int; mat : int array array }

let make_forest =
  let lines = File.lines_of "day8.txt" |> List.of_enum in
  let width = lines |> List.first |> String.length in
  let height = List.length lines in
  let mat = Array.make_matrix width height (-1) in
  let real_int_of_char c = int_of_char c - int_of_char '0' in
  for w = 0 to width - 1 do
    for h = 0 to height - 1 do
      mat.(h).(w) <-
        (let line = List.nth lines h in
         let tree = String.get line w in
         let tree_height = real_int_of_char tree in
         tree_height)
    done
  done;
  { width; height; mat }

let is_visible x y forest =
  let tree = forest.mat.(x).(y) in
  let rec is_visible_from_top h w =
    if h - 1 < 0 then true
    else
      let newtree = forest.mat.(h - 1).(w) in
      tree > newtree && is_visible_from_top (h - 1) w
  in
  let rec is_visible_from_bottom h w =
    if h + 1 > forest.height - 1 then true
    else tree > forest.mat.(h + 1).(w) && is_visible_from_bottom (h + 1) w
  in
  let rec is_visible_from_left h w =
    if w + 1 > forest.width - 1 then true
    else tree > forest.mat.(h).(w + 1) && is_visible_from_left h (w + 1)
  in
  let rec is_visible_from_right h w =
    if w - 1 < 0 then true
    else tree > forest.mat.(h).(w - 1) && is_visible_from_right h (w - 1)
  in
  is_visible_from_top x y
  || is_visible_from_bottom x y
  || is_visible_from_left x y
  || is_visible_from_right x y

let silver forest =
  let visibles_trees = ref 0 in
  (* NOTE: Works when is a square *)
  let visibles_in_the_border = (forest.width * 4) - 4 in
  for w = 1 to forest.width - 2 do
    for h = 1 to forest.height - 2 do
      if is_visible h w forest then visibles_trees := !visibles_trees + 1
    done
  done;
  !visibles_trees + visibles_in_the_border

(*
  viewing distance (of trees)
  viewing distance on the edge, at least 1 is 0(zero)
  stop if edge OR reached bigger >= tree
  - bigger still counts
  SCENIC SCORE = multiplying viewing distance of NSEW
  OUTPUT = highest scenic score for ANY tree
 *)

let scenic_score x y forest tree =
  let rec visibility_on_top h w acc =
    if h - 1 < 0 then acc
    else if tree <= forest.mat.(h - 1).(w) then acc + 1
    else visibility_on_top (h - 1) w (acc + 1)
  in
  let rec visibility_on_bottom h w acc =
    if h + 1 > forest.height - 1 then acc
    else if tree <= forest.mat.(h + 1).(w) then acc + 1
    else visibility_on_bottom (h + 1) w (acc + 1)
  in
  let rec visibility_on_left h w acc =
    if w + 1 > forest.width - 1 then acc
    else if tree <= forest.mat.(h).(w + 1) then acc + 1
    else visibility_on_left h (w + 1) (acc + 1)
  in
  let rec visibility_on_right h w acc =
    if w - 1 < 0 then acc
    else if tree <= forest.mat.(h).(w - 1) then acc + 1
    else visibility_on_right h (w - 1) (acc + 1)
  in
  visibility_on_bottom x y 0
  * visibility_on_top x y 0
  * visibility_on_left x y 0
  * visibility_on_right x y 0

let gold forest =
  let max_scenic_score = ref 0 in
  for w = 0 to forest.width - 1 do
    for h = 0 to forest.height - 1 do
      let tree = forest.mat.(h).(w) in
      let score = scenic_score h w forest tree in
      if score > !max_scenic_score then max_scenic_score := score
    done
  done;
  !max_scenic_score
