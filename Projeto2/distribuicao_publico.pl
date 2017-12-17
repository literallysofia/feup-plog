:- use_module(library(clpfd)).
:- use_module(library(lists)).


%TODO: parser do input com Count

test(Input, Output, Distances, TotalDistance):-
    length(Output, 8),
    domain(Output, 0 , 2),
    global_cardinality(Output,[0-4, 1-2, 2-2]),
    fill_distances(Output, Distances),
    sum(Distances,#=,TotalDistance),
    labeling([minimize(TotalDistance)], Output).

%não da por causa do backtracking mas com ! deixa de dar em cima
%also nao posso dar zero quando nao ha proximo porue estou a dar prioridade à situaçao
get_distance([], 0, _, _).
get_distance([Value|_], Counter, Counter, Value).
get_distance([_|ListT], Distance, Counter, Value):-
    NewCounter is Counter+1,
    get_distance(ListT, Distance, NewCounter, Value).

fill_distances([],[]).
fill_distances([ListH|ListT], [DistanceH|DistanceT]):-
    get_distance(ListT, DistanceH, 1, ListH),
    fill_distances(ListT, DistanceT).
