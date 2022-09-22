core(cse,[cse101,cse102]).

print_list([]).
print_list([X|Y]):-
    write(X),nl,
    print_list(Y).

get_rec() :-
    write("input branch "),nl,read(Branch),
    write("your core subjects: "),nl,
    get_core(Branch).

get_core(Branch) :-
    core(Branch,X),
    print_list(X).
   

