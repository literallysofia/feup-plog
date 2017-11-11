%TODO: DELETE PRINTS

verifyRandomMove(Board, Row, Column, Res):-
    ((isValidPosLines(Board, Row, Column, ResIsValidPosLines), ResIsValidPosLines =:= 1, !, 
    Res is 1, write('Random Move: 1\n'));
    Res is 0, write('Random Move: 0\n')).

isEmptyCell(Board, Row, Column, Res) :-
    ((getValueFromMatrix(Board, Row, Column, Value), Value == empty, !, 
    Res is 1, write('Empty Cell: 1\n'));
    Res is 0, write('Empty Cell: 0\n')).

generatePlayerMove(Board):-
    random(0,11,Row),
    random(0,11,Column),
    write('row: '), write(Row), write(' column: '), write(Column), nl,
    ((verifyRandomMove(Board, Row, Column, ResVerifyRandomMove),ResVerifyRandomMove=:=1, 
    isEmptyCell(Board, Row, Column, ResIsEmptyCell), ResIsEmptyCell=:=1,
        (write('ROW: '), write(Row), write(' COLUMN: '), write(Column));
        generatePlayerMove(Board))).

moveWorker(Board, WorkerRow, WorkerColumn, WorkerNewRow, WorkerNewColumn, Res) :-
    random(0,2, Bool), write('Bool Move Worker: '), write(Bool), nl,
    ((Bool =:= 1, 
    chooseWorker(Board, WorkerRow, WorkerColumn), generateWorkerMove(Board, WorkerNewRow, WorkerNewColumn), Res = 1);
    Res is 0).

chooseWorker(Board, WorkerRow, WorkerColumn) :-
    getWorkersPos(Board, WorkerRow1, WorkerColumn1, WorkerRow2, WorkerColumn2),
    write('Worker 1 Row: '), write(WorkerRow1), write(' Worker 1 Column: '), write(WorkerColumn1), nl,
    write('Worker 2 Row: '), write(WorkerRow2), write(' Worker 2 Column: '), write(WorkerColumn2), nl,
    random(1,3, Bool), write('Bool: '), write(Bool), nl,
    ((Bool =:= 1, WorkerRow is WorkerRow1, WorkerColumn is WorkerColumn1);
    (Bool =:= 2, WorkerRow is WorkerRow2, WorkerColumn is WorkerColumn2)),
    write('WORKER ROW: '), write(WorkerRow), write(' WORKER COLUMN: '), write(WorkerColumn), nl.

generateWorkerMove(Board,WorkerNewRow, WorkerNewColumn) :-
    random(0,11,WorkerNewRow),
    random(0,11,WorkerNewColumn),
    write('Worker New Row: '), write(WorkerNewRow), write(' Worker New Column: '), write(WorkerNewColumn), nl,
    (isEmptyCell(Board, WorkerNewRow, WorkerNewColumn, ResIsEmptyCell), ResIsEmptyCell=:=1,
        (write('WORKER NEW ROW: '), write(WorkerNewRow), write(' WORKER NEW COLUMN: '), write(WorkerNewColumn), nl);
        generateWorkerMove(Board)).


