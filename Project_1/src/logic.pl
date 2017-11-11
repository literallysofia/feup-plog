%TODO: melhorar
invalidInput(Board, Player, NewBoard, Expected) :-
      write('INVALID INPUT: Cell not valid, please try again.\n'),
      askCoords(Board, Player, NewBoard, Expected).

%experimentacao

checkVictory(_NewBoard, 4) :-
      write('You won the game!\n\n').

checkVictory(NewBoard, Counter) :-
      checkGameState(NewBoard, Counter).

checkGameState(Board, Counter) :-
      getPlayerPos(Board, PlayerRow1, PlayerColumn1),
      replaceInMatrix(Board, PlayerRow1, PlayerColumn1, 'BLACK', NewBoard),
      getPlayerPos(NewBoard, PlayerRow2, PlayerColumn2),
      nl, write('pos 1: '),
      write(PlayerColumn1),
      nl, write('pos 2: '),
      write(PlayerColumn2),
      nl,
      (
            (PlayerRow1 =:= PlayerRow2, PlayerColumn1 =:= PlayerColumn2 - 1, Counter1 is Counter + 1, write('counter: '), write(Counter1), checkVictory(NewBoard, Counter1));
            (PlayerColumn1 =\= PlayerColumn2 - 1, checkVictory(NewBoard, 0));
            (nl)
      ).
      


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

checkMove(Board, Player, NewBoard, Expected, ColumnIndex, RowIndex):-
      (((Player == empty, Expected == red),
            ((getValueFromMatrix(Board, RowIndex, ColumnIndex, Expected),
                  replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard));
                  (write('INVALID MOVE: There is no worker in that cell, please try again!\n\n'),
                  askCoords(Board, Player, NewBoard, Expected))));
      ((Player == red, Expected == empty),
            ((getValueFromMatrix(Board, RowIndex, ColumnIndex, Expected),
                  replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard));
                  (write('INVALID MOVE: That cell is not empty, please try again!\n\n'),
                  askCoords(Board, Player, NewBoard, Expected))));
      ((Player == empty),
            ((getValueFromMatrix(Board, RowIndex, ColumnIndex, Expected),
                  replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard));
                  (write('INVALID MOVE: That cell is not empty, please try again!\n\n'),
                  askCoords(Board, Player, NewBoard, Expected))));
      ((Player == white; Player == black),
            ((getValueFromMatrix(Board, RowIndex, ColumnIndex, Expected),
                   ((isValidPosLines(Board, RowIndex, ColumnIndex, ResIsValidPosLines), ResIsValidPosLines =:= 1),
                        replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard);
                        (write('INVALID MOVE: That cell is not within the workers lines of sight, please try again!\n\n'),
                        askCoords(Board, Player, NewBoard, Expected))));
            (write('INVALID MOVE: That cell is not empty, please try again!\n\n'),
            askCoords(Board, Player, NewBoard, Expected))))).


askCoords(Board, Player, NewBoard, Expected) :-
      manageRow(NewRow),
      manageColumn(NewColumn),
      write('\n'),
      ColumnIndex is NewColumn - 1,
      RowIndex is NewRow - 1,
      checkMove(Board, Player, NewBoard, Expected, ColumnIndex, RowIndex).


printComputerWorkerMove(WorkerRowIndex, WorkerColumnIndex, WorkerNewRowIndex, WorkerNewColumnIndex):-
      WorkerRow is WorkerRowIndex + 1,
      WorkerColumn is WorkerColumnIndex + 1,
      WorkerNewRow is WorkerNewRowIndex + 1,
      WorkerNewColumn is WorkerNewColumnIndex + 1,
      letter(WorkerRow, WorkerRowLetter),
      letter(WorkerNewRow, WorkerNewRowLetter),
      write(' > Computer moved the worker in the cell [row: '), write(WorkerRowLetter), write(' column: '), write(WorkerColumn), write('] to the cell [row: '),  write(WorkerNewRowLetter), write(' column: '), write(WorkerNewColumn), write('].\n').

printComputerMove(NewRowIndex, NewColumnIndex):-
      NewRow is NewRowIndex + 1,
      NewColumn is NewColumnIndex + 1,
      letter(NewRow, RowLetter),
      write(' > Computer added a piece in the cell [row: '), write(RowLetter), write(' column: '), write(NewColumn), write(']\n').

printComputerAddWorker(WorkerRowIndex, WorkerColumnIndex):-
      WorkerRow is WorkerRowIndex + 1,
      WorkerColumn is WorkerColumnIndex + 1,
      letter(WorkerRow, WorkerRowLetter),
      write(' > Computer added a worker in the cell [row: '), write(WorkerRowLetter), write(' column: '), write(WorkerColumn), write(']\n').

computerMoveWorkers(Board1, NewBoard):-
      ((moveWorker(Board1, WorkerRowIndex, WorkerColumnIndex, WorkerNewRowIndex, WorkerNewColumnIndex, ResMoveWorker), ResMoveWorker =:= 1,
      replaceInMatrix(Board1,  WorkerRowIndex, WorkerColumnIndex, empty, Board2), 
      replaceInMatrix(Board2,  WorkerNewRowIndex, WorkerNewColumnIndex, red, NewBoard),
      printComputerWorkerMove(WorkerRowIndex, WorkerColumnIndex, WorkerNewRowIndex, WorkerNewColumnIndex));
      (NewBoard = Board1, write(' > The computer did not move any worker.\n'))).

moveWorker(Board, 1, NewBoard) :-
        write('\n2. Choose worker current cell.\n'),
        askCoords(Board, empty, NoWorkerBoard, red),
        write('3. Choose worker new cell.\n'),
        askCoords(NoWorkerBoard, red, NewBoard, empty),
        printBoard(NewBoard),
        write('\n4. Choose your cell.\n').

moveWorker(Board, 0,NewBoard) :-
        NewBoard = Board,
        write('\n2. Choose your cell.\n').


addWorkers(InitialBoard, WorkersBoard, 'P', 'P') :-
      printBoard(InitialBoard),
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Choose worker 1 cell.\n'),
      askCoords(InitialBoard, red, Worker1Board, empty),
      printBoard(Worker1Board),
      write('\n------------------ PLAYER O -------------------\n\n'),
      write('1. Choose worker 2 cell.\n'),
      askCoords(Worker1Board, red, WorkersBoard, empty),
      printBoard(WorkersBoard).

addWorkers(InitialBoard, WorkersBoard, 'P', 'C') :-
      printBoard(InitialBoard),
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Choose worker 1 cell.\n'),
      askCoords(InitialBoard, red, Worker1Board, empty),
      printBoard(Worker1Board),
      write('\n----------------- COMPUTER O ------------------\n\n'),
      generateWorkerMove(Worker1Board, WorkerRowIndex, WorkerColumnIndex),
      replaceInMatrix(Worker1Board,  WorkerRowIndex, WorkerColumnIndex, red, WorkersBoard),
      printComputerAddWorker(WorkerRowIndex, WorkerColumnIndex),
      printBoard(WorkersBoard).

gameLoop(Board1,'P','P') :- %mudar tambem
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Do you want to move a worker?[0(No)/1(Yes)]'),
      manageMoveWorkerBool(MoveWorkerBoolX),
      moveWorker(Board1, MoveWorkerBoolX, Board2),
      askCoords(Board2, black, Board3, empty),
      printBoard(Board3),
      checkGameState(Board3, 0),
      write('\n------------------ PLAYER O -------------------\n\n'),
      write('1. Do you want to move a worker?[0(No)/1(Yes)]'),
      manageMoveWorkerBool(MoveWorkerBoolO),
      moveWorker(Board3, MoveWorkerBoolO, Board4),
      askCoords(Board4, white, Board5, empty),
      printBoard(Board5),
      gameLoop(Board5,'P','P').

gameLoop(Board1,'P','C') :- %mudar tambem
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Do you want to move a worker?[0(No)/1(Yes)]'),
      manageMoveWorkerBool(MoveWorkerBoolX),
      moveWorker(Board1, MoveWorkerBoolX, Board2),
      askCoords(Board2, black, Board3, empty),
      printBoard(Board3),
      write('\n----------------- COMPUTER O ------------------\n\n'),
      computerMoveWorkers(Board3, Board4),
      generatePlayerMove(Board4, NewRowIndex, NewColumnIndex),
      replaceInMatrix(Board4,  NewRowIndex, NewColumnIndex, white, Board5),
      printComputerMove(NewRowIndex, NewColumnIndex),
      printBoard(Board5),
      gameLoop(Board5,'P','C').


startGame(Player1, Player2) :-
      initialBoard(InitialBoard),
      addWorkers(InitialBoard, WorkersBoard, Player1, Player2),
      gameLoop(WorkersBoard, Player1, Player2).