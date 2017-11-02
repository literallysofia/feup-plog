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

letter(1, L) :-L='A'.
letter(2, L) :-L='B'.
letter(3, L) :-L='C'.
letter(4, L) :-L='D'.
letter(5, L) :-L='E'.
letter(6, L) :-L='F'.
letter(7, L) :-L='G'.
letter(8, L) :-L='H'.
letter(9, L) :-L='I'.
letter(10, L) :-L='J'.
letter(11, L) :-L='K'.

number('A', N) :-N=1.
number('B', N) :-N=2.
number('C', N) :-N=3.
number('D', N) :-N=4.
number('E', N) :-N=5.
number('F', N) :-N=6.
number('G', N) :-N=7.
number('H', N) :-N=8.
number('I', N) :-N=9.
number('J', N) :-N=10.
number('K', N) :-N=11.

number(_, _) :-
    write('Invalid input\n').


/*print board*/
printBoard(X) :-
    write('  | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11|\n'),
    write('--|---|---|---|---|---|---|---|---|---|---|---|\n'),
    printBoard(X,1).

printBoard([],12).
printBoard([Head|Tail],N) :-
    letter(N,L),
    write(L),
    N1 is N+1,
    write(' | '),
    printLine(Head),
    nl,
    printBoard(Tail,N1).


/*print line */
printLine([Head|Tail]) :-
    symbol(Head,S),
    write(S),
    write(' | '),
    printLine(Tail).
printLine([]).
