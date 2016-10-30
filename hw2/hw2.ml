type ('nonterminal, 'terminal) symbol =
  | N of 'nonterminal
  | T of 'terminal

(*question 1*)
let rec get_right_hand_side old_rules nonterminal = 
	match old_rules with
	[] -> []
	| (x, y)::t -> if x = nonterminal 
				   then y :: (get_right_hand_side t nonterminal)
				   else (get_right_hand_side t nonterminal)
;;

let convert_grammar (x, rules) = 
	(x, get_right_hand_side rules)


(*question 2*)
let terminal_matcher terminal accept derivation frag = 
	match frag with
	[] -> None
	|h::t -> if h = terminal then accept derivation t else None
;;

let rec and_matcher right_hand_side accept rules derivation frag =
	match right_hand_side with
	[] -> accept derivation frag
	|h::t ->  (match h with
			  N x -> or_matcher x (rules x) (and_matcher t accept rules) rules derivation frag 
			  |T x -> terminal_matcher x (and_matcher t accept rules) derivation frag)

	and or_matcher nonterminal alternative_list accept rules derivation frag = 
		match alternative_list with
		[] -> None
		|h::t -> let temp = and_matcher h accept rules (derivation @ [nonterminal, h]) frag in
				 (match temp with 
				  None -> or_matcher nonterminal t accept rules derivation frag
				  |Some x -> Some x)
;;

let parse_prefix (initial_expr, rules) = 
	let matcher accept frag = 
		or_matcher initial_expr (rules initial_expr) accept rules [] frag in
		matcher
;;

