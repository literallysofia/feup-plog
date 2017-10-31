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
symbol(black,S) :- S='X'.
symbol(white,S) :- S='O'.
symbol(red,S) :- S='*'.
symbol(1, L) :-L='A'.
symbol(2, L) :-L='B'.
symbol(3, L) :-L='c'.
symbol(4, L) :-L='D'.
symbol(5, L) :-L='E'.
symbol(6, L) :-L='F'.
symbol(7, L) :-L='G'.
symbol(8, L) :-L='H'.
symbol(9, L) :-L='I'.
symbol(10, L) :-L='J'.
symbol(11, L) :-L='K'.

/*print board*/
printBoard :-
    midBoard(X),
    write('  | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11|\n'),
    write('--|---|---|---|---|---|---|---|---|---|---|---|\n'),
    printBoard(X,1).

printBoard([Head|Tail],N) :-
    symbol(N,L),
    write(L),
    N1 is N+1,
    write(' | '),
    printLine(Head),
    nl,
    printBoard(Tail,N1).
printBoard([],0).

/*print line */
printLine([Head|Tail]) :-
    symbol(Head,S),
    write(S),
    write(' | '),
    printLine(Tail).
printLine([]).
