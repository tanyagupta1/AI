parent(pam,bob).
parent(tom,bob).
parent(tom,liz).
parent(bob,ann).
parent(bob,pat).
parent(pat,jim).

grandparent(X,Z):-
    parent(X,Y),
    parent(Y,Z).
pred(X,Y):-
    parent(X,Y).
pred(X,Y):-
    parent(X,Z),
    pred(Z,Y).
point(X,Y).
vertical(seg(point(X,Y),point(X,Y1))).
horizontal(seg(point(X,Y),point(X1,Y))).

reg(rectangle(p(X,Y),p(X1,Y),p(X1,Y1),p(X,Y1))).