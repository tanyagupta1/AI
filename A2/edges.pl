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
