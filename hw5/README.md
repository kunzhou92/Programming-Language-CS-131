# Listdiffs

A *listdiff* is a pair whose car is L and whose cdr is eq? to either L, or to (cdr L), or to (cdr (cdr L))), etc. The cdr of a listdiff need not be a list; it may be any object.

*Listdiffs* are intended to be efficient representations for sublists. Normally if you want to represent a sublist of length N nondestructively, you must invoke cons N times to copy the N pairs in the sublist. However, with a listdiff you must invoke cons only once, to create the pair whose car is the first element of the sublist and whose cdr is the first element after the end of the sublist.

Homework / project description: http://web.cs.ucla.edu/classes/fall16/cs131/hw/hw5.html
