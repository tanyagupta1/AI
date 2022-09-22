f(1,one).
f(s(1),two).
f(s(s(1)),three).
f(s(s(s(X))),N):-
    f(X,N).

concat([],L1,L1).
concat([X|L1],L2,[X|L3]):-
    concat(L1,L2,L3).

length([],0);
length([X|T],N):-
    length(T,M),
    N is 1+M.