let rec belong_to element set =
	match set with
	[] -> false
	| h::t -> if h=element then true else belong_to element t
;;

(* question 1*)
let rec subset a b =
	match a with
	[] -> true
	| h::t ->
	if belong_to h b then subset t b else false
;;

(* question 2 *)
let equal_sets a b = (subset a b) && (subset b a)
;;

(* question 3 *)
let rec set_union a b =
	match a with
	[] -> b
	|h::t -> set_union t (h::b)
;;

(* question 4 *)
let rec set_intersection a b =
	match a with
	[] -> []
	|h::t ->
	if (belong_to h b) then h :: (set_intersection t b)
	else set_intersection t b
;;

(* question 5 *)
let rec set_diff a b =
	match a with
	[] -> []
	|h::t ->
	if (belong_to h b) then set_diff t b
	else h :: (set_diff t b)
;;

(* question 6 *)
let rec computed_fixed_point eq f x =
	let new_value = f x in
	if eq new_value x then x
	else computed_fixed_point eq f new_value
;;

(* question 7 *)
let rec fun_p f p x =
	match p with
	0 -> x
	|_ -> fun_p f (p - 1) (f x)
;;

(*
let rec computed_periodic_point eq f p x =
	match p with
	0 -> x
	|_ -> if eq x (fun_p f p x) then x
				else computed_periodic_point eq f p (f x)
;;
*)
let rec computed_periodic_point eq f p x =
	let v1 = x in
	let v2 = fun_p f p x in
	let rec help_computed_periodic_point eq f v1 v2 =
		if (eq v1 v2) then v1 else (help_computed_periodic_point eq f (f v1) (f v2))
	in
	help_computed_periodic_point eq f v1 v2
;;


(* question 8 *)
let rec while_away s p x =
	match (p x) with
	false -> []
	|true -> x :: (while_away s p (s x))
;;

(* question 9 *)
let rec pair_decode (x, y) =
 	match x with
	0 -> []
	|_ -> y :: pair_decode (x-1, y)
;;

let rec rle_decode lp =
	match lp with
	[] -> []
	|h :: t -> (pair_decode h) @ (rle_decode t)
;;

(* question 10 *)
type ('nonterminal, 'terminal) symbol =
  | N of 'nonterminal
  | T of 'terminal
;;

(* get the type of a symbol *)
let get_type x =
	match x with
	T b -> b
	|N b -> b
;;

(* determine whether a symbol (ie. N Num) is terminal or nonterminal
	 true for terminal; false for nonterminal *)
let check_terminal x =
	match x with
	N _ -> false
	| T _ -> true
;;

(* determine wheter a list of symbols (ie. [T"("; N Expr; T")"]) is
	 terminal or nonterminal true for terminal; false for nonterminal *)
let rec check_all_terminals x =
	match x with
	[] -> true
	|h::t -> (check_terminal h) && (check_all_terminals t)
;;

(* extract a list of nonterminal symbols
   ie. [T"("; N Expr; T")"] -> [N Expr] *)
let rec get_nonterminal aList =
 match aList with
 [] -> []
 |h::t ->  if (check_terminal h) then get_nonterminal t
 					else  h :: (get_nonterminal t)
;;

(* union two lists into one each element of which is unique *)
let rec set_unique_union a b =
 match a with
 [] -> b
 |h::t -> if (belong_to h b) then set_unique_union t b
 					else set_unique_union t (h::b)
;;

(* go through the whole rules once and add new terminable symbols to tList *)
let rec add_to_TList rules tList =
	match rules with
	[] -> tList
	|(x, y)::t -> let sub = get_nonterminal y in
								if not(sub = []) && (subset sub tList)
								then add_to_TList t (set_unique_union tList [N x])
								else add_to_TList t tList
;;

(* create the initial tList *)
let rec create_TList rules =
	match rules with
	[] -> [];
	|(x, y) :: t -> if (check_all_terminals y)
									then set_unique_union [N x] (create_TList t)
									else 	create_TList t
;;

(* go through the whole rules for several times and get the complete tList *)
let rec get_complete_TList rules tList =
	let new_list = add_to_TList rules tList in
	if (List.length tList) = (List.length new_list)
	then tList
	else get_complete_TList rules new_list
;;
(* filter blind alleys *)
let rec filter_rule rules tList =
 match rules with
 [] -> []
 |(x,y)::t -> if (belong_to (N x) tList) && (subset (get_nonterminal y) tList)
 							then (x,y) :: (filter_rule t tList)
							else filter_rule t tList
;;
 (* final function *)
let filter_blind_alleys g =
 	match g with
	(x, y) -> let initial_list = create_TList y in
						let tList = get_complete_TList y initial_list in
						(x ,(filter_rule y tList))
;;
