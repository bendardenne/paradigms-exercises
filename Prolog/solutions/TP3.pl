% For tests
accepts(G,S) :- string_codes(S,L), phrase(G, L). 


%%%%%%%%%%%%%%%%%
% 1. DCG BASICS %
%%%%%%%%%%%%%%%%%

as --> [].
as --> [a], bs.

bs --> [].
bs --> [b], as.


as2 --> [].
as2 --> ([a]; [b]), as2.

article_phrase --> ("a" ; "an"),
	" ",
	noun.

noun --> "book".
noun --> "car".


%%%%%%%%%%%%%%%%%%%%%
% 2. PROLOG AND DCG %
%%%%%%%%%%%%%%%%%%%%%

definition --> "(define ", identifier,  " ", number, ")", !.

number --> digit.
number --> digit, number.
number --> period, (digits ; []).

digits --> digit, digits.
digits --> digit.
identifier --> alphanum, identifier.
identifier --> alphanum.


digit --> [D], {code_type(D, digit)}.
alphanum --> [C], { code_type(C, alnum)}.
period --> [P], {char_code(., P)}.



%% Boolean formulas, without parse tree

%bexp --> bterm, " OR ", bexp.
%bexp --> bterm.
%
%bterm --> notfactor.
%bterm --> notfactor, " AND ", bterm.
%
%notfactor --> bfactor.
%notfactor --> "NOT ", bfactor.
%
%bfactor --> (blit; bvar; "(", bexp, ")"). 
%
%
%blit --> ("0"; "1").
%bvar --> identifier.

%%%%%%%%%%%%%%%%%%
% 3. PARSE TREES %
%%%%%%%%%%%%%%%%%%

%% Boolean formulas with parse tree

letters([A|L]) --> alpha(A), letters(L).
letters([A]) --> alpha(A).
alpha(C) --> [C], { code_type(C, alpha)}.

bexp(bexp(Bterm, or, Bexp)) --> bterm(Bterm), " OR ", bexp(Bexp).
bexp(bexp(Bterm)) --> bterm(Bterm).

bterm(bterm(Notfactor)) --> notfactor(Notfactor).
bterm(bterm(Notfactor, and, Bterm)) --> notfactor(Notfactor), " AND ", bterm(Bterm).

notfactor(notfactor(Bfactor)) --> bfactor(Bfactor).
notfactor(not, notfactor(Bfactor)) --> "NOT ", bfactor(Bfactor).

bfactor(bfactor(X)) --> (blit(X); bvar(X); "(", bexp(X), ")"). 


blit(blit(0)) --> "0".
blit(blit(1)) --> "1".
bvar(bvar(Atom)) --> letters(Identifier), {atom_codes(Atom, Identifier)}.


%% Boolean interpreter
% example:  assert(a), assert(b :- false),  accepts(bexp(F), "a OR b"), eval(F)

eval(bexp(A, or, B)) :- eval(A) ; eval(B).
eval(bexp(A)) :- eval(A).

eval(bterm(A, and, B)) :- eval(A), eval(B).
eval(bterm(A)) :- eval(A).

eval(notfactor(not, A)) :- not(eval(A)).
eval(notfactor(A)) :- eval(A).

eval(bfactor(A)) :- eval(A).
eval(blit(1)) :- true.
eval(blit(0)) :- false.
eval(bvar(A)) :- A.
