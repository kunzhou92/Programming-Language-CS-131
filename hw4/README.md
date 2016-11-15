# Morse code data recovery

Morse code represents each letter using a string of . (dih) and - (dah) symbols. At the signal level, 1 (a signal-on of duration 1) represents dih, 111 (a signal-on of duration 3) represents dah, 0 (a signal-off of duration 1) separates dihs from dahs within a letter, 000 (signal-off of duration 3) represents the boundary between two letters, and 0000000 (signal-off of duration 7) represent the space between words.

First, write a Prolog predicate signal_morse/2 that converts a list of 1s and 0s to the corresponding list of .s, -s, ^s, and #s. 
Second, write a Prolog predicate signal_message/2 that converts a list of 1s and 0s to the corresponding list of letters, interpreted

Homework / project description: http://web.cs.ucla.edu/classes/fall16/cs131/hw/hw4.html
