edge(a,b).
edge(a,c).
edge(b,d).
edge(b,e).
edge(d,h).
edge(e,i).
edge(i,j).
edge(c,f).
edge(c,g).
edge(f,k).
goal(h).

print_list([]).

print_list([X|Y]):-
    write(X),
    nl,print_list(Y).

dfs(Path,V):-
    goal(V), print_list([V|Path]).

dfs(Path,V):-
    edge(V,C),dfs([V|Path],C).
