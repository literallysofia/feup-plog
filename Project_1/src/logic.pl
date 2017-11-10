%TODO: melhorar
invalidInput(Board, Player, NewBoard, Expected) :-
      write('INVALID INPUT: Cell not valid, please try again.\n'),
      askCoords(Board, Player, NewBoard, Expected).

%Default
verifyLine(_Board, _WorkerRow, _WorkerColumn, _Row, _Column, 12, Res, _Ray) :-
      Res is 0.
%O
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'O' ):-
      (Column =:= WorkerColumn - Index, Row =:= WorkerRow, Res is 1);
      ((ColumnTemp is WorkerColumn - Index, getValueFromMatrix(Board, WorkerRow, ColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'O')).
%NO
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'NO' ):-
      (Row =:= WorkerRow - Index, Column =:= WorkerColumn - Index, Res is 1); %NO
      ((RowTemp is WorkerRow - Index, ColumnTemp is WorkerColumn - Index, getValueFromMatrix(Board, RowTemp, ColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'NO')).
%N
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'N' ):-
      (Row =:= WorkerRow - Index, Column =:= WorkerColumn, Res is 1);
      ((RowTemp is WorkerRow - Index, getValueFromMatrix(Board, RowTemp, WorkerColumn, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'N')).
%NE
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'NE' ):-
      (Row =:= WorkerRow - Index, Column =:= WorkerColumn + Index, Res is 1);
      ((RowTemp is WorkerRow -Index, ColumnTemp is WorkerColumn + Index, getValueFromMatrix(Board, RowTemp, ColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'NE')).
%E
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'E' ):-
      (Column =:= WorkerColumn + Index, Row =:= WorkerRow, Res is 1);
      ((ColumnTemp is WorkerColumn + Index, getValueFromMatrix(Board, WorkerRow, ColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'E')).
%SE
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'SE' ):-
      (Row =:= WorkerRow + Index, Column =:= WorkerColumn + Index, Res is 1);
      ((RowTemp is WorkerRow + Index, ColumnTemp is WorkerColumn + Index, getValueFromMatrix(Board, RowTemp, ColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'SE')).
%S
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'S'):-
      (Row =:= WorkerRow + Index, Column =:= WorkerColumn, Res is 1);
      ((RowTemp is WorkerRow + Index, getValueFromMatrix(Board, RowTemp, WorkerColumn, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'S')).
%SO
verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,Index, Res, 'SO' ):-
      (Row =:= WorkerRow + Index, Column =:= WorkerColumn - Index, Res is 1);
      ((RowTemp is WorkerRow + Index, ColumnTemp is WorkerColumn - Index, getValueFromMatrix(Board, RowTemp, ColumnTemp, Value), Value \= empty, Res is 0),!);
      (Index < 12,
      Index1 is Index + 1,
      verifyLine(Board, WorkerRow, WorkerColumn, Row, Column, Index1, Res, 'SO')).

%Res = 1 if that cell is in the worker lines, Res = 0 if it's not.
isWorkerLines(Board, WorkerRow, WorkerColumn, Row, Column, Res) :-
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResN, 'N' ), ResN =:= 1, Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResNE, 'NE' ), ResNE =:= 1, Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResE, 'E' ), ResE =:= 1, Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResSE, 'SE' ), ResSE =:= 1, Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResS, 'S' ), ResS =:= 1, Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResSO, 'SO' ), ResSO =:= 1, Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResO, 'O' ), ResO =:= 1, Res is 1);
      (verifyLine(Board, WorkerRow, WorkerColumn, Row, Column,1, ResNO, 'NO' ), ResNO =:= 1, Res is 1);
      Res is 0.


%Res = 1 that cell is valid, Res = 0 if not.
isValidPosLines(Board, Row, Column, Res) :-
      getWorkersPos(Board, Worker1Row, Worker1Column, Worker2Row, Worker2Column),
      ((isWorkerLines(Board, Worker1Row, Worker1Column, Row, Column, ResIsWorkerLines1), ResIsWorkerLines1 =:= 1, Res is 1);
       (isWorkerLines(Board, Worker2Row, Worker2Column, Row, Column, ResIsWorkerLines2), ResIsWorkerLines2 =:= 1, Res is 1);
       Res is 0).

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
