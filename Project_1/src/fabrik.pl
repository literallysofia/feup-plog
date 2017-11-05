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
        Row1 is Row-1,
        replaceInMatrix(T, Row1, Collumn, Value, TNew).

askCoords(Board,Player,NewBoard):-
        write('  > Row     '),
        read(RowLetter),
        number(RowLetter, Row),
        write('  > Collumn '),
        read(Collumn),
        write('\n'),
        CollumnIndex is Collumn-1,
        RowIndex is Row-1,
        replaceInMatrix(Board, RowIndex, CollumnIndex, Player, NewBoard).

moveWorker(Board,'Y', NewBoard) :-
        write('\n2. Choose worker new cell.\n'),
        askCoords(Board,red,NewBoard),
        printBoard(NewBoard),
        write('\n3. Choose your cell.\n').

moveWorker(Board,'N',NewBoard) :-
        NewBoard = Board,
        write('\n2. Choose your cell.\n').

gameLoop(Board1):-
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Do you want to move a worker?(Y/N) '),
      read(MoveWorkerBoolX),
      moveWorker(Board1,MoveWorkerBoolX,Board2),
      askCoords(Board2,black, Board3),
      printBoard(Board3),
      write('\n------------------ PLAYER O -------------------\n\n'),
      write('1. Do you want to move a worker?(Y/N) '),
      read(MoveWorkerBoolO),
      moveWorker(Board3,MoveWorkerBoolO,Board4),
      askCoords(Board4,white,Board5),
      printBoard(Board5),
      gameLoop(Board5).

addWorkers(InitialBoard,WorkersBoard):-
      printBoard(InitialBoard),
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Choose worker 1 cell.\n'),
      askCoords( InitialBoard,red, Worker1Board),
      printBoard(Worker1Board),
      write('\n------------------ PLAYER O -------------------\n\n'),
      write('1. Choose worker 2 cell.\n'),
      askCoords( Worker1Board,red,WorkersBoard),
      printBoard(WorkersBoard).

fabrik:-
      initialBoard(InitialBoard),
      addWorkers(InitialBoard,WorkersBoard),
      gameLoop(WorkersBoard).
