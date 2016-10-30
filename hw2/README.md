# Parse Prefix

Write a function *parse_prefix gram* that returns a matcher for the grammar *gram*. When applied to an acceptor accept and a fragment frag, the matcher must return the first acceptable match of a prefix of frag, by trying the grammar rules in order; A match is considered to be acceptable if accept succeeds when given a derivation and the suffix fragment that immediately follows the matching prefix. When this happens, the matcher returns whatever the acceptor returned. If no acceptable match is found, the matcher returns None.

Homework / project description: http://web.cs.ucla.edu/classes/fall16/cs131/hw/hw2.html
