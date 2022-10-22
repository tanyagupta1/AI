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

best