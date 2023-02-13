:- use_module(library(clpfd)).

nn(sudoku_net,[X, R, C],Y,[0,1,2,3,4,5,6,7,8,9]) :: digit(X,R,C,Y).

createFake(X, [
    [d1,  d2,  d3,  d4,  d5,  d6,  d7,  d8 , d9],
    [d10, d11, d12, d13, d14, d15, d16, d17, d18],
    [d19, d20, d21, d22, d23, d24, d25, d26, d27],
    [d28, d29, d30, d31, d32, d33, d34, d35, d36],
    [d37, d38, d39, d40, d41, d42, d43, d44, d45],
    [d46, d47, d48, d49, d50, d51, d52, d53, d54],
    [d55, d56, d57, d58, d59, d60, d61, d62, d63],
    [d64, d65, d66, d67, d68, d69, d70, d71, d72],
    [d73, d74, d75, d76, d77, d78, d79, d80, d81]
]) :- 
    digit(X,1,1,d1), digit(X,1,2,d2), digit(X,1,3,d3),
    digit(X,1,4,d4), digit(X,1,5,d5), digit(X,1,6,d6),
    digit(X,1,7,d7), digit(X,1,8,d8), digit(X,1,9,d9),

    digit(X,2,1,d10), digit(X,2,2,d11), digit(X,2,3,d12),
    digit(X,2,4,d13), digit(X,2,5,d14), digit(X,2,6,d15),
    digit(X,2,7,d16), digit(X,2,8,d17), digit(X,2,9,d18),
    
    digit(X,3,1,d19), digit(X,3,2,d20), digit(X,3,3,d21),
    digit(X,3,4,d22), digit(X,3,5,d23), digit(X,3,6,d24),
    digit(X,3,7,d25), digit(X,3,8,d26), digit(X,3,9,d27),
    
    digit(X,4,1,d28), digit(X,4,2,d29), digit(X,4,3,d30),
    digit(X,4,4,d31), digit(X,4,5,d32), digit(X,4,6,d33),
    digit(X,4,7,d34), digit(X,4,8,d35), digit(X,4,9,d36),
    
    digit(X,5,1,d37), digit(X,5,2,d38), digit(X,5,3,d39),
    digit(X,5,4,d40), digit(X,5,5,d41), digit(X,5,6,d42),
    digit(X,5,7,d43), digit(X,5,8,d44), digit(X,5,9,d45),
    
    digit(X,6,1,d46), digit(X,6,2,d47), digit(X,6,3,d48),
    digit(X,6,4,d49), digit(X,6,5,d50), digit(X,6,6,d51),
    digit(X,6,7,d52), digit(X,6,8,d53), digit(X,6,9,d54),
    
    digit(X,7,1,d55), digit(X,7,2,d56), digit(X,7,3,d57),
    digit(X,7,4,d58), digit(X,7,5,d59), digit(X,7,6,d60),
    digit(X,7,7,d61), digit(X,7,8,d62), digit(X,7,9,d63),
    
    digit(X,8,1,d64), digit(X,8,2,d65), digit(X,8,3,d66),
    digit(X,8,4,d67), digit(X,8,5,d68), digit(X,8,6,d69),
    digit(X,8,7,d70), digit(X,8,8,d71), digit(X,8,9,d72),
    
    digit(X,9,1,d73), digit(X,9,2,d74), digit(X,9,3,d75),
    digit(X,9,4,d76), digit(X,9,5,d77), digit(X,9,6,d78),
    digit(X,9,7,d79), digit(X,9,8,d80), digit(X,9,9,d81).

inList(X, [X|_]).
inList(X, [_|Tail]) :- 
    inList(X, Tail).

listInList([], _).
listInList([H|T], L) :- inList(H, L); listInList(T, L).

solve(X, Rows) :-
    createFake(X, Fake),
    realRows(Fake, Rows),
    length(Rows, 9),
    % maplist(:Goal, ?List1)
    % call(same_length(Rows), Rows[i]), cioè same_length(Rows, Rows[i])
    % True if Goal is successfully applied on all matching elements of the list. The maplist family of predicates is defined as:
    maplist(same_length(Rows), Rows),
    % append(+ListOfLists, ?List)
    % Concatenate a list of lists
    append(Rows, Vs),
    % +Vars ins +Domain
    % The variables in the list Vars are elements of Domain
    % Vs ins 1..9,
    listInList(Vs, [1,2,3,4,5,6,7,8,9]),
    maplist(all_distinct, Rows),
    transpose(Rows, Columns),
    maplist(all_distinct, Columns),
    Rows = [As, Bs, Cs, Ds, Es, Fs, Gs, Hs, Is],
    squares(As, Bs, Cs),
    squares(Ds, Es, Fs),
    squares(Gs, Hs, Is).

squares([],[],[]).
squares([N1,N2,N3|Ns1],
        [N4,N5,N6|Ns2],
        [N7,N8,N9|Ns3]) :-
    all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
    squares(Ns1, Ns2, Ns3).

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
