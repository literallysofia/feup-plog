:- use_module(library(clpfd)).
:- use_module(library(lists)).

%TODO:PARSER DE INPUT
test(Input, Output, Distances, TotalDistance, TotalDifference, Total):-
    length(Output, 8), %Harcoded
    domain(Output, 0 , 2), %Hardcoded
    global_cardinality(Output,[0-4, 1-2, 2-2]), %Hardcoded
    fill_distances(Output, Distances),
    sum(Distances,#=,TotalDistance),
    fill_differences(Input,Output, Differences),
    sum(Differences,#=,TotalDifference),
    Total#= TotalDifference + TotalDistance,
    labeling([],Output).

fill_differences([],[],[]).
fill_differences([InputH|InputT], [OutputH|OutputT], [DifferencesH|DifferencesT]):-
    InputH #= OutputH #<=> DifferencesH #= 0,
    InputH #\= OutputH #<=> DifferencesH #= 1,
    fill_differences(InputT, OutputT, DifferencesT).

%BUG: isto conta a distancia dos ultimos ate ao final
get_distance(Counter, NotUnique, Vars, Value) :-
    distance_signature(Vars, Sign, Value),
    automaton(Sign,_,Sign,
        [source(i), sink(i), sink(j)],
        [arc(i,0,i, [C+1,  NU+0]), arc(i,1,j, [C+1, NU+1]),
        arc(j,0,j, [C+0,  NU+0]), arc(j,1,j, [C+0,  NU+0])],
        %BUG: Se o C começar a 0, a funçao fill_distance dá no,
        [C, NU], [1,0], [Counter,NotUnique]).    

distance_signature([],[], _).
distance_signature([X|Xs], [S|Ss], Value):-
    S in 0..1,
    X#\=Value #<=> S#=0,
    X#=Value #<=> S#=1,
    distance_signature(Xs,Ss, Value).

fill_distances([],[]).
fill_distances([ListH|ListT], [DistanceH|DistanceT]):-
    get_distance(AuxDistanceH, NotUnique, ListT, ListH),
    NotUnique #<=> DistanceH #=AuxDistanceH,
    #\NotUnique #<=> DistanceH #= 0,
    fill_distances(ListT,DistanceT).







