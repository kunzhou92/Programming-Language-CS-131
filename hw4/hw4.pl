/* audio recordings convert to morese code */
signal([1], '.').
signal([1, 1, 1], -).
signal([0], (',')).
signal([0, 0, 0], (^)).
signal([0, 0, 0, 0, 0, 0, 0], '#').

/* ambiguous audio recordings convert to normal recordings */
convert([1], [1]).
convert([1, 1], [1]).
convert([1, 1], [1, 1, 1]).
convert([1, 1, 1], [1, 1, 1]).
convert([1, 1, 1| X], [1, 1, 1]) :-
  X \= [],
  convert([1, 1| X], [1, 1, 1]).
convert([0], [0]).
convert([0, 0], [0]).
convert([0, 0], [0, 0, 0]).
convert([0, 0, 0], [0, 0, 0]).
convert([0, 0, 0, 0], [0, 0, 0]).
convert([0, 0, 0, 0, 0], [0, 0, 0]).
convert([0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0]).
convert([0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0]).
convert([0, 0, 0, 0, 0, 0| X], [0, 0, 0, 0, 0, 0, 0]) :-
  X \= [],
  convert([0, 0, 0, 0, 0| X], [0, 0, 0, 0, 0, 0, 0]).

/* split recordings into a sequence of 1's and tail */
take_1([0| Tail], [], [0| Tail]).
take_1([], [], []).
take_1([1| X], Head, Tail) :-
  take_1(X, Head2, Tail2),
  Head = [1|Head2],
  Tail = Tail2.

/* split recordings into a sequence of 0's and tail */
take_0([1| Tail], [], [1| Tail]).
take_0([], [], []).
take_0([0| X], Head, Tail) :-
  take_0(X, Head2, Tail2),
  Head = [0|Head2],
  Tail = Tail2.

/* recordings convert to a primary list of morse codes which contains ','*/
signal_morse_help([], []).
signal_morse_help([1|Rest], M) :-
  take_1([1|Rest], Head, Tail),
  convert(Head, Ahead),
  signal(Ahead, Symbol),
  signal_morse_help(Tail, M2),
  M = [Symbol| M2].
signal_morse_help([0|Rest], M) :-
  take_0([0|Rest], Head, Tail),
  convert(Head, Ahead),
  signal(Ahead, Symbol),
  signal_morse_help(Tail, M2),
  M = [Symbol| M2].

/* filter comma in a list of morse codes*/
filter([], []).
filter([H| T], Y) :-
  H = (','),
  filter(T, Y2),
  Y = Y2.
filter([H| T], Y) :-
  H \= (','),
  filter(T, Y2),
  Y = [H| Y2].

signal_morse(X, M) :-
  signal_morse_help(X, M2),
  filter(M2, M).


/*-------pat2--------*/
morse(a, [.,-]).           % A
morse(b, [-,.,.,.]).	   % B
morse(c, [-,.,-,.]).	   % C
morse(d, [-,.,.]).	   % D
morse(e, [.]).		   % E
morse('e''', [.,.,-,.,.]). % É (accented E)
morse(f, [.,.,-,.]).	   % F
morse(g, [-,-,.]).	   % G
morse(h, [.,.,.,.]).	   % H
morse(i, [.,.]).	   % I
morse(j, [.,-,-,-]).	   % J
morse(k, [-,.,-]).	   % K or invitation to transmit
morse(l, [.,-,.,.]).	   % L
morse(m, [-,-]).	   % M
morse(n, [-,.]).	   % N
morse(o, [-,-,-]).	   % O
morse(p, [.,-,-,.]).	   % P
morse(q, [-,-,.,-]).	   % Q
morse(r, [.,-,.]).	   % R
morse(s, [.,.,.]).	   % S
morse(t, [-]).	 	   % T
morse(u, [.,.,-]).	   % U
morse(v, [.,.,.,-]).	   % V
morse(w, [.,-,-]).	   % W
morse(x, [-,.,.,-]).	   % X or multiplication sign
morse(y, [-,.,-,-]).	   % Y
morse(z, [-,-,.,.]).	   % Z
morse(0, [-,-,-,-,-]).	   % 0
morse(1, [.,-,-,-,-]).	   % 1
morse(2, [.,.,-,-,-]).	   % 2
morse(3, [.,.,.,-,-]).	   % 3
morse(4, [.,.,.,.,-]).	   % 4
morse(5, [.,.,.,.,.]).	   % 5
morse(6, [-,.,.,.,.]).	   % 6
morse(7, [-,-,.,.,.]).	   % 7
morse(8, [-,-,-,.,.]).	   % 8
morse(9, [-,-,-,-,.]).	   % 9
morse(., [.,-,.,-,.,-]).   % . (period)
morse(',', [-,-,.,.,-,-]). % , (comma)
morse(:, [-,-,-,.,.,.]).   % : (colon or division sign)
morse(?, [.,.,-,-,.,.]).   % ? (question mark)
morse('''',[.,-,-,-,-,.]). % ' (apostrophe)
morse(-, [-,.,.,.,.,-]).   % - (hyphen or dash or subtraction sign)
morse(/, [-,.,.,-,.]).     % / (fraction bar or division sign)
morse('(', [-,.,-,-,.]).   % ( (left-hand bracket or parenthesis)
morse(')', [-,.,-,-,.,-]). % ) (right-hand bracket or parenthesis)
morse('"', [.,-,.,.,-,.]). % " (inverted commas or quotation marks)
morse(=, [-,.,.,.,-]).     % = (double hyphen)
morse(+, [.,-,.,-,.]).     % + (cross or addition sign)
morse(@, [.,-,-,.,-,.]).   % @ (commercial at)

% Error.
morse(error, [.,.,.,.,.,.,.,.]). % error - see below

% Prosigns.
morse(as, [.,-,.,.,.]).          % AS (wait A Second)
morse(ct, [-,.,-,.,-]).          % CT (starting signal, Copy This)
morse(sk, [.,.,.,-,.,-]).        % SK (end of work, Silent Key)
morse(sn, [.,.,.,-,.]).          % SN (understood, Sho' 'Nuff)



/*
* a list of morse codes split into a piece of morses codes
*  which forms a letter and tail
*/
first_letter([], [], []).
first_letter(['#'|T], ['#'], T).
first_letter([(^)| T], Morse, Rest) :-
  first_letter(T, Morse, Rest).
first_letter([H1], Morse, Rest) :-
  H1 \= (^), H1 \= '#',
  Morse = [H1],
  Rest = [].
first_letter([H1, (^)|T], Morse, Rest) :-
  H1 \= (^), H1 \= '#',
  Morse = [H1],
  Rest = T.
first_letter([H1, '#'|T], Morse, Rest) :-
  H1 \= (^), H1 \= '#',
  Morse = [H1],
  Rest = ['#'| T].
first_letter([H1, H2|T], Morse, Rest) :-
  H1 \= (^), H1 \= '#',
  H2 \= (^), H2 \= '#',
  first_letter([H2| T], Morse2, Rest),
  Morse = [H1| Morse2].

/* convert a list morese codes into primary message*/
morse_message([], []).
morse_message([^], []).
morse_message(X, M) :-
  first_letter(X, Morse, Rest),
  Morse \= '#',
  morse(Word, Morse),
  morse_message(Rest, M2),
  M = [Word| M2].
morse_message(X, M) :-
  first_letter(X, Morse, Rest),
  Morse = [#],
  morse_message(Rest, M2),
  M = ['#'| M2].

/* convert audio recordings into primary message*/
pre_morse_signal(X, M) :-
  signal_morse(X, M2),
  morse_message(M2, M).

/* take the first word from primary message*/
take_first_word([], [], []).
take_first_word([error|T], [error], T).
take_first_word([H], Word, []) :-
  H \= error,
  Word = [H].
take_first_word([H1, H2| T], Word, Rest) :-
  (H1 \= error, H2 = '#';
  H1 \= error, H1 \= '#', H2 \= error, H2 \= '#'),
  take_first_word([H2| T], Word2, Rest),
  Word = [H1| Word2].
take_first_word([H1, H2| T], Word, Rest) :-
  H1 = '#',
  H2 \= error, H2 \= '#',
  Word = [H1],
  Rest = [H2|T].
take_first_word([H1, H2| T], Word, Rest) :-
  H1 \= error,
  H2 = error,
  Word = [H1, H2],
  Rest = T.

/* get the last letter of the word*/
last_letter([X], X).
last_letter([_|T], Letter) :-
  T \= [],
  last_letter(T, Letter).

/* append two lists*/
append_([], L2, L2).
append_([H|T], L2, L3) :-
  append(T, L2, SubL3),
  L3 = [H|SubL3].

/*
*  implementation finds a word, followed by zero or more spaces,
*  followed by an error token, it should omit the word, the spaces,
*  and the error token
*/
filter_all_error([], []).
filter_all_error(X, M) :-
  X \= [],
  take_first_word(X, [WordH| WordT], Rest),
  [WordH| WordT] \= [error],
  last_letter([WordH| WordT], Letter),
  Letter = error,
  WordH \= '#',
  filter_all_error(Rest, M).

 filter_all_error(X, M) :-
   X \= [],
   take_first_word(X, [WordH| WordT], Rest),
   [WordH| WordT] \= [error],
   last_letter([WordH| WordT], Letter),
   (Letter \= error; Letter = error, WordH = '#'),
   filter_all_error(Rest, M2),
   append([WordH| WordT], M2, M).


filter_all_error(X, M) :-
  X \= [],
  take_first_word(X, Word, Rest),
  Word = [error],
  filter_all_error(Rest, M2),
  append(Word, M2, M).

/* convert recordings into final message */
signal_message(X, M):-
  pre_morse_signal(X, M2),
  filter_all_error(M2, M).
