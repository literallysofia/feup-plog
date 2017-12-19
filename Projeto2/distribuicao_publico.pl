:- use_module(library(clpfd)).
:- use_module(library(lists)).

%TODO:PARSER DE INPUT

test(InputGroups, OutputGroups, OutputIndexs, Distances, TotalDistance, Differences,TotalDifference, Total):-
    length(OutputGroups, 8), %Harcoded
    length(OutputIndexs, 8), %Harcoded
    domain(OutputGroups, 0 , 2), %Hardcoded
    domain(OutputIndexs, 1 , 8), %Hardcoded
    all_distinct(OutputIndexs),
    
    fill_groups(InputGroups, OutputIndexs, OutputGroups),
    fill_distances(OutputGroups, Distances),
    sum(Distances,#=,TotalDistance),
    fill_differences(OutputIndexs,OutputIndexs, Differences),
    sum(Differences,#=,TotalDifference),
    Total#= TotalDifference + TotalDistance*2,

    append(OutputGroups, OutputIndexs, Vars),
    labeling([minimize(Total)],Vars).

fill_groups(_,[],[]).
fill_groups(InputGroups, [OutputIndexsH|OutputIndexsT],  [OutputGroupsH|OutputGroupsT]):-
    element(OutputIndexsH, InputGroups, OutputGroupsH),
    fill_groups(InputGroups, OutputIndexsT, OutputGroupsT).

fill_differences(_,[],[]).
fill_differences(OutputIndexs, [OutputIndexsH|OutputIndexsT], [DifferencesH|DifferencesT]):-
    element(OutputPos, OutputIndexs, OutputIndexsH),
    DifferencesH #= abs(OutputPos-OutputIndexsH),
    fill_differences(OutputIndexs, OutputIndexsT, DifferencesT).

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







