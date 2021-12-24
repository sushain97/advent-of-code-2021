cat(crookshanks).

main :-
    argument_value(1, Filename),
    open("/Users/sushain/stripe/advent-of-code-2021/test.prolog", read, File),
    read_lines(File, Lines),
    close(File),
    write(Lines), nl.

read_lines(File,[]) :- 
    at_end_of_stream(File).

read_lines(File, [X|L]) :-
    \+ at_end_of_stream(File),
    get_char(File,X),
    read_lines(File,L).
