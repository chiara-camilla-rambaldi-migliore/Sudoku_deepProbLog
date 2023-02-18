0.1 :: digit(img,1,1,0).
0.4 :: digit(img,1,1,1).
0.1 :: digit(img,1,1,2).
0.2 :: digit(img,1,1,3).
0.2 :: digit(img,1,1,4).

0.4 :: digit(img,1,2,0).
0.1 :: digit(img,1,2,1).
0.2 :: digit(img,1,2,2).
0.2 :: digit(img,1,2,3).
0.1 :: digit(img,1,2,4).

0.4 :: digit(img,1,3,0).
0.1 :: digit(img,1,3,1).
0.2 :: digit(img,1,3,2).
0.2 :: digit(img,1,3,3).
0.1 :: digit(img,1,3,4).

0.1 :: digit(img,1,4,0).
0.1 :: digit(img,1,4,1).
0.1 :: digit(img,1,4,2).
0.1 :: digit(img,1,4,3).
0.1 :: digit(img,1,4,4).

0.1 :: digit(img,2,1,0).
0.1 :: digit(img,2,1,1).
0.1 :: digit(img,2,1,2).
0.1 :: digit(img,2,1,3).
0.1 :: digit(img,2,1,4).

0.1 :: digit(img,2,2,0).
0.1 :: digit(img,2,2,1).
0.1 :: digit(img,2,2,2).
0.1 :: digit(img,2,2,3).
0.1 :: digit(img,2,2,4).

0.1 :: digit(img,2,3,0).
0.1 :: digit(img,2,3,1).
0.1 :: digit(img,2,3,2).
0.1 :: digit(img,2,3,3).
0.1 :: digit(img,2,3,4).

0.1 :: digit(img,2,4,0).
0.1 :: digit(img,2,4,1).
0.1 :: digit(img,2,4,2).
0.1 :: digit(img,2,4,3).
0.1 :: digit(img,2,4,4).

0.1 :: digit(img,3,1,0).
0.1 :: digit(img,3,1,1).
0.1 :: digit(img,3,1,2).
0.1 :: digit(img,3,1,3).
0.1 :: digit(img,3,1,4).

0.1 :: digit(img,3,2,0).
0.1 :: digit(img,3,2,1).
0.1 :: digit(img,3,2,2).
0.1 :: digit(img,3,2,3).
0.1 :: digit(img,3,2,4).

0.1 :: digit(img,3,3,0).
0.1 :: digit(img,3,3,1).
0.1 :: digit(img,3,3,2).
0.1 :: digit(img,3,3,3).
0.1 :: digit(img,3,3,4).

0.1 :: digit(img,3,4,0).
0.1 :: digit(img,3,4,1).
0.1 :: digit(img,3,4,2).
0.1 :: digit(img,3,4,3).
0.1 :: digit(img,3,4,4).

0.1 :: digit(img,4,1,0).
0.1 :: digit(img,4,1,1).
0.1 :: digit(img,4,1,2).
0.1 :: digit(img,4,1,3).
0.1 :: digit(img,4,1,4).

0.1 :: digit(img,4,2,0).
0.1 :: digit(img,4,2,1).
0.1 :: digit(img,4,2,2).
0.1 :: digit(img,4,2,3).
0.1 :: digit(img,4,2,4).

0.1 :: digit(img,4,3,0).
0.1 :: digit(img,4,3,1).
0.1 :: digit(img,4,3,2).
0.1 :: digit(img,4,3,3).
0.1 :: digit(img,4,3,4).

0.1 :: digit(img,4,4,0).
0.1 :: digit(img,4,4,1).
0.1 :: digit(img,4,4,2).
0.1 :: digit(img,4,4,3).
0.1 :: digit(img,4,4,4).

createFake4x4(X, [
    [D1,  D2,  D3,  D4 ],
    [D5,  D6,  D7,  D8 ],
    [D9,  D10, D11, D12],
    [D13, D14, D15, D16]
]) :- 
    digit(X,1,1,D1), digit(X,1,2,D2), digit(X,1,3,D3), digit(X,1,4,D4), 
    digit(X,2,1,D5), digit(X,2,2,D6), digit(X,2,3,D7), digit(X,2,4,D8), 
    digit(X,3,1,D9), digit(X,3,2,D10), digit(X,3,3,D11), digit(X,3,4,D12),
    digit(X,4,1,D13), digit(X,4,2,D14), digit(X,4,3,D15), digit(X,4,4,D16).


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

solve4x4(X, Rows) :-
    createFake4x4(X, Fake),
    realRows(Fake, Rows),
    maplist(listInList([1,2,3,4]), Rows),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    Rows = [As, Bs, Cs, Ds],
    squares2x2(As, Bs),
    squares2x2(Cs, Ds).

query(solve4x4(img, [
    [0,0,0,0],
    [0,3,0,1],
    [2,0,1,0],
    [0,0,0,0]
])).