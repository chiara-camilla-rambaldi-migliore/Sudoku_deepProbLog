nn(sudoku_net,[X, R, C],Y,[0,1,2,3,4,5,6,7,8,9]) :: digit(X,R,C,Y).

createFake(X, [
    [D1,  D2,  D3,  D4,  D5,  D6,  D7,  D8 , D9],
    [D10, D11, D12, D13, D14, D15, D16, D17, D18],
    [D19, D20, D21, D22, D23, D24, D25, D26, D27],
    [D28, D29, D30, D31, D32, D33, D34, D35, D36],
    [D37, D38, D39, D40, D41, D42, D43, D44, D45],
    [D46, D47, D48, D49, D50, D51, D52, D53, D54],
    [D55, D56, D57, D58, D59, D60, D61, D62, D63],
    [D64, D65, D66, D67, D68, D69, D70, D71, D72],
    [D73, D74, D75, D76, D77, D78, D79, D80, D81]
]) :- 
    digit(X,1,1,D1), digit(X,1,2,D2), digit(X,1,3,D3),
    digit(X,1,4,D4), digit(X,1,5,D5), digit(X,1,6,D6),
    digit(X,1,7,D7), digit(X,1,8,D8), digit(X,1,9,D9),

    digit(X,2,1,D10), digit(X,2,2,D11), digit(X,2,3,D12),
    digit(X,2,4,D13), digit(X,2,5,D14), digit(X,2,6,D15),
    digit(X,2,7,D16), digit(X,2,8,D17), digit(X,2,9,D18),
    
    digit(X,3,1,D19), digit(X,3,2,D20), digit(X,3,3,D21),
    digit(X,3,4,D22), digit(X,3,5,D23), digit(X,3,6,D24),
    digit(X,3,7,D25), digit(X,3,8,D26), digit(X,3,9,D27),
    
    digit(X,4,1,D28), digit(X,4,2,D29), digit(X,4,3,D30),
    digit(X,4,4,D31), digit(X,4,5,D32), digit(X,4,6,D33),
    digit(X,4,7,D34), digit(X,4,8,D35), digit(X,4,9,D36),
    
    digit(X,5,1,D37), digit(X,5,2,D38), digit(X,5,3,D39),
    digit(X,5,4,D40), digit(X,5,5,D41), digit(X,5,6,D42),
    digit(X,5,7,D43), digit(X,5,8,D44), digit(X,5,9,D45),
    
    digit(X,6,1,D46), digit(X,6,2,D47), digit(X,6,3,D48),
    digit(X,6,4,D49), digit(X,6,5,D50), digit(X,6,6,D51),
    digit(X,6,7,D52), digit(X,6,8,D53), digit(X,6,9,D54),
    
    digit(X,7,1,D55), digit(X,7,2,D56), digit(X,7,3,D57),
    digit(X,7,4,D58), digit(X,7,5,D59), digit(X,7,6,D60),
    digit(X,7,7,D61), digit(X,7,8,D62), digit(X,7,9,D63),
    
    digit(X,8,1,D64), digit(X,8,2,D65), digit(X,8,3,D66),
    digit(X,8,4,D67), digit(X,8,5,D68), digit(X,8,6,D69),
    digit(X,8,7,D70), digit(X,8,8,D71), digit(X,8,9,D72),
    
    digit(X,9,1,D73), digit(X,9,2,D74), digit(X,9,3,D75),
    digit(X,9,4,D76), digit(X,9,5,D77), digit(X,9,6,D78),
    digit(X,9,7,D79), digit(X,9,8,D80), digit(X,9,9,D81).

createFake4x4(X, [
    [D1,  D2,  D3,  D4 ],
    [D5,  D6,  D7,  D8 ],
    [D9,  D10, D11, D12],
    [D13, D14, D15, D16]
]) :- 
    digit(X,1,1,D1), digit(X,1,2,D2), digit(X,1,3,D3), digit(X,1,4,D4), 
    digit(X,1,5,D5), digit(X,1,6,D6), digit(X,1,7,D7), digit(X,1,8,D8), 
    digit(X,1,9,D9), digit(X,2,1,D10), digit(X,2,2,D11), digit(X,2,3,D12),
    digit(X,2,4,D13), digit(X,2,5,D14), digit(X,2,6,D15), digit(X,2,7,D16).

createFake6x6(X, [
    [ D1,  D2,  D3,  D4,  D5,  D6],
    [ D7,  D8,  D9, D10, D11, D12],
    [D13, D14, D15, D16, D17, D18],
    [D19, D20, D21, D22, D23, D24], 
    [D25, D26, D27, D28, D29, D30],
    [D31, D32, D33, D34, D35, D36]
]) :- 
    digit(X,1,1,D1), digit(X,1,2,D2), digit(X,1,3,D3),
    digit(X,1,4,D4), digit(X,1,5,D5), digit(X,1,6,D6),
    digit(X,1,7,D7), digit(X,1,8,D8), digit(X,1,9,D9),
    digit(X,2,1,D10), digit(X,2,2,D11), digit(X,2,3,D12),
    
    digit(X,2,4,D13), digit(X,2,5,D14), digit(X,2,6,D15),
    digit(X,2,7,D16), digit(X,2,8,D17), digit(X,2,9,D18),
    digit(X,3,1,D19), digit(X,3,2,D20), digit(X,3,3,D21),
    digit(X,3,4,D22), digit(X,3,5,D23), digit(X,3,6,D24),
    
    digit(X,3,7,D25), digit(X,3,8,D26), digit(X,3,9,D27),
    digit(X,4,1,D28), digit(X,4,2,D29), digit(X,4,3,D30),
    digit(X,4,4,D31), digit(X,4,5,D32), digit(X,4,6,D33),
    digit(X,4,7,D34), digit(X,4,8,D35), digit(X,4,9,D36).


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

solve(X, Rows) :-
    createFake(X, Fake),
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

solve4x4(X, Rows) :-
    createFake4x4(X, Fake),
    realRows(Fake, Rows),
    append(Rows, Vs),
    listInList(Vs, [1,2,3,4]),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    Rows = [As, Bs, Cs, Ds],
    squares2x2(As, Bs),
    squares2x2(Cs, Ds).

solve6x6(X, Rows) :-
    createFake6x6(X, Fake),
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

solveRelaxed(X, Rows) :-
    createFake(X, Fake),
    realRows(Fake, Rows),
    append(Rows, Vs),
    listInList(Vs, [1,2,3,4,5,6,7,8,9]),
    maplist(allDiff, Rows).

solve_test(X, Rows) :- 
    digit(X,1,1,D1), digit(X,1,2,D2), digit(X,1,3,D3), digit(X,1,4,D4), digit(X,1,4,D5),
    Rows = [D1, D2, D3, D4, D5].