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


symbol(empty,S) :- S='.'.
symbol(black,S) :- S='B'.
symbol(white,S) :- S='W'.
symbol(red,S) :- S='*'.

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
    symbol(Head,S),
    write(S),
    write('|'),
    printLine(Tail).
printLine([]).
