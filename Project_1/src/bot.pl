
generatePlayerMove(Board):-
    random(0,11,Row),
    random(0,11,Column),
    write('row: '), write(Row), write(' column: '), write(Column), nl,
    ((verifyRandomMove(Board, Row, Column, ResVerifyRandomMove),ResVerifyRandomMove=:=1, 
    isEmptyCell(Board, Row, Column, ResIsEmptyCell), ResIsEmptyCell=:=1,
        (write('ROW: '), write(Row), write(' COLUMN: '), write(Column));
        generatePlayerMove(Board))).


verifyRandomMove(Board, Row, Column, Res):-
    ((isValidPosLines(Board, Row, Column, ResIsValidPosLines), ResIsValidPosLines =:= 1, !, 
    Res is 1, write('Random Move: 1\n'));
    Res is 0, write('Random Move: 0\n')).

isEmptyCell(Board, Row, Column, Res) :-
    ((getValueFromMatrix(Board, Row, Column, Value), Value == empty, !, 
    Res is 1, write('Empty Cell: 1\n'));
    Res is 0, write('Empty Cell: 0\n')).
        
