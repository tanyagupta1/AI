f(1,one).
f(s(1),two).
f(s(s(1)),three).
f(s(s(s(X))),N):-
    f(X,N).

concat([],L1,L1).
concat([X|L1],L2,[X|L3]):-
    concat(L1,L2,L3).


contains(X,[X|_]).
contains(X,[Y|Z]):-
    contains(X,Z).
list_has_list([],_).
list_has_list([H|T],L):-
    contains(H,L),list_has_list(T,L).
not_contains(X,[]).
not_contains(X,[Y|Z]):-
    X=\=Y,not_contains(X,Z).



:- dynamic(done_suggest/1).

reset_electives:-
    retractall(done_suggest(_)),
    fail.

reset_electives.
getPre([]):-
    write("Enter: "),
    nl,
    read(Pre),
    dif(Pre, stop),
    assertz(done_suggest(Pre)),
    getPre([]).