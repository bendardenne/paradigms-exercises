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


## Ressources
Très facile de trouver des tutos.
 
 - Exercices avec solution: 
	+ <http://www.asiplease.net/computing/pascal/pascal_programming_exercises.htm>
	+ <https://github.com/Yonaba/pascal-exercises>


# Scheme 
(3 semaines + 1 mission)

[Racket](https://racket-lang.org/)

(Debian) Package "rlwrap" à installer manuellement (du moins pour le prompt CLI)


## Exos

1 Semaine Liste
1 Semaine Lambdas

set-car!/set-cdr!  SICP sec 3.3.1

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

