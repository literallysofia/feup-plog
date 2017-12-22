:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).

%display do resultado
displayOutput(OutputGroups, OutputIndexs, TotalDifference, NumOfChanges):-
    write(' > OUTPUT GROUPS: '), write(OutputGroups),nl,
    write(' > OUTPUT INDEXS: '),write(OutputIndexs),nl,
    write(' > Total Changes: '), write(NumOfChanges),nl,
    write(' > Total Changes Value: '), write(TotalDifference),nl.

%gerar uma lista com Counter elementos random de 1 a TotalGroups
generateList(0, [], _).
generateList(Counter, [Head|Tail], TotalGroups) :-
    Counter > 0,
    Counter1 is Counter-1,
    random(1, TotalGroups, Head),
    generateList(Counter1, Tail, TotalGroups).

%chama o predicado de gerar uma lista e depois chama a funçao de label para a lista gerada
problem(TotalAudience, TotalGroups):-
    MaxGroups is TotalGroups + 1,
    generateList(TotalAudience, InputGroups, MaxGroups),
    write(' > INPUT  GROUPS:'), write(InputGroups),nl,
    label(InputGroups, TotalAudience, TotalGroups, OutputGroups, OutputIndexs, TotalDifference,  NumOfChanges),
    displayOutput(OutputGroups, OutputIndexs, TotalDifference, NumOfChanges).

%chama o predicado de label para a lista InputGroups
problem(InputGroups):-
    length(InputGroups, TotalAudience),
    maximum(TotalGroups, InputGroups),
    label(InputGroups, TotalAudience, TotalGroups, OutputGroups, OutputIndexs, TotalDifference,  NumOfChanges),
    write(' > INPUT  GROUPS: '), write(InputGroups),nl,
    displayOutput(OutputGroups, OutputIndexs, TotalDifference, NumOfChanges).

%faz labeling de OutputGroups e OutputIndexs
label(InputGroups, TotalAudience, TotalGroups, OutputGroups, OutputIndexs, TotalDistance, NumOfChanges):-
    statistics(walltime, [Start,_]),

    length(OutputGroups, TotalAudience),
    length(OutputIndexs, TotalAudience),
    domain(OutputGroups, 1 , TotalGroups),
    domain(OutputIndexs, 1 , TotalAudience), 
    all_distinct(OutputIndexs),
    fill_groups(InputGroups, OutputIndexs, OutputGroups),

    fill_distances(OutputGroups, Distances),
    sum(Distances,#=,TotalDistance), %separação dos grupos
    fill_differences(OutputIndexs,OutputIndexs, Differences),
    sum(Differences,#=,TotalDifference), %quanto é que as pessoa se moveram
    get_changes(NumOfChanges, Differences), %quantas pessoas se moveram
    Min #= TotalDifference + NumOfChanges + TotalDistance*5,

    append(OutputGroups, OutputIndexs, Vars),
    labeling([minimize(Min)],Vars),

    statistics(walltime, [End,_]),
	Time is End - Start,
    format(' > Duration: ~3d seconds~n', [Time]).

%associa cada pessoa ao seu grupo
fill_groups(_,[],[]).
fill_groups(InputGroups, [OutputIndexsH|OutputIndexsT],  [OutputGroupsH|OutputGroupsT]):-
    element(OutputIndexsH, InputGroups, OutputGroupsH),
    fill_groups(InputGroups, OutputIndexsT, OutputGroupsT).

%ve o quao longe esta a primeira pessoa à sua direita do mesmo grupo
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

%preenche o vetor com a distancia que cada pessoa andou
fill_differences(_,[],[]).
fill_differences(OutputIndexs, [OutputIndexsH|OutputIndexsT], [DifferencesH|DifferencesT]):-
    element(OutputPos, OutputIndexs, OutputIndexsH),
    DifferencesH #= abs(OutputPos-OutputIndexsH),
    fill_differences(OutputIndexs, OutputIndexsT, DifferencesT).

%quantas pessoas mudaram de lugar
get_changes(Counter, Vars) :-
    changes_signature(Vars, Sign),
    automaton(Sign,_,Sign,
        [source(i), sink(i)],
        [arc(i,0,i,[C+0]), arc(i,1,i, [C+1])],
        [C], [0], [Counter]).    

changes_signature([],[]).
changes_signature([X|Xs], [S|Ss]):-
    S in 0..1,
    X#\=0 #=> S#=1,
    X#=0 #=> S#=0,
    changes_signature(Xs,Ss).