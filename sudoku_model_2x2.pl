:- use_module(library(lists)).
:- use_module(library(apply)).

nn(sudoku_net,[X, R, C],Y,[0,1,2]) :: digit(X,R,C,Y).

createFake2x2(X, [
    [D1, D2], 
    [D3, D4]
]) :- 
    digit(X,1,1,D1), digit(X,1,2,D2), 
    digit(X,2,1,D3), digit(X,2,2,D4).

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

solve2x2_both(X, Label) :-
    createFake2x2(X, Fake),
    realRows(Fake, Rows),
    maplist(listInList([1,2]), Rows),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    label_empty(Label, Fake),
    label_compl(Label, Rows).

solve2x2_empty(X, Label) :-
    createFake2x2(X, Fake),
    realRows(Fake, Rows),
    maplist(listInList([1,2]), Rows),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    label_empty(Label, Fake).

solve2x2_compl(X, Label) :-
    createFake2x2(X, Fake),
    realRows(Fake, Rows),
    maplist(listInList([1,2]), Rows),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    label_compl(Label, Rows).

label_empty(1, L) :- L = [[1,0],[0,0]].
label_empty(2, L) :- L = [[2,0],[0,0]].
label_empty(3, L) :- L = [[0,2],[0,0]].
label_empty(4, L) :- L = [[0,1],[0,0]].
label_empty(5, L) :- L = [[0,0],[2,0]].
label_empty(6, L) :- L = [[0,0],[1,0]].
label_empty(7, L) :- L = [[0,0],[0,1]].
label_empty(8, L) :- L = [[0,0],[0,2]].
label_empty(9, L) :- L = [[1,2],[0,0]].
label_empty(10, L) :- L = [[2,1],[0,0]].
label_empty(11, L) :- L = [[0,0],[2,1]].
label_empty(12, L) :- L = [[0,0],[1,2]].
label_empty(13, L) :- L = [[0,2],[0,1]].
label_empty(14, L) :- L = [[0,1],[0,2]].
label_empty(15, L) :- L = [[1,0],[2,0]].
label_empty(16, L) :- L = [[2,0],[1,0]].
label_empty(17, L) :- L = [[0,2],[2,1]].
label_empty(18, L) :- L = [[0,1],[1,2]].
label_empty(19, L) :- L = [[1,0],[2,1]].
label_empty(20, L) :- L = [[2,0],[1,2]].
label_empty(21, L) :- L = [[1,2],[0,1]].
label_empty(22, L) :- L = [[2,1],[0,2]].
label_empty(23, L) :- L = [[1,2],[2,0]].
label_empty(24, L) :- L = [[2,1],[1,0]].
label_empty(25, L) :- L = [[1,0],[0,1]].
label_empty(26, L) :- L = [[2,0],[0,2]].
label_empty(27, L) :- L = [[0,2],[2,0]].
label_empty(28, L) :- L = [[0,1],[1,0]].

label_compl(1, L) :- L = [[1,2],[2,1]].
label_compl(2, L) :- L = [[2,1],[1,2]].
label_compl(3, L) :- L = [[1,2],[2,1]].
label_compl(4, L) :- L = [[2,1],[1,2]].
label_compl(5, L) :- L = [[1,2],[2,1]].
label_compl(6, L) :- L = [[2,1],[1,2]].
label_compl(7, L) :- L = [[1,2],[2,1]].
label_compl(8, L) :- L = [[2,1],[1,2]].
label_compl(9, L) :- L = [[1,2],[2,1]].
label_compl(10, L) :- L = [[2,1],[1,2]].
label_compl(11, L) :- L = [[1,2],[2,1]].
label_compl(12, L) :- L = [[2,1],[1,2]].
label_compl(13, L) :- L = [[1,2],[2,1]].
label_compl(14, L) :- L = [[2,1],[1,2]].
label_compl(15, L) :- L = [[1,2],[2,1]].
label_compl(16, L) :- L = [[2,1],[1,2]].
label_compl(17, L) :- L = [[1,2],[2,1]].
label_compl(18, L) :- L = [[2,1],[1,2]].
label_compl(19, L) :- L = [[1,2],[2,1]].
label_compl(20, L) :- L = [[2,1],[1,2]].
label_compl(21, L) :- L = [[1,2],[2,1]].
label_compl(22, L) :- L = [[2,1],[1,2]].
label_compl(23, L) :- L = [[1,2],[2,1]].
label_compl(24, L) :- L = [[2,1],[1,2]].
label_compl(25, L) :- L = [[1,2],[2,1]].
label_compl(26, L) :- L = [[2,1],[1,2]].
label_compl(27, L) :- L = [[1,2],[2,1]].
label_compl(28, L) :- L = [[2,1],[1,2]].