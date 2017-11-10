%TODO: melhorar
invalidInput(Board, Player, NewBoard, Expected) :-
      write('INVALID INPUT: Cell not valid, please try again.\n'),
      askCoords(Board, Player, NewBoard, Expected).

%O
verifyLine(_Board, _WorkerRow, _WorkerColumn, _Row, _Column, 12, Res, 'O') :-
      Res is 0.
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'O' ):-
      (Column =:= WorkerColumn - Index, Row =:= WorkerRow, Res is 1);
      ((WorkerColumnTemp is WorkerColumn - Index, getValueFromMatrix(Board, WorkerRow, WorkerColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'O')).

%NO
verifyLine(_Board, _WorkerRow, _WorkerColumn, _Row, _Column, 12, Res, 'NO') :-
      Res is 0.
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'NO' ):-
      (Row =:= WorkerRow - Index, Column =:= WorkerColumn - Index, Res is 1); %NO
      ((WorkerRowTemp is WorkerRow - Index, WorkerColumnTemp is WorkerColumn - Index, getValueFromMatrix(Board, WorkerRowTemp, WorkerColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'NO')).

%N
verifyLine(_Board, _WorkerRow, _WorkerColumn, _Row, _Column, 12, Res, 'N') :-
      Res is 0.
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'N' ):-
      (Row =:= WorkerRow - Index, Column =:= WorkerColumn, Res is 1);
      ((WorkerRowTemp is WorkerRow - Index, getValueFromMatrix(Board, WorkerRowTemp, WorkerColumn, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'N')).

%NE
verifyLine(_Board, _WorkerRow, _WorkerColumn, _Row, _Column, 12, Res, 'NE') :-
      Res is 0.
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'NE' ):-
      (Row =:= WorkerRow - Index, Column =:= WorkerColumn + Index, Res is 1);
      ((WorkerRowTemp is WorkerRow -Index, WorkerColumnTemp is WorkerColumn + Index, getValueFromMatrix(Board, WorkerRowTemp, WorkerColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'NE')).

%E
verifyLine(_Board, _WorkerRow, _WorkerColumn, _Row, _Column, 12, Res, 'E') :-
      Res is 0.
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'E' ):-
      (Column =:= WorkerColumn + Index, Row =:= WorkerRow, Res is 1);
      ((WorkerColumnTemp is WorkerColumn + Index, getValueFromMatrix(Board, WorkerRow, WorkerColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'E')).

%SE
verifyLine(_Board, _WorkerRow, _WorkerColumn, _Row, _Column, 12, Res, 'SE') :-
      Res is 0.
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'SE' ):-
      (Row =:= WorkerRow + Index, Column =:= WorkerColumn + Index, Res is 1);
      ((WorkerRowTemp is WorkerRow + Index, WorkerColumnTemp is WorkerColumn + Index, getValueFromMatrix(Board, WorkerRowTemp, WorkerColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'SE')).

%S
verifyLine(_Board, _WorkerRow, _WorkerColumn, _Row, _Column, 12, Res, 'S') :-
      Res is 0.
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'S'):-
      (Row =:= WorkerRow + Index, Column =:= WorkerColumn, Res is 1);
      ((WorkerRowTemp is WorkerRow + Index, getValueFromMatrix(Board, WorkerRowTemp, WorkerColumn, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'S')).

%SO
verifyLine(_Board, _WorkerRow, _WorkerColumn, _Row, _Column, 12, Res, 'SO') :-
      Res is 0.
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'SO' ):-
      (Row =:= WorkerRow + Index, Column =:= WorkerColumn - Index, Res is 1);
      ((WorkerRowTemp is WorkerRow + Index, WorkerColumnTemp is WorkerColumn - Index, getValueFromMatrix(Board, WorkerRowTemp, WorkerColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'SO')).


%Res = 1 if that cell is in the worker lines, Res = 0 if it's not.
isWorkerLines(Board, WorkerRow, WorkerColumn, Row, Column, Res) :-
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResN, 'N' ), ResN =:= 1, write('\nRes N '),write(ResN),Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResNE, 'NE' ), ResNE =:= 1, write('\nRes NE '),write(ResNE),Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResE, 'E' ), ResE =:= 1, write('\nRes E '),write(ResE),Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResSE, 'SE' ), ResSE =:= 1, write('\nRes SE '),write(ResSE),Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResS, 'S' ), ResS =:= 1, write('\nRes S '),write(ResS),Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResSO, 'SO' ), ResSO =:= 1, write('\nRes SO '),write(ResSO),Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResO, 'O' ), ResO =:= 1, write('\nRes O '),write(ResO),Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResNO, 'NO' ), ResNO =:= 1, write('\nRes NO '),write(ResNO),Res is 1);
      Res is 0.


%Res = 1 that cell is valid, Res = 0 if not.
isValidPosLines(Board, Row, Column, Res) :-
      getWorkersPos(Board, Worker1Row, Worker1Column, Worker2Row, Worker2Column),
      (
        (isWorkerLines(Board, Worker1Row, Worker1Column, Row, Column, 1, ResIsWorkerLines1), ResIsWorkerLines1 =:= 1,
        Res is 1);
        (isWorkerLines(Board, Worker2Row, Worker2Column, Row, Column, 1, ResIsWorkerLines2), ResIsWorkerLines2 =:= 1,
        Res is 1);
        Res is 0
      ).

askCoords(Board, Player, NewBoard, Expected) :-
        manageRow(_Row, NewRow),
        manageColumn(_Column, NewColumn),
        write('\n'),
        ColumnIndex is NewColumn - 1,
        RowIndex is NewRow - 1,
        ((getValueFromMatrix(Board, RowIndex, ColumnIndex, Expected),
        replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard));
        invalidInput(Board, Player, NewBoard, Expected)).


moveWorker(Board, 'Y', NewBoard) :-
        write('\n2. Choose worker current cell.\n'),
        askCoords(Board, empty, NoWorkerBoard, red),
        write('3. Choose worker new cell.\n'),
        askCoords(NoWorkerBoard, red, NewBoard, empty),
        printBoard(NewBoard),
        write('\n4. Choose your cell.\n').

moveWorker(Board, 'N',NewBoard) :-
        NewBoard = Board,
        write('\n2. Choose your cell.\n').

gameLoop(Board1) :-
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Do you want to move a worker?(Y/N) '),
      read(MoveWorkerBoolX),
      moveWorker(Board1, MoveWorkerBoolX, Board2),
      askCoords(Board2, black, Board3, empty),
      printBoard(Board3),
      write('\n------------------ PLAYER O -------------------\n\n'),
      write('1. Do you want to move a worker?(Y/N) '),
      read(MoveWorkerBoolO),
      moveWorker(Board3, MoveWorkerBoolO, Board4),
      askCoords(Board4, white, Board5, empty),
      printBoard(Board5),
      gameLoop(Board5).

addWorkers(InitialBoard, WorkersBoard) :-
      printBoard(InitialBoard),
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Choose worker 1 cell.\n'),
      askCoords(InitialBoard, red, Worker1Board, empty),
      printBoard(Worker1Board),
      write('\n------------------ PLAYER O -------------------\n\n'),
      write('1. Choose worker 2 cell.\n'),
      askCoords(Worker1Board, red, WorkersBoard, empty),
      printBoard(WorkersBoard).

startGame :-
      initialBoard(InitialBoard),
      addWorkers(InitialBoard, WorkersBoard),
      gameLoop(WorkersBoard).
