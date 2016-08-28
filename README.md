# Assembly 
(1 semaine)

## Interpreters
Pas d'interpréteur pour le pseudocode du livre. Alternative ASM:

###[Jasmin](http://wwwi10.lrr.in.tum.de/~jasmin/downloads.html)

Unif de Munich, date de 2006 (?). Installation simple, c'est un .jar. Une zone d'éditeur pour taper son code ASM, une vue de la RAM, une vue des registres.
Une fenêtre de doc bien pratique avec les opérandes etc.
Possibilité d'exécuter le code ligne par ligne pour voir le résultat de chaque opération.
Jeu d'instruction x86 simplifié 

##Exercices:

- Petits exos itératifs -> AbsMean


# Pascal
(2 semaines)
    
## Interpreters

###[Free Pascal Compiler](http://www.freepascal.org/)
Plus léger et plus simple d'utilisation, mais c'est juste le compilateur, pas d'éditeur, ni de GUI. 

Lazarus utilise FPC, donc le résultat compilé sera le même. Ce n'est qu'un choix d'interface et de facilité d'installation/utilisation.

### Note: Error "Can't find unit": vérifier dans fpc.cfg le path des units   
Nécessaire par exemple pour utiliser l'unit "crt" qui permet de gérer clavier et écran. 
Elle ne me parait pas strictement nécessaire, mais au cas où, pour régler le problème :

chez moi: ajout de 

	-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget/*

dans ~/.fpc.cfg


# Scheme 
(3 semaines + 1 mission)

[Racket](https://racket-lang.org/)

(Debian) Package "rlwrap" à installer manuellement (du moins pour le prompt CLI)


## Exos

1 Semaine Liste
1 Semaine Lambdas

set-car!/set-cdr!  SICP sec 3.3.1

Rajouter exo sur if special form et ordre d'évaluation des arguments (écrire un my-if avec cond)
Rajouter accumulate
Parameter lists
	- point et apply (présent dans prolog, équivalent dans ruby, python, scala,..)
	implémenter my-plus
let et let\*: scoping
lexical scoping  

Modifier pour utiliser r5rs


http://www.ee.columbia.edu/~johnny/studies/aop/

## Mission

Interpreteur/compilateur pseudo-code 


# Prolog
(3 semaines + 1 mission)

[SWI](http://www.swi-prolog.org/)

[Exerices](https://sites.google.com/site/prologsite/)

## Exos LPA

Sessions 1 & 2: en un TP (Sauf difference-lists)
Session 3: moins importante, introduire prédicat is
Session 4: cuts, importante
Session 6: eight queens
Session 5: DCG, bonne intro pour la mission

## Mission
Extension DCG
https://www.metalevel.at/lisprolog/lisprolog.pl


# SmallTalk
(2 semaines)

Pharo

