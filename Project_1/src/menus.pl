mainMenu :-
    printMainMenu,
    askMenuOption,
    read(Input),
    manageInput(Input).

manageInput(1) :-
    startGame('PP'),
    mainMenu.

manageInput(2) :-
    startGame('PC'),
    mainMenu.

manageInput(3) :-
    write('valid option!\n\n').

manageInput(4) :-
    write('valid option!\n\n').

manageInput(0) :-
    write('\nExiting...\n\n').

manageInput(_Other) :-
    write('\nERROR: that option does not exist.\n\n'),
    askMenuOption,
    read(Input),
    manageInput(Input).

printMainMenu :-
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                         ___     _       _ _                           |'),nl,
    write('|                        |  _|___| |_ ___|_| |_                         |'),nl,
    write('|                        |  _| ."| . |  _| | "_|                        |'),nl,
    write('|                        |_| |__,|___|_| |_|_,_|                        |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                           Barbara Sofia Silva                         |'),nl,
    write('|                              Julieta Frade                            |'),nl,
    write('|               -----------------------------------------               |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                          1. Player vs Player                          |'),nl,
    write('|                                                                       |'),nl,
    write('|                          2. Player vs Computer                        |'),nl,
    write('|                                                                       |'),nl,
	write('|                          3. Computer vs Computer                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                          0. Exit                                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write(' _______________________________________________________________________ '),nl,nl,nl.

askMenuOption :-
    write('> Insert your option ').