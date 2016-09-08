
%%%%%%%%%%%%%%%%
%% 1. CACHING %%
%%%%%%%%%%%%%%%%


%% Fibonacci

fib1(0,1).
fib1(1,1).
fib1(N,F) :- Nmin1 is N-1, fib1(Nmin1,F1), Nmin2 is N-2, 
			fib1(Nmin2,F2), F is F1+F2.

%% With caching

:- dynamic fib2/2.
fib2(0,1).
fib2(1,1).
fib2(N,F) :- Nmin2 is N-2, fib2(Nmin2,F2),
			 Nmin1 is N-1, fib2(Nmin1,F1), 
			 F is F1+F2, asserta(fib2(N,F)).


%%%%%%%%%%%%%%%%%%%%%
%% 2. IS PREIDCATE %%
%%%%%%%%%%%%%%%%%%%%%


%% power

power(0, X, 0) :- X > 0.
power(X, 0, 1) :- X > 0.
power(X, N, Z) :- power(X,M,ZdivX), N is M+1, Z is X * ZdivX. 



%%%%%%%%%%%%%
%% 3. CUTS %%
%%%%%%%%%%%%%

% First implementation of f
f1(X,0) :- X<3.
f1(X,2) :- 3=<X, X<6.
f1(X,4) :- 6=<X.


%% merge(List1,List2,Result)

merge1([X|Xs],[Y|Ys],[X|M]) :- X<Y, merge1(Xs,[Y|Ys],M).
merge1([X|Xs],[Y|Ys],[X,Y|M]) :- X=Y, merge1(Xs,Ys,M).
merge1([X|Xs],[Y|Ys],[Y|M]) :- X>Y, merge1([X|Xs],Ys,M).
merge1([],Ys,Ys).
merge1(Xs,[],Xs).

% With green cuts.

merge2([X|Xs],[Y|Ys],[X|M]) :- X<Y, !, merge2(Xs,[Y|Ys],M).
merge2([X|Xs],[Y|Ys],[X,Y|M]) :- X=Y, !, merge2(Xs,Ys,M).
merge2([X|Xs],[Y|Ys],[Y|M]) :- X>Y, !, merge2([X|Xs],Ys,M).
merge2([],Ys,Ys) :- !.
merge2(Xs,[],Xs) :- !.

% With red cuts

merge3([X|Xs],[Y|Ys],[X|M]) :- X<Y, !, merge3(Xs,[Y|Ys],M).
merge3([X|Xs],[X|Ys],[X,X|M]) :- !, merge3(Xs,Ys,M).
merge3([X|Xs],[Y|Ys],[Y|M]) :- !, merge3([X|Xs],Ys,M).
merge3([],Ys,Ys) :- !.
merge3(Xs,[],Xs) :- !.



%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. META-INTERPRETER %%
%%%%%%%%%%%%%%%%%%%%%%%%%


%% solve with proof tree

solve(true, true) :- !.
solve((A, B),(ProofA, ProofB)) :- !, solve(A, ProofA), solve(B, ProofB).
solve(not(A), not(ProofA)) :- not(solve(A, ProofA)).
solve(A, (A :- ProofB)) :- clause(A, B), solve(B, ProofB).


% Simply logical:
prove(true):-!.
prove((A,B)):-!,
	prove(A),
	prove(B).
prove(A):-
	/* not A=true, not A=(X,Y) */
	clause(A,B),
	prove(B).

