:- consult('menus.pl').
:- consult('display.pl').
:- consult('logic.pl').
:- consult('utilities.pl').
:- consult('input.pl').
:- consult('bot.pl').
:- use_module(library(random)).

fabrik :-
      mainMenu,
      startGame('P', 'P').
