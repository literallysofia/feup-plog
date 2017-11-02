:- consult('display.pl').


replaceInList([_|T], 0, Value, [Value|T]).

replaceInList([H|T], Index, Value, [H|TNew]):-
        Index > 0,
        Index1 is Index-1,
        replaceInList(T,Index1, Value, TNew).


replaceInMatrix([H|T], 0, Collumn,Value, [HNew|T]):-
        replaceInList(H,Collumn,Value,HNew).

replaceInMatrix([H|T], Row, Collumn, Value, [H|TNew]):-
        Row > 0,
        Collumn > 0,
        Row1 is Row-1,
        replaceInMatrix(T, Row1, Collumn, Value, TNew).



askPlayer(X, Player,Y):-
        write('Row     '),
        read(RowLetter),
        number(RowLetter, Row),
        write('Collumn '),
        read(Collumn),
        write('\n'),
        CollumnIndex is Collumn-1,
        RowIndex is Row-1,
        replaceInMatrix(X, RowIndex, CollumnIndex, Player, Y).


move(X):-
      printBoard(X),
      write('PLAYER X\n'),
      askPlayer(X, black, Y),
      printBoard(Y),
      write('PLAYER O\n'),
      askPlayer(Y, white,Z),
      move(Z).

addWorkers(X,Z):-
      printBoard(X),
      write('Add Woker 1:\n'),
      askPlayer(X, red, Y),
      printBoard(Y),
      write('Add Worker 2:\n'),
      askPlayer(Y, red, Z).

fabrik:-
      initialBoard(X),
      addWorkers(X,Y),
      move(Y).
