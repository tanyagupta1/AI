/*
edge(a,b).
edge(a,c).
edge(b,d).
edge(b,e).
edge(d,a).
edge(d,h).
edge(e,i).
edge(i,j).
edge(c,f).
edge(c,g).
edge(f,k).
goal(h).
*/


print_list([]).

print_list([X|Y]):-
    print_list(Y),
    write(X),
    nl.


is_mem(X,[X|_]).
is_mem(X,[H|T]):-
    is_mem(X,T).



dfs(Path,V,G):-
    V=G, print_list([V|Path]).

dfs(Path,V,G):-
   edge(V,C,_),
   \+is_mem(C,Path),
   dfs([V|Path],C,G).

% adding heurisitic which is dfs from goal

% src is S, dest is G, we assert heuristic(S,G,D)
dfs_with_dist(Path,S,D,V,G):-
    V=G, print_list([V|Path]),
    nl,
    assertz(h_n(S,G,D)),writeln(asserted_heuristic(S,G,D)).

    
dfs_with_dist(Path,S,D,V,G):-
   edge(V,C,DD),
   \+is_mem(C,Path),
   ND is D+DD,
   dfs_with_dist([V|Path],S,ND,C,G).

minOfTwo(X, Y, X,G):-
    h_n(X,G,X_d),h_n(Y,G,Y_d),X_d<Y_d.
minOfTwo(X, Y, Y,G):-
   h_n(X,G,X_d),h_n(Y,G,Y_d),X_d>=Y_d.
minL([X], X,G).
minL([H | T], X,G) :-
	minL(T, I,G),
	minOfTwo(H, I, X,G).

% dfs(Path,V,G):-
%     V=G, print_list([V|Path]).


% dfs(Path,V,G):-
%    edge(V,C,_),
%    \+is_mem(C,Path),
%    dfs([V|Path],C,G).
children(L,Path, P) :- findall(X,(edge(P,X,_),\+is_mem(X,Path),\+(X=P)), L).

best_first(Path,S,D,V,G):-
    V=G, print_list([V|Path]),
    nl,writeln(distance(D)).

best_first(Path,S,D,V,G):-
   children(List,Path,V),minL(List,C,G),edge(V,C,DD),
   ND is D+DD,
   best_first([V|Path],S,ND,C,G).