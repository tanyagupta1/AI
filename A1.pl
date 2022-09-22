core(cse,[cse101,cse102,cse103,cse104]).
eco_minor_courses([eco101,eco301,eco201]).
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
    interactive_get_core([],[],X),eco_minor().


check_res(y,TBD,DONE,[X|Y]):-
    interactive_get_core(TBD,[X|DONE],Y). 

check_res(n,TBD,DONE,[X|Y]):-
   interactive_get_core([X|TBD],DONE,Y).

interactive_get_core(CORE_TBD,CORE_DONE,[]):-
    write("complete these core courses: "),nl,print_list(CORE_TBD)
    ,nl,write("these done:"),nl,print_list(CORE_DONE),
    get_electives(CORE_DONE).

interactive_get_core(TBD,DONE,[X|Y]):-
    write(X),nl,read(RES),nl,check_res(RES,TBD,DONE,[X|Y]).

eco_minor():-
    write("do you want to minor in Economics?"),nl,read(ECO),check_eco(ECO).
check_eco(y):-
    write("do these core courses:"),nl,eco_minor_courses(L),print_list(L).

get_electives([]).
get_electives([X|T]):-
    