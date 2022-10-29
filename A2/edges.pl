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
:- dynamic leaves/1.


initialize:-
    consult(parse),
    prepare_db('roaddistance.csv'),
    consult(heuristics).

search_type('DFS',Src,Dst):- dfs_with_dist([],Src,0,Src,Dst).
search_type('BestFirst',Src,Dst):- best_first([],Src,0,Src,Dst).

get_path() :-
    write("Source Node:"),
    nl,read(Source),
    write("Destintion Node:"),
    nl,read(Dest),
    write("Search Type(DFS,BestFirst) :"),
    nl,read(Type),
    search_type(Type,Source,Dest).

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

dfs_with_dist(Path,S,D,V,G):-
    V=G, print_list([V|Path]),
    nl,
   writeln(distance(D)).

    
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

leaves_list(L) :- findall(X,(leaves(X)), L).

append_list_to_leaves([]) :-fail.
append_list_to_leaves([H1|T1]):-
    \+append_list_to_leaves(T1),\+leaves(H1),assert(leaves(H1)),fail.


best_first(Path,S,D,V,G):-
    V=G, print_list([V|Path]),
    nl,writeln(distance(D)),retractall(leaves(_)).

best_first(Path,S,D,V,G):-
   children(List,Path,V),
   \+append_list_to_leaves(List),
   leaves_list(Leaves_list),
   minL(Leaves_list,C,G),
   retract(leaves(C)),
   edge(V,C,DD),
   ND is D+DD,
   best_first([V|Path],S,ND,C,G).

% you have leaves and you have path, at node v, you have to append its children to leaves, 
% then choose the min leaf and remove it from leaves and add it to path


%heuristics
