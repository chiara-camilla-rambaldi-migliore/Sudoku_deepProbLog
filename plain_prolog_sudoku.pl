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

latinSquare([], []).
latinSquare([H_Rows|T_Rows], [H_Cols|T_Cols]) :-
    allDiff(H_Rows),
    allDiff(H_Cols),
    latinSquare(T_Rows, T_Cols).

itemsNumber(0, []).
itemsNumber(X, [_|L]) :-
    itemsNumber(X2, L),
    X is X2+1.

matrixDim(0, 0, []).
matrixDim(1, C, [H|[]]) :-
    itemsNumber(C, H).

matrixDim(R, C, [H|T]) :-
    itemsNumber(R, [H|T]),
    itemsNumber(C, H),
    matrixDim(R2, C, T),
    R is R2+1.


transpose([[]|_], []).
transpose(Matrix, [Row|Rows]) :- transpose_1st_col(Matrix, Row, RestMatrix),
                                 transpose(RestMatrix, Rows).
transpose_1st_col([], [], []).
transpose_1st_col([[H|T]|Rows], [H|Hs], [T|Ts]) :- transpose_1st_col(Rows, Hs, Ts).

squares([],[],[]).
squares([N1,N2,N3|Ns1],
        [N4,N5,N6|Ns2],
        [N7,N8,N9|Ns3]) :-
    allDiff([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
    squares(Ns1, Ns2, Ns3).

squares2x2([],[]).
squares2x2([N1,N2|Ns1],
           [N3,N4|Ns2]) :-
    allDiff([N1,N2,N3,N4]),
    squares2x2(Ns1, Ns2).

rectangles2x3([],[]).
rectangles2x3([N1,N2,N3|Ns1],
              [N4,N5,N6|Ns2]) :-
    allDiff([N1,N2,N3,N4,N5,N6]),
    rectangles2x3(Ns1, Ns2).

solve(Fake, Rows) :-
    realRows(Fake, Rows),
    append(Rows, Vs),
    listInList(Vs, [1,2,3,4,5,6,7,8,9]),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    Rows = [As, Bs, Cs, Ds, Es, Fs, Gs, Hs, Is],
    squares(As, Bs, Cs),
    squares(Ds, Es, Fs),
    squares(Gs, Hs, Is).

solve4x4(Fake, Rows) :-
    realRows(Fake, Rows),
    append(Rows, Vs),
    listInList(Vs, [1,2,3,4]),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    Rows = [As, Bs, Cs, Ds],
    squares2x2(As, Bs),
    squares2x2(Cs, Ds).

solve6x6(Fake, Rows) :-
    realRows(Fake, Rows),
    append(Rows, Vs),
    listInList(Vs, [1,2,3,4,5,6]),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    Rows = [As, Bs, Cs, Ds, Es, Fs],
    rectangles2x3(As, Bs),
    rectangles2x3(Cs, Ds),
    rectangles2x3(Es, Fs).

sudoku(1, [
    [0,0,0,5,4,0,0,0,0],
    [2,0,0,3,0,7,9,0,0],
    [8,0,3,0,2,0,0,0,7],
    [5,0,2,0,0,0,6,0,0],
    [6,3,0,0,0,0,0,2,8],
    [0,0,4,0,0,0,7,0,9],
    [9,0,0,0,6,0,4,0,3],
    [0,0,6,9,0,8,0,0,5],
    [0,0,0,0,1,2,0,0,0]
]).

sudoku(2, [
    [0,0,0,0],
    [0,3,0,1],
    [2,0,1,0],
    [0,0,0,0]
]).

sudoku(3, [
    [2,0,0,5,1,0],
    [6,0,5,0,0,0],
    [0,0,0,3,6,1],
    [0,6,3,4,2,0],
    [0,4,0,6,5,0],
    [0,2,6,1,4,0]
]).