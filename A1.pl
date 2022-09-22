core(cse,[cse101,cse102,cse103,cse104]).

print_list([]).
print_list([X|Y]):-
    write(X),nl,
    print_list(Y).

get_rec() :-
    write("input branch "),nl,read(Branch),
    write("Type y. if you have taken this core course, else type n.: "),nl,
    get_core(Branch).

get_core(Branch) :-
    core(Branch,X),
    interactive_get_core([],X).


check_res(y,S,[X|Y]):-
    interactive_get_core(S,Y). 

check_res(n,S,[X|Y]):-
   interactive_get_core([X|S],Y).

interactive_get_core(SS,[]):-
    write("complete these core courses: "),nl,print_list(SS).

interactive_get_core(S,[X|Y]):-
    write(X),nl,read(RES),nl,check_res(RES,S,[X|Y]).
