%%%%%%%%%%%%%%
%% 1. FACTS %%
%%%%%%%%%%%%%%

father(george,maria).
father(george,howard).
father(george,roger).
father(george,laura).
father(albert,tamara).
father(albert,alexandra).
father(albert,jessica).
father(roger,brandon).
father(roger,nadia).
father(bob,frank).
father(bob,anthony).

mother(cecilia,maria).
mother(cecilia,howard).
mother(cecilia,roger).
mother(cecilia,laura).
mother(maria,tamara).
mother(maria,alexandra).
mother(maria,jessica).
mother(sarah,brandon).
mother(sarah,nadia).
mother(laura,frank).
mother(laura,anthony).

male(george).
male(albert).
male(roger).
male(howard).
male(bob).
male(brandon).
male(frank).
male(anthony).

female(cecilia).
female(maria).
female(sarah).
female(laura).
female(tamara).
female(alexandra).
female(jessica).
female(nadia).


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
%% 5. RECUSRIVE RULES %%
%%%%%%%%%%%%%%%%%%%%%%%%


predecessor(X,Z) :- parent(X,Z).
predecessor(X,Z) :- parent(X,Y), predecessor(Y,Z).
