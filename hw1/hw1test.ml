(*question 1*)
let my_subset_test0 = not (subset [1;2] [2;3;4;])
let my_subset_test1 = subset [1;2;3;3] [1;2;3;4;5]

(*question 2*)
let my_equal_sets_test0 = equal_sets [] []
let my_equal_sets_test1 = equal_sets ["a"; "a"; "b"] ["a"; "b"; "b"]

(*question 3*)
let my_set_union_test0 = equal_sets (set_union [] [])  []
let my_set_union_test1 = equal_sets (set_union [] ["a"; "b"])  ["a"; "b"]

(*question 4*)
let my_set_intersection_test0 = equal_sets (set_intersection  [] [])  []
let my_set_intersection_test1 = equal_sets (set_intersection ["a"] ["a"; "b"]) ["a"]

(*question 5*)
let my_set_diff_test0 = equal_sets (set_diff [] []) []
let my_set_diff_test1 = equal_sets (set_diff ["a"] ["a"; "b"]) []

(*question 6*)
let my_computed_fixed_point_test0 =
  let temp = (computed_fixed_point (fun x y -> abs_float (x -. y) < 0.00001)
                                   (fun x -> x *. x -. x +. 1.)
                                   0.4)
  in
  temp > 0.99 && temp <= 1.0

(* question 7 *)
let my_computed_periodic_point_test0 =
 (computed_periodic_point (=) (fun x -> 1. -. x *. x) 2 0.5) = 1.

(*question8 *)
let my_while_away_test0 = (while_away (fun x -> 2 * x) ((>) 10) 11) = []
let my_while_away_test1 = (while_away (fun x -> 2 * x) ((>) 10) 1) = [1;2;4;8]

(*question 9*)
let my_rle_decode_test0 = (rle_decode [0, "a"]) = []
let my_rle_decode_test1 = (rle_decode [1, 2; 3, 4; 5, 6]) = [2;4;4;4;6;6;6;6;6;]

(*question 10*)
type nonterminals = Conversation | Sentence | Quiet | Grunt | Shout | Snore

let rules = [ Conversation, [N Snore];
              Conversation, [N Sentence; T ","; N Conversation];
              Sentence, [N Quiet];
              Sentence, [N Grunt];
              Sentence, [N Shout];
              Quiet, [];
              Grunt, [N Shout];
              Shout, [T "good"]]

let grammar = Conversation, rules ;;
let my_filter_blind_alleys_test0 = filter_blind_alleys grammar =
  (Conversation, [Sentence, [N Quiet];
                  Sentence, [N Grunt];
                  Sentence, [N Shout];
                  Quiet, [];
                  Grunt, [N Shout];
                  Shout, [T "good"]])
