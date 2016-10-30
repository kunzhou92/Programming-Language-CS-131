type nonterminals = Conversation | Sentence | Quiet | Grunt | Shout | Snore

let grammar1 = 
		(Conversation, 
			function
			|Conversation -> [[N Shout]; [N Sentence; T ","; N Conversation]]
            |Sentence -> [[N Quiet]; [N Grunt]; [N Shout]]
            |Quiet -> []
            |Grunt -> [[N Shout]]
            |Shout -> [[T "good"]])
             
let accept_plus derivation strings = 
	match strings with
	h::t -> if h = "+" then Some (derivation, strings) else None
	|_ -> None
;;
let grammar2 = 
		(Conversation,
			function
			|Conversation -> [[N Shout; T "bad"; N Conversation]; [N Quiet];]
			|Quiet -> [[T "good"]]
			|Shout -> [[T "good"]]
			|Sentence |Grunt -> []
		)

let test_1 = ((parse_prefix grammar1 accept_plus ["good"; ","; "good"; "+"; "2"])
				= Some
				([(Conversation, [N Sentence; T ","; N Conversation]);
					(Sentence,[N Grunt]);
					(Grunt, [N Shout]);
					(Shout, [T "good"]);
					(Conversation, [N Shout]);
					(Shout, [T "good"])]
					, ["+"; "2"])
			)
let test_2 = ((parse_prefix grammar2 accept_plus ["good"; "bad"; "good"; "+"])
				= Some
				([(Conversation, [N Shout; T "bad"; N Conversation]);
					(Shout, [T "good"]);
					(Conversation, [N Quiet]); 
					(Quiet,[T "good"])]
					, ["+"])
			)


