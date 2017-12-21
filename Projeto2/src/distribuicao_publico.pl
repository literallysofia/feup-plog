:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).

problem(TotalAudience, TotalGroups, InputGroups, OutputGroups, OutputIndexs,  TotalDistance, TotalDifference, NumOfChanges, Min) :-
    MaxGroups is TotalGroups + 1,
    generateList(TotalAudience, InputGroups, MaxGroups),
    label(InputGroups, TotalAudience, TotalGroups, OutputGroups, OutputIndexs,  TotalDistance,  TotalDifference, NumOfChanges, Min).

generateList(0, [], _).
generateList(Counter, [Head|Tail], TotalGroups) :-
    Counter > 0,
    Counter1 is Counter-1,
    random(1, TotalGroups, Head),
    generateList(Counter1, Tail, TotalGroups).    

label(InputGroups, TotalAudience, TotalGroups, OutputGroups, OutputIndexs, TotalDistance,  TotalDifference, NumOfChanges, Min):-
    statistics(walltime, [Start,_]),

    length(OutputGroups, TotalAudience),
    length(OutputIndexs, TotalAudience),
    domain(OutputGroups, 1 , TotalGroups),
    domain(OutputIndexs, 1 , TotalAudience), 
    all_distinct(OutputIndexs),
    fill_groups(InputGroups, OutputIndexs, OutputGroups),

    fill_distances(OutputGroups, Distances),
    sum(Distances,#=,TotalDistance),
    fill_differences(OutputIndexs,OutputIndexs, Differences),
    sum(Differences,#=,TotalDifference),
    changes(Differences, NumOfChanges,0),
    Min#= TotalDifference + NumOfChanges + TotalDistance*5,

    append(OutputGroups, OutputIndexs, Vars),
    labeling([minimize(Min)],Vars),

    statistics(walltime, [End,_]),
	Time is End - Start,
	nl,
    format('Duration: ~3d seconds.~n', [Time]).

fill_groups(_,[],[]).
fill_groups(InputGroups, [OutputIndexsH|OutputIndexsT],  [OutputGroupsH|OutputGroupsT]):-
    element(OutputIndexsH, InputGroups, OutputGroupsH),
    fill_groups(InputGroups, OutputIndexsT, OutputGroupsT).

get_distance(Counter, NotUnique, Vars, Value) :-
    distance_signature(Vars, Sign, Value),
    automaton(Sign,_,Sign,
        [source(i), sink(i), sink(j)],
        [arc(i,0,i, [C+1,  NU+0]), arc(i,1,j, [C+1, NU+1]),
        arc(j,0,j, [C+0,  NU+0]), arc(j,1,j, [C+0,  NU+0])],
        [C, NU], [0,0], [Counter,NotUnique]).    

distance_signature([],[], _).
distance_signature([X|Xs], [S|Ss], Value):-
    S in 0..1,
    X#\=Value #=> S#=0,
    X#=Value #=> S#=1,
    distance_signature(Xs,Ss, Value).

fill_distances([],[]).
fill_distances([ListH|ListT], [DistanceH|DistanceT]):-
    get_distance(AuxDistanceH, NotUnique, ListT, ListH),
    NotUnique #=> DistanceH #=AuxDistanceH,
    #\NotUnique #=> DistanceH #= 0,
    fill_distances(ListT,DistanceT).

fill_differences(_,[],[]).
fill_differences(OutputIndexs, [OutputIndexsH|OutputIndexsT], [DifferencesH|DifferencesT]):-
    element(OutputPos, OutputIndexs, OutputIndexsH),
    DifferencesH #= abs(OutputPos-OutputIndexsH),
    fill_differences(OutputIndexs, OutputIndexsT, DifferencesT).

changes([],NumOfChanges, NumOfChangesAux):- NumOfChanges #=NumOfChangesAux.
changes([ListH|ListT], NumOfChanges, NumOfChangesAux):-
    ListH#\=0 #=> NewAux #= NumOfChangesAux + 1,
    ListH#=0 #=> NewAux #= NumOfChangesAux,
    changes(ListT,NumOfChanges, NewAux).