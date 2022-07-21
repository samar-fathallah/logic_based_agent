:- [kb].

neo(X,Y,Remaining,[],C,s0) :- neo_loc(X,Y), hostages_loc(Remaining), capacity(C).

neo(X1,Y,Remaining,Carried,C,result(A,S)) :- neo(X,Y,Remaining,Carried,C,S), A = up, X >= 0, succ(X1,X).
neo(X1,Y,Remaining,Carried,C,result(A,S)) :- neo(X,Y,Remaining,Carried,C,S), A = down, grid(N,_), X < N, succ(X,X1).
neo(X,Y1,Remaining,Carried,C,result(A,S)) :- neo(X,Y,Remaining,Carried,C,S), A = left, Y >= 0, succ(Y1,Y).
neo(X,Y1,Remaining,Carried,C,result(A,S)) :- neo(X,Y,Remaining,Carried,C,S), A = right, grid(_,N), Y < N, succ(Y,Y1).
neo(X,Y,Remaining1,[[X,Y]|Carried],C1,result(A,S)) :- neo(X,Y,Remaining,Carried,C,S), A = carry, C >= 0, member([X,Y], Remaining), delete(Remaining,[X,Y],Remaining1), succ(C1,C).
neo(X,Y,Remaining,[],C1,result(A,S)) :- neo(X,Y,Remaining,_,C,S), A = drop, booth(X,Y), capacity(C1), C < C1.

neo_at_goal(S) :- booth(X,Y), neo(X,Y,[],[],_,S).

goal(S) :- ids(neo_at_goal(S),20).
% goal(S) :- call_with_depth_limit(neo_at_goal(S),15,Result), Result \= depth_limit_exceeded.

ids(Goal,Max_Depth) :- between(1,Max_Depth,Depth), call_with_depth_limit(Goal,Depth,Result), Result \= depth_limit_exceeded.
