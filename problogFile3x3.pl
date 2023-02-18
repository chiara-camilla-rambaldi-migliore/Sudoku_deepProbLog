:- use_module(library(lists)).
:- use_module(library(apply)).

0.1 :: digit(img,1,1,0).
0.4 :: digit(img,1,1,1).
0.1 :: digit(img,1,1,2).
0.2 :: digit(img,1,1,3).

0.4 :: digit(img,1,2,0).
0.1 :: digit(img,1,2,1).
0.2 :: digit(img,1,2,2).
0.2 :: digit(img,1,2,3).

0.4 :: digit(img,1,3,0).
0.1 :: digit(img,1,3,1).
0.2 :: digit(img,1,3,2).
0.2 :: digit(img,1,3,3).

0.1 :: digit(img,2,1,0).
0.1 :: digit(img,2,1,1).
0.1 :: digit(img,2,1,2).
0.1 :: digit(img,2,1,3).

0.1 :: digit(img,2,2,0).
0.1 :: digit(img,2,2,1).
0.1 :: digit(img,2,2,2).
0.1 :: digit(img,2,2,3).

0.1 :: digit(img,2,3,0).
0.1 :: digit(img,2,3,1).
0.1 :: digit(img,2,3,2).
0.1 :: digit(img,2,3,3).

0.1 :: digit(img,3,1,0).
0.1 :: digit(img,3,1,1).
0.1 :: digit(img,3,1,2).
0.1 :: digit(img,3,1,3).

0.1 :: digit(img,3,2,0).
0.1 :: digit(img,3,2,1).
0.1 :: digit(img,3,2,2).
0.1 :: digit(img,3,2,3).

0.1 :: digit(img,3,3,0).
0.1 :: digit(img,3,3,1).
0.1 :: digit(img,3,3,2).
0.1 :: digit(img,3,3,3).


createFake3x3(X, [
    [D1, D2, D3],
    [D4, D5, D6], 
    [D7, D8, D9]
]) :- 
    digit(X,1,1,D1), digit(X,1,2,D2), digit(X,1,3,D3), 
    digit(X,2,1,D4), digit(X,2,2,D5), digit(X,2,3,D6), 
    digit(X,3,1,D7), digit(X,3,2,D8), digit(X,3,3,D9).


giveRightNumber(0, _).
giveRightNumber(FH, FH).

realColumns([], []).
realColumns(FakeCol, Col) :- 
    FakeCol = [FH|FT],
    Col = [H|T],
    giveRightNumber(FH, H),
    realColumns(FT, T).

realRows([], []).
realRows(FakeRows, Rows) :- 
    FakeRows = [FH|FT],
    Rows = [H|T],
    realColumns(FH, H),
    realRows(FT, T).
    
inList(X, [X|_]).
inList(X, [_|Tail]) :- 
    inList(X, Tail).

listInList([], _).
listInList([H|T], L) :- inList(H, L), listInList(T, L).

allDiff([]).
allDiff([X|Tail]) :- 
    \+ inList(X, Tail),
    allDiff(Tail).

transpose([[]|_], []).
transpose(Matrix, [Row|Rows]) :- transpose_1st_col(Matrix, Row, RestMatrix),
                                 transpose(RestMatrix, Rows).
transpose_1st_col([], [], []).
transpose_1st_col([[H|T]|Rows], [H|Hs], [T|Ts]) :- transpose_1st_col(Rows, Hs, Ts).


solve3x3(X, Rows) :-
    createFake3x3(X, Fake),
    realRows(Fake, Rows),
    maplist(listInList([1,2,3]), Rows),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns).

query(solve3x3(img, [
    [1,2,3],
    [2,3,1],
    [3,1,2]
])).