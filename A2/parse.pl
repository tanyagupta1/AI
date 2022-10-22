:- [library(csv)].

:- dynamic edge/3.
:- dynamic column_keys/1.

prepare_db(File) :-
    retractall(column_keys(_)),
    retractall(edge(_,_,_)),
    forall(read_row(File, Row), store_row(Row)).

store_row(Row) :-
    Row =.. [row|Cols],
    (   column_keys(ColKeys)
    ->  Cols = [RowKey|Samples],
        maplist(store_sample(RowKey), ColKeys, Samples)
    ;   assertz(column_keys(Cols))
    ).

store_sample(RowKey, ColKey, Sample) :-
    not(RowKey=ColKey),assertz(edge(RowKey, ColKey, Sample)),assertz(edge(ColKey, RowKey, Sample)).

read_row(File, Row) :-
    csv_read_file_row(File, Row,[]).

% src: https://stackoverflow.com/questions/22591030/prolog-read-a-csv-file-and-make-a-predicate-findall?rq=1