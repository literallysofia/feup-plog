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

askCoords(Player,Board,NewBoard):-
        write('Row     '),
        read(RowLetter),
        number(RowLetter, Row),
        write('Collumn '),
        read(Collumn),
        write('\n'),
        CollumnIndex is Collumn-1,
        RowIndex is Row-1,
        replaceInMatrix(Board, RowIndex, CollumnIndex, Player, NewBoard).

moveWorker(Board,NewBoard,'Y') :-
        write('Move Worker:\n'),
        askCoords(red,Board,NewBoard),
        printBoard(NewBoard).

moveWorker(Board,NewBoard,'N') :-
        NewBoard is Board.

gameLoop(X):-
      printBoard(X),
      write('PLAYER X\n'),
      write('Do you want to move a worker?(Y/N) '),
      read(MoveWorkerBool),
      moveWorker(X,Y,MoveWorkerBool),
      askCoords(black, Y, Z),
      printBoard(Z),
      write('PLAYER O\n'),
      write('Do you want to move a worker?(Y/N) '),
      read(MoveWorkerBool),
      moveWorker(Z,W,MoveWorkerBool),
      askCoords(white,W,V),
      gameLoop(V).

addWorkers(X,Z):-
      printBoard(X),
      write('Add Woker 1:\n'),
      askCoords(red, X, Y),
      printBoard(Y),
      write('Add Worker 2:\n'),
      askCoords(red, Y, Z).

fabrik:-
      initialBoard(X),
      addWorkers(X,Y),
      gameLoop(Y).
