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

definition --> "(define ", identifier(I),  " ", number(I2), ")", !.

number([H|T]) --> digit(H), number(T).
number([H|T]) --> period(H), (digits(T) ; []).
number([H]) --> [H].

digits([H|T]) --> digit(H), digits(T).
digits([H]) --> digit(H).
identifier([H|T]) --> alphanum(H), identifier(T).
identifier([H]) --> alphanum(H).


digit(D) --> [D], {code_type(D, digit)}.
alphanum(C) --> [C], { code_type(C, alnum)}.
period(P) --> [P], {char_code(., P)}.



%% Boolean formulas

bexp --> bterm, " OR ", bexp.
bexp --> bterm.
bexp --> [].

bterm --> notfactor.
bterm --> notfactor, " AND ", bterm.

notfactor --> bfactor.
notfactor --> "NOT ", bfactor.

bfactor --> (blit; bvar; "(", bexp, ")"). 


blit --> ("0"; "1").
bvar --> identifier(I).
