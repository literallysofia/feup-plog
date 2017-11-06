replaceInList([_|T], 0, Value, [Value|T]).
replaceInList([H|T], Index, Value, [H|TNew]) :-
        Index > 0,
        Index1 is Index - 1,
        replaceInList(T, Index1, Value, TNew).

replaceInMatrix([H|T], 0, Collumn,Value, [HNew|T]) :-
        replaceInList(H, Collumn, Value, HNew).

replaceInMatrix([H|T], Row, Collumn, Value, [H|TNew]):-
        Row > 0,
        Row1 is Row - 1,
        replaceInMatrix(T, Row1, Collumn, Value, TNew).

getValueFromList([H|_], 0, Value):-
        Value = H.

getValueFromList([_|T], Index, Value) :-
        Index > 0,
        Index1 is Index - 1,
        getValueFromList(T, Index1, Value).

getValueFromMatrix([H|_], 0, Collumn, Value) :-
        getValueFromList(H, Collumn, Value).

getValueFromMatrix([_|T], Row, Collumn, Value) :-
        Row>0,
        Row1 is Row -1,
        getValueFromMatrix(T, Row1, Collumn, Value).
