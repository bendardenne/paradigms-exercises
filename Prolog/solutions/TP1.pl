%%%%%%%%%%%%%%%%
%% 2. QUERIES %%
%%%%%%%%%%%%%%%%

%	Is George the father of Tamara?
%   father(george,tamara).

%   Anita mother of Brandon?
%   mother(sarah,brandon).

%   Children of Maria?
%   mother(maria,Child).

%   Sons of Roger?
%   father(roger,Son),male(Son).

%	Check that Maria and Albert only have children together:

%   findall(Childmaria,mother(maria,Childmaria),Childrenofmaria), 
%   findall(Childalbert,father(albert,Childalbert),Childrenofalbert),
%   Childrenofmaria=Childrenofalbert.


%	Check that fathers are male and mothers are female.:
%   findall(F,father(F,C),Fathers),
%   findall(Fm,(father(Fm,C),male(Fm)),Fathersmale),
%   Fathers=Fathersmale,
%   findall(M,mother(M,C),Mothers),
%   findall(Mf,(mother(Mf,C),female(Mf)),Mothersfemale),
%   Mothers=Mothersfemale.


%%%%%%%%%%%%%%
%% 3. RULES %%
%%%%%%%%%%%%%%

parent(Parent,Child) :- father(Parent,Child).
parent(Parent,Child) :- mother(Parent,Child).

% Or:
% parent(Parent,Child) :-
%       father(Parent,Child);
%       mother(Parent,Child).

son(Son,Parent) :- parent(Parent,Son), male(Son).

daughter(Daughter,Parent) :- parent(Parent,Daughter), female(Daughter).

grandfather(Grandfather,Grandchild) :- 
     father(Grandfather,Parent),
     parent(Parent,Grandchild).

grandparent(Grandparent,Grandchild) :-
	parent(Grandparent,Parent),
	parent(Parent,Grandchild).
 
brother(Brother,Sibling) :-	
     male(Brother), father(Father,Brother),
     father(Father,Sibling), mother(Mother,Brother),
     mother(Mother,Sibling), not(Brother=Sibling).
 
sibling(Sibling1,Sibling2) :-
     father(Father,Sibling1), father(Father,Sibling2),
     mother(Mother,Sibling1), mother(Mother,Sibling2),
     not(Sibling1=Sibling2).

havechildrentogether(Person1,Person2) :-
     father(Person1,Child), mother(Person2,Child).
havechildrentogether(Person1,Person2) :-
     mother(Person1,Child), father(Person2,Child).

uncle(Uncle,Person) :- brother(Uncle,Parent), parent(Parent,Person).


%%%%%%%%%%%%%%%%%%%
%% 4. UNDERSCORE %%
%%%%%%%%%%%%%%%%%%%

%	Query to tell whether Laura has one child
% parent(laura,_).

human(_).  %%  or  human(X).

isparent(Person) :- parent(Person,_).


%%%%%%%%%%%%%%%%%%%%%%%%
%% 5. RECURSIVE RULES %%
%%%%%%%%%%%%%%%%%%%%%%%%


ancestor(X,Z) :- parent(X,Z).
ancestor(X,Z) :- parent(X,Y), ancestor(Y,Z).
