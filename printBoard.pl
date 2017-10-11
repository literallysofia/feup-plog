initialBoard([
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]
]).

midBoard([
[empty,empty,empty,empty,white,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,red,empty],
[empty,white,empty,empty,empty,empty,empty,empty,white,empty,empty],
[empty,empty,empty,empty,empty,white,empty,empty,white,empty,empty],
[empty,empty,empty,black,empty,black,black,black,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,white,empty,empty],
[empty,empty,empty,black,empty,white,empty,empty,empty,empty,empty],
[empty,empty,empty,black,empty,red,black,empty,empty,empty,empty],
[empty,black,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,black,empty,empty,empty,empty,empty,white,empty,empty]
]).

finalBoard([
[empty,empty,empty,empty,white,empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,white,empty,empty,empty,empty,empty,empty],
[empty,white,empty,empty,empty,empty,empty,empty,white,empty,empty],
[empty,empty,empty,black,empty,white,empty,empty,white,empty,empty],
[empty,empty,empty,black,empty,black,black,black,empty,empty,empty],
[empty,empty,empty,black,empty,empty,empty,empty,white,empty,empty],
[empty,empty,empty,black,empty,white,empty,empty,empty,empty,empty],
[empty,empty, red,black,empty,empty,black,empty,white,empty,empty],
[white,black,empty,empty,empty,empty,empty,empty,empty, red,empty],
[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],
[empty,empty,black,empty,empty,empty,empty,empty,white,empty,empty]
]).


translate(empty,T) :- T='.'.
translate(black,T) :- T='B'.
translate(white,T) :- T='W'.
translate(red,T) :- T='*'.
translate(A,T) :- T=A.

/*print board*/
printBoard :-
    midBoard(X),
    printBoard(X).

printBoard([Head|Tail]) :-
    write('|'),
    printLine(Head),
    nl,
    printBoard(Tail).
printBoard([]).

/*print line */
printLine([Head|Tail]) :-
    translate(Head,T),
    write(T),
    write('|'),
    printLine(Tail).
printLine([]).
