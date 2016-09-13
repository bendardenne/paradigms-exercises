%% Mini SQL interpreter.
% Currently handles:
%	- CREATE TABLE
%	- INSERT INTO
%
% Data types are not handled.
% Strings must be given directly: 
%	[...]  VALUES (these, are, strings)
% 
% Examples: 
%	sql("CREATE TABLE foo (bar, baz)").
%	sql("INSERT INTO foo VALUES (444,Hello)").

sql(S) :- accepts(expression(E), S), eval(E).
accepts(G,S) :- string_codes(S,L), phrase(G, L). 


%%% PARSING

expression(exp(Op)) --> create(Op).
expression(exp(Op)) --> insert(Op).

%% CREATE TABLE
create(create(id(Table), Cols)) --> "CREATE TABLE", ws, id(Word), ws,
	"(", columns(Cols), ")", {atom_codes(Table, Word)}.

columns(columns([V|Vs])) --> ws, column(V), ws, 
	(",", columns(columns(Vs)) ; [], {Vs = []}).

column(Col) --> id(Word), {atom_codes(Col, Word)}.


%% INSERT INTO
insert(insert(id(Table), Values)) --> "INSERT INTO", ws, id(Word), 
	ws, "VALUES", ws , "(", values(Values), ")", {atom_codes(Table, Word)}.

% At least one value, possibly followed by others
values(values([V|Vs])) --> ws, value(V), ws, 
	(",", values(values(Vs)) ; [], {Vs = []}).
%	{atom_codes(V, Word)}.

% FIXME Needs to be improved  (don't interpret numbers as strings, ...)
value(Number) --> number(Input), {number_codes(Number, Input)}.
value(String) --> alphanums(Input), {string_codes(String, Input)}. 



%% Utilities
id(Word) --> alphanums(Word).

number([D]) --> digit(D).
number([D|Number]) --> digit(D), number(Number).
number([Sep|Number]) --> period(Sep), (digits(Number) ; [], {Number = []}).

digits([D|Number]) --> digit(D), digits(Number).
digits([D]) --> digit(D).
alphanums([H|T]) --> alphanum(H), alphanums(T).
alphanums([H]) --> alphanum(H).

alphanum(C) --> [C], {code_type(C, alnum)}.
digit(D) --> [D], {code_type(D, digit)}.
period(P) --> [P], {char_code(., P)}.

% 0 or more whitespace
ws --> [W], {code_type(W, space)}, ws.
ws -->  []. 




%%% INTERPRETING

eval(exp(Op)) :- eval(Op).


%% CREATE TABLE
% exists predicate used to check existence of the table   
%	(other idea:  would be nice if we could declare an "empty" predicate    
%		mytable/arity   
%	which is always false until we INSERT something, but I haven't found a way)
eval(create(id(Table), columns(Cols))) :- 
	length(Cols, Arity), assert(exists(Table, Arity, Cols)) .


%% INSERT INTO

% Make a list  [Table | Values]  and use  =.. to transform it into 
% Table(Values)      e.g.    mytable(1,2,3,4) 
% Use assert to "commit" the "row" to the "database", i.e.    mytable(1,2,3,4) :- true.
eval(insert(id(Table), values(Values))) :- 
	length(Values, Arity), exists(Table, Arity,_), !,
	F =.. [Table | Values], assert(F).
