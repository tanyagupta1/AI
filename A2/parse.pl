:- [library(csv)].

:- dynamic edge/3.
:- dynamic column_keys/1.
:- dynamic h_n/3.

prepare_db(File) :-
    retractall(column_keys(_)),
    retractall(edge(_,_,_)),
    retractall(h_n(_,_,_)),
    forall(csv_read_file_row(File, Row,[]), store_row(Row)).

store_row(Row) :-
    Row =.. [row|Cols],
    (   column_keys(Destinations)
    ->  Cols = [Source|Distances],
        maplist(store_edge(Source), Destinations, Distances)
    ;   assertz(column_keys(Cols))
    ).

store_edge(Source, Destination, Distance) :-
    assertz(edge(Source, Destination, Distance)),assertz(edge(Destination, Source, Distance)).


    

% src: https://stackoverflow.com/questions/22591030/prolog-read-a-csv-file-and-make-a-predicate-findall?rq=1