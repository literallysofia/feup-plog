:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).

displayOutput(OutputGroups, OutputIndexs, TotalDifference, NumOfChanges):-
    write(' > OUTPUT GROUPS: '), write(OutputGroups),nl,
    write(' > OUTPUT INDEXS: '),write(OutputIndexs),nl,
    write(' > Total Changes: '), write(NumOfChanges),nl,
    write(' > Total Changes Value: '), write(TotalDifference),nl.

generateList(0, [], _).
generateList(Counter, [Head|Tail], TotalGroups) :-
    Counter > 0,
    Counter1 is Counter-1,
    random(1, TotalGroups, Head),
    generateList(Counter1, Tail, TotalGroups).

problem(TotalAudience, TotalGroups):-
    MaxGroups is TotalGroups + 1,
    generateList(TotalAudience, InputGroups, MaxGroups),
    write(' > INPUT  GROUPS:'), write(InputGroups),nl,
    solve(InputGroups, TotalAudience, TotalGroups, OutputGroups, OutputIndexs, TotalDifference,  NumOfChanges),
    displayOutput(OutputGroups, OutputIndexs, TotalDifference, NumOfChanges).

problem(InputGroups):-
    length(InputGroups, TotalAudience),
    maximum(TotalGroups, InputGroups),
    solve(InputGroups, TotalAudience, TotalGroups, OutputGroups, OutputIndexs, TotalDifference,  NumOfChanges),
    write(' > INPUT  GROUPS: '), write(InputGroups),nl,
    displayOutput(OutputGroups, OutputIndexs, TotalDifference, NumOfChanges).

solve(InputGroups, TotalAudience, TotalGroups, OutputGroups, OutputIndexs, TotalDifference, NumOfChanges):-
    statistics(walltime, [Start,_]),

    %Variáveis de Decisão
    length(OutputGroups, TotalAudience),
    length(OutputIndexs, TotalAudience),
    domain(OutputGroups, 1 , TotalGroups),
    domain(OutputIndexs, 1 , TotalAudience), 
    
    %Restrições
    all_distinct(OutputIndexs),
    get_groups(InputGroups, OutputIndexs, OutputGroups),
    approximate(OutputGroups),

    %Função de Avaliação
    fill_differences(OutputIndexs,OutputIndexs, Differences),
    sum(Differences,#=,TotalDifference),
    get_changes(NumOfChanges, Differences),
    Min #= NumOfChanges + TotalDifference,

    %Labelling
    append(OutputGroups, OutputIndexs, Vars),
    labeling([minimize(Min),step,min],Vars),

    statistics(walltime, [End,_]),
	Time is End - Start,
    format(' > Duration: ~3d s~n', [Time]).
    %fd_statistics.

get_groups(_,[],[]).
get_groups(InputGroups, [OutputIndexsH|OutputIndexsT],  [OutputGroupsH|OutputGroupsT]):-
    element(OutputIndexsH, InputGroups, OutputGroupsH),
    get_groups(InputGroups, OutputIndexsT, OutputGroupsT).

get_distance(Counter, NotUnique, OutputGroupsT, Value) :-
    distance_signature(OutputGroupsT, Sign, Value),
    automaton(Sign,_,Sign,
        [source(i), sink(i), sink(j)],
        [arc(i,0,i, [C+1,  NU+0]), arc(i,1,j, [C+0, NU+1]),
        arc(j,0,j, [C+0,  NU+0]), arc(j,1,j, [C+0,  NU+0])],
        [C, NU], [0,0], [Counter,NotUnique]).    

distance_signature([],[], _).
distance_signature([X|Xs], [S|Ss], Value):-
    S in 0..1,
    X#\=Value #=> S#=0,
    X#=Value #=> S#=1,
    distance_signature(Xs,Ss, Value).

approximate([]).
approximate([OutputGroupsH|OutputGroupsT]):-
    get_distance(Distance, NotUnique, OutputGroupsT, OutputGroupsH),
    NotUnique #=> Distance #=0,
    approximate(OutputGroupsT).

fill_differences(_,[],[]).
fill_differences(OutputIndexs, [OutputIndexsH|OutputIndexsT], [DifferencesH|DifferencesT]):-
    element(OutputPos, OutputIndexs, OutputIndexsH),
    DifferencesH #= abs(OutputPos-OutputIndexsH),
    fill_differences(OutputIndexs, OutputIndexsT, DifferencesT).

get_changes(Counter, Differences) :-
    changes_signature(Differences, Sign),
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