# Fixpoints and grammar filters

Blind-alley rules is grammar rules for which it is impossible to derive a string of terminal symbols.

A symbol used in a grammar. It can be either a nonterminal symbol or a terminal symbol; each kind of symbol has a value, whose type is arbitrary. A symbol has the following OCaml type:
```
type ('nonterminal, 'terminal) symbol =
  | N of 'nonterminal
  | T of 'terminal
```

Write a function *filter_blind_alleys g* that returns a copy of the grammar g with all blind-alley rules removed. This function should preserve the order of rules: that is, all rules that are returned should be in the same order as the rules in g.

Homework / project description: http://web.cs.ucla.edu/classes/fall16/cs131/hw/hw1.html
