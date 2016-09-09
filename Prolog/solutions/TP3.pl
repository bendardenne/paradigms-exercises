%%%%%%%%%%%%%%%%%
% 1. DCG BASICS %
%%%%%%%%%%%%%%%%%

as --> [].
as --> [a], bs.

bs --> [].
bs --> [b], as.

article_phrase --> ("a" ; "an"),
	" ",
	noun.

noun --> "book".
noun --> "car".


term --> "lambda".
term --> "plus".


%%%%%%%%%%%%%%%%%%%%%
% 2. PROLOG AND DCG %
%%%%%%%%%%%%%%%%%%%%%

definition --> "(define ", identifier(I),  " ", number(I2), ")", !.

number([H|T]) --> digit(H), number(T).
number([H|T]) --> period(H), (digits(T) ; []).
number([]) --> [].

digits([H|T]) --> digit(H), digits(T).
digits([H]) --> digit(H).
identifier([H|T]) --> alphanum(H), identifier(T).
identifier([H]) --> alphanum(H).


digit(D) --> [D], {code_type(D, digit)}.
alphanum(C) --> [C], { code_type(C, alnum)}.
period(P) --> [P], {char_code(., P)}.


% For tests
accepts(G,S) :- string_codes(S,L), phrase(G, L). 

