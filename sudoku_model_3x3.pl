:- use_module(library(lists)).
:- use_module(library(apply)).

nn(sudoku_net,[X, R, C],Y,[0,1,2,3]) :: digit(X,R,C,Y).

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


solve3x3_both(X, Label) :-
    createFake3x3(X, Fake),
    realRows(Fake, Rows),
    maplist(listInList([1,2,3]), Rows),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    label_empty(Label, Fake),
    label_compl(Label, Rows).

solve3x3_empty(X, Label) :-
    createFake3x3(X, Fake),
    realRows(Fake, Rows),
    maplist(listInList([1,2,3]), Rows),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    label_empty(Label, Fake).

solve3x3_compl(X, Label) :-
    createFake3x3(X, Fake),
    realRows(Fake, Rows),
    maplist(listInList([1,2,3]), Rows),
    maplist(allDiff, Rows),
    transpose(Rows, Columns),
    maplist(allDiff, Columns),
    label_compl(Label, Rows).

label_empty(1, L) :- L = [[1,0,0],[0,0,1],[0,1,2]].
label_empty(2, L) :- L = [[0,3,0],[0,0,0],[3,2,1]].
label_empty(3, L) :- L = [[0,3,0],[0,0,1],[0,0,3]].
label_empty(4, L) :- L = [[2,0,3],[0,0,0],[3,0,1]].
label_empty(5, L) :- L = [[2,0,0],[0,0,1],[0,3,2]].
label_empty(6, L) :- L = [[0,1,0],[0,0,0],[2,3,1]].
label_empty(7, L) :- L = [[0,1,0],[0,0,1],[0,0,3]].
label_empty(8, L) :- L = [[2,0,1],[0,0,0],[3,0,2]].
label_empty(9, L) :- L = [[2,0,0],[0,0,2],[1,2,3]].
label_empty(10, L) :- L = [[0,2,0],[0,0,0],[2,1,3]].
label_empty(11, L) :- L = [[0,2,0],[0,0,3],[0,0,2]].
label_empty(12, L) :- L = [[1,0,3],[0,0,0],[2,0,1]].
label_empty(13, L) :- L = [[1,0,3],[0,0,0],[3,1,2]].
label_empty(14, L) :- L = [[0,3,0],[0,0,3],[0,0,1]].
label_empty(15, L) :- L = [[1,0,2],[0,0,0],[2,0,3]].
label_empty(16, L) :- L = [[2,0,0],[0,0,2],[0,2,1]].
label_empty(17, L) :- L = [[2,0,3],[0,0,0],[1,3,2]].
label_empty(18, L) :- L = [[0,1,0],[0,0,3],[0,0,1]].
label_empty(19, L) :- L = [[3,0,2],[0,0,0],[1,0,3]].
label_empty(20, L) :- L = [[2,0,0],[0,0,3],[0,1,2]].
label_empty(21, L) :- L = [[2,0,1],[0,0,0],[1,2,3]].
label_empty(22, L) :- L = [[0,2,0],[0,0,2],[0,0,3]].
label_empty(23, L) :- L = [[3,0,1],[0,0,0],[1,0,2]].
label_empty(24, L) :- L = [[1,0,0],[0,0,2],[0,3,1]].
label_empty(25, L) :- L = [[0,2,0],[0,0,1],[0,0,2]].
label_empty(26, L) :- L = [[1,0,2],[0,0,0],[3,0,1]].
label_empty(27, L) :- L = [[1,0,0],[0,0,1],[0,1,3]].
label_empty(28, L) :- L = [[2,0,3],[0,0,0],[3,2,1]].
label_empty(29, L) :- L = [[0,1,0],[0,0,1],[0,0,2]].
label_empty(30, L) :- L = [[3,0,2],[0,0,0],[2,0,1]].
label_empty(31, L) :- L = [[3,0,0],[0,0,1],[0,2,3]].
label_empty(32, L) :- L = [[2,0,1],[0,0,0],[3,1,2]].
label_empty(33, L) :- L = [[0,3,0],[0,0,2],[0,0,3]].
label_empty(34, L) :- L = [[3,0,1],[0,0,0],[2,0,3]].
label_empty(35, L) :- L = [[3,0,0],[0,0,3],[0,3,2]].
label_empty(36, L) :- L = [[1,0,3],[0,0,0],[2,3,1]].
label_empty(37, L) :- L = [[1,0,3],[0,0,0],[3,0,2]].
label_empty(38, L) :- L = [[1,0,0],[0,0,3],[0,2,1]].
label_empty(39, L) :- L = [[1,0,2],[0,0,0],[2,1,3]].
label_empty(40, L) :- L = [[0,1,0],[0,0,2],[0,0,1]].
label_empty(41, L) :- L = [[2,0,3],[0,0,0],[1,0,2]].
label_empty(42, L) :- L = [[3,0,0],[0,0,3],[0,3,1]].
label_empty(43, L) :- L = [[3,0,2],[0,0,0],[1,2,3]].
label_empty(44, L) :- L = [[0,3,0],[0,0,3],[0,0,2]].
label_empty(45, L) :- L = [[2,0,1],[0,0,0],[1,0,3]].
label_empty(46, L) :- L = [[3,0,0],[0,0,2],[0,1,3]].
label_empty(47, L) :- L = [[3,0,1],[0,0,0],[1,3,2]].
label_empty(48, L) :- L = [[0,2,0],[0,0,2],[0,0,1]].
label_empty(49, L) :- L = [[0,0,3],[2,0,0],[3,1,0]].
label_empty(50, L) :- L = [[1,3,2],[0,0,0],[3,0,1]].
label_empty(51, L) :- L = [[0,3,0],[3,0,0],[2,0,0]].
label_empty(52, L) :- L = [[0,1,0],[1,0,2],[0,2,0]].
label_empty(53, L) :- L = [[0,0,3],[3,0,0],[1,3,0]].
label_empty(54, L) :- L = [[3,1,2],[0,0,0],[2,0,1]].
label_empty(55, L) :- L = [[0,1,0],[2,0,0],[1,0,0]].
label_empty(56, L) :- L = [[0,3,0],[1,0,3],[0,1,0]].
label_empty(57, L) :- L = [[0,0,1],[3,0,0],[1,2,0]].
label_empty(58, L) :- L = [[3,2,1],[0,0,0],[2,0,3]].
label_empty(59, L) :- L = [[0,2,0],[2,0,0],[1,0,0]].
label_empty(60, L) :- L = [[0,2,0],[3,0,2],[0,3,0]].
label_empty(61, L) :- L = [[1,2,3],[0,0,0],[3,0,2]].
label_empty(62, L) :- L = [[0,3,0],[2,0,0],[3,0,0]].
label_empty(63, L) :- L = [[0,3,0],[3,0,1],[0,1,0]].
label_empty(64, L) :- L = [[0,0,3],[1,0,0],[3,2,0]].
label_empty(65, L) :- L = [[2,1,3],[0,0,0],[1,0,2]].
label_empty(66, L) :- L = [[0,1,0],[1,0,0],[2,0,0]].
label_empty(67, L) :- L = [[0,1,0],[2,0,1],[0,2,0]].
label_empty(68, L) :- L = [[0,0,1],[1,0,0],[3,1,0]].
label_empty(69, L) :- L = [[2,3,1],[0,0,0],[1,0,3]].
label_empty(70, L) :- L = [[0,2,0],[1,0,0],[2,0,0]].
label_empty(71, L) :- L = [[0,2,0],[2,0,3],[0,3,0]].
label_empty(72, L) :- L = [[0,0,3],[3,0,0],[2,3,0]].
label_empty(73, L) :- L = [[0,2,0],[2,0,0],[3,0,0]].
label_empty(74, L) :- L = [[0,3,0],[2,0,3],[0,2,0]].
label_empty(75, L) :- L = [[0,0,2],[3,0,0],[2,1,0]].
label_empty(76, L) :- L = [[2,1,3],[0,0,0],[3,0,1]].
label_empty(77, L) :- L = [[0,1,0],[3,0,0],[1,0,0]].
label_empty(78, L) :- L = [[0,1,0],[1,0,3],[0,3,0]].
label_empty(79, L) :- L = [[0,0,2],[2,0,0],[1,2,0]].
label_empty(80, L) :- L = [[2,3,1],[0,0,0],[3,0,2]].
label_empty(81, L) :- L = [[0,3,0],[3,0,0],[1,0,0]].
label_empty(82, L) :- L = [[0,2,0],[1,0,2],[0,1,0]].
label_empty(83, L) :- L = [[0,0,1],[2,0,0],[1,3,0]].
label_empty(84, L) :- L = [[1,2,3],[0,0,0],[2,0,1]].
label_empty(85, L) :- L = [[0,2,0],[2,0,1],[0,1,0]].
label_empty(86, L) :- L = [[0,0,2],[2,0,0],[3,2,0]].
label_empty(87, L) :- L = [[1,3,2],[0,0,0],[2,0,3]].
label_empty(88, L) :- L = [[0,1,0],[1,0,0],[3,0,0]].
label_empty(89, L) :- L = [[0,1,0],[3,0,1],[0,3,0]].
label_empty(90, L) :- L = [[0,0,2],[1,0,0],[2,3,0]].
label_empty(91, L) :- L = [[3,1,2],[0,0,0],[1,0,3]].
label_empty(92, L) :- L = [[0,3,0],[1,0,0],[3,0,0]].
label_empty(93, L) :- L = [[0,3,0],[3,0,2],[0,2,0]].
label_empty(94, L) :- L = [[0,0,1],[1,0,0],[2,1,0]].
label_empty(95, L) :- L = [[3,2,1],[0,0,0],[1,0,2]].
label_empty(96, L) :- L = [[0,2,0],[3,0,0],[2,0,0]].

label_compl(1, L) :- L = [[1,2,3],[2,3,1],[3,1,2]].
label_compl(2, L) :- L = [[1,3,2],[2,1,3],[3,2,1]].
label_compl(3, L) :- L = [[1,3,2],[3,2,1],[2,1,3]].
label_compl(4, L) :- L = [[2,1,3],[1,3,2],[3,2,1]].
label_compl(5, L) :- L = [[2,1,3],[3,2,1],[1,3,2]].
label_compl(6, L) :- L = [[3,1,2],[1,2,3],[2,3,1]].
label_compl(7, L) :- L = [[3,1,2],[2,3,1],[1,2,3]].
label_compl(8, L) :- L = [[2,3,1],[1,2,3],[3,1,2]].
label_compl(9, L) :- L = [[2,3,1],[3,1,2],[1,2,3]].
label_compl(10, L) :- L = [[3,2,1],[1,3,2],[2,1,3]].
label_compl(11, L) :- L = [[3,2,1],[2,1,3],[1,3,2]].
label_compl(12, L) :- L = [[1,2,3],[3,1,2],[2,3,1]].
label_compl(13, L) :- L = [[1,2,3],[2,3,1],[3,1,2]].
label_compl(14, L) :- L = [[1,3,2],[2,1,3],[3,2,1]].
label_compl(15, L) :- L = [[1,3,2],[3,2,1],[2,1,3]].
label_compl(16, L) :- L = [[2,1,3],[1,3,2],[3,2,1]].
label_compl(17, L) :- L = [[2,1,3],[3,2,1],[1,3,2]].
label_compl(18, L) :- L = [[3,1,2],[1,2,3],[2,3,1]].
label_compl(19, L) :- L = [[3,1,2],[2,3,1],[1,2,3]].
label_compl(20, L) :- L = [[2,3,1],[1,2,3],[3,1,2]].
label_compl(21, L) :- L = [[2,3,1],[3,1,2],[1,2,3]].
label_compl(22, L) :- L = [[3,2,1],[1,3,2],[2,1,3]].
label_compl(23, L) :- L = [[3,2,1],[2,1,3],[1,3,2]].
label_compl(24, L) :- L = [[1,2,3],[3,1,2],[2,3,1]].
label_compl(25, L) :- L = [[1,2,3],[2,3,1],[3,1,2]].
label_compl(26, L) :- L = [[1,3,2],[2,1,3],[3,2,1]].
label_compl(27, L) :- L = [[1,3,2],[3,2,1],[2,1,3]].
label_compl(28, L) :- L = [[2,1,3],[1,3,2],[3,2,1]].
label_compl(29, L) :- L = [[2,1,3],[3,2,1],[1,3,2]].
label_compl(30, L) :- L = [[3,1,2],[1,2,3],[2,3,1]].
label_compl(31, L) :- L = [[3,1,2],[2,3,1],[1,2,3]].
label_compl(32, L) :- L = [[2,3,1],[1,2,3],[3,1,2]].
label_compl(33, L) :- L = [[2,3,1],[3,1,2],[1,2,3]].
label_compl(34, L) :- L = [[3,2,1],[1,3,2],[2,1,3]].
label_compl(35, L) :- L = [[3,2,1],[2,1,3],[1,3,2]].
label_compl(36, L) :- L = [[1,2,3],[3,1,2],[2,3,1]].
label_compl(37, L) :- L = [[1,2,3],[2,3,1],[3,1,2]].
label_compl(38, L) :- L = [[1,3,2],[2,1,3],[3,2,1]].
label_compl(39, L) :- L = [[1,3,2],[3,2,1],[2,1,3]].
label_compl(40, L) :- L = [[2,1,3],[1,3,2],[3,2,1]].
label_compl(41, L) :- L = [[2,1,3],[3,2,1],[1,3,2]].
label_compl(42, L) :- L = [[3,1,2],[1,2,3],[2,3,1]].
label_compl(43, L) :- L = [[3,1,2],[2,3,1],[1,2,3]].
label_compl(44, L) :- L = [[2,3,1],[1,2,3],[3,1,2]].
label_compl(45, L) :- L = [[2,3,1],[3,1,2],[1,2,3]].
label_compl(46, L) :- L = [[3,2,1],[1,3,2],[2,1,3]].
label_compl(47, L) :- L = [[3,2,1],[2,1,3],[1,3,2]].
label_compl(48, L) :- L = [[1,2,3],[3,1,2],[2,3,1]].
label_compl(49, L) :- L = [[1,2,3],[2,3,1],[3,1,2]].
label_compl(50, L) :- L = [[1,3,2],[2,1,3],[3,2,1]].
label_compl(51, L) :- L = [[1,3,2],[3,2,1],[2,1,3]].
label_compl(52, L) :- L = [[2,1,3],[1,3,2],[3,2,1]].
label_compl(53, L) :- L = [[2,1,3],[3,2,1],[1,3,2]].
label_compl(54, L) :- L = [[3,1,2],[1,2,3],[2,3,1]].
label_compl(55, L) :- L = [[3,1,2],[2,3,1],[1,2,3]].
label_compl(56, L) :- L = [[2,3,1],[1,2,3],[3,1,2]].
label_compl(57, L) :- L = [[2,3,1],[3,1,2],[1,2,3]].
label_compl(58, L) :- L = [[3,2,1],[1,3,2],[2,1,3]].
label_compl(59, L) :- L = [[3,2,1],[2,1,3],[1,3,2]].
label_compl(60, L) :- L = [[1,2,3],[3,1,2],[2,3,1]].
label_compl(61, L) :- L = [[1,2,3],[2,3,1],[3,1,2]].
label_compl(62, L) :- L = [[1,3,2],[2,1,3],[3,2,1]].
label_compl(63, L) :- L = [[1,3,2],[3,2,1],[2,1,3]].
label_compl(64, L) :- L = [[2,1,3],[1,3,2],[3,2,1]].
label_compl(65, L) :- L = [[2,1,3],[3,2,1],[1,3,2]].
label_compl(66, L) :- L = [[3,1,2],[1,2,3],[2,3,1]].
label_compl(67, L) :- L = [[3,1,2],[2,3,1],[1,2,3]].
label_compl(68, L) :- L = [[2,3,1],[1,2,3],[3,1,2]].
label_compl(69, L) :- L = [[2,3,1],[3,1,2],[1,2,3]].
label_compl(70, L) :- L = [[3,2,1],[1,3,2],[2,1,3]].
label_compl(71, L) :- L = [[3,2,1],[2,1,3],[1,3,2]].
label_compl(72, L) :- L = [[1,2,3],[3,1,2],[2,3,1]].
label_compl(73, L) :- L = [[1,2,3],[2,3,1],[3,1,2]].
label_compl(74, L) :- L = [[1,3,2],[2,1,3],[3,2,1]].
label_compl(75, L) :- L = [[1,3,2],[3,2,1],[2,1,3]].
label_compl(76, L) :- L = [[2,1,3],[1,3,2],[3,2,1]].
label_compl(77, L) :- L = [[2,1,3],[3,2,1],[1,3,2]].
label_compl(78, L) :- L = [[3,1,2],[1,2,3],[2,3,1]].
label_compl(79, L) :- L = [[3,1,2],[2,3,1],[1,2,3]].
label_compl(80, L) :- L = [[2,3,1],[1,2,3],[3,1,2]].
label_compl(81, L) :- L = [[2,3,1],[3,1,2],[1,2,3]].
label_compl(82, L) :- L = [[3,2,1],[1,3,2],[2,1,3]].
label_compl(83, L) :- L = [[3,2,1],[2,1,3],[1,3,2]].
label_compl(84, L) :- L = [[1,2,3],[3,1,2],[2,3,1]].
label_compl(85, L) :- L = [[1,2,3],[2,3,1],[3,1,2]].
label_compl(86, L) :- L = [[1,3,2],[2,1,3],[3,2,1]].
label_compl(87, L) :- L = [[1,3,2],[3,2,1],[2,1,3]].
label_compl(88, L) :- L = [[2,1,3],[1,3,2],[3,2,1]].
label_compl(89, L) :- L = [[2,1,3],[3,2,1],[1,3,2]].
label_compl(90, L) :- L = [[3,1,2],[1,2,3],[2,3,1]].
label_compl(91, L) :- L = [[3,1,2],[2,3,1],[1,2,3]].
label_compl(92, L) :- L = [[2,3,1],[1,2,3],[3,1,2]].
label_compl(93, L) :- L = [[2,3,1],[3,1,2],[1,2,3]].
label_compl(94, L) :- L = [[3,2,1],[1,3,2],[2,1,3]].
label_compl(95, L) :- L = [[3,2,1],[2,1,3],[1,3,2]].
label_compl(96, L) :- L = [[1,2,3],[3,1,2],[2,3,1]].