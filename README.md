# Assembly

## Interpreters
Pas d'interpréteur pour le pseudocode du livre. Alternative ASM:

###[Jasmin](http://wwwi10.lrr.in.tum.de/~jasmin/downloads.html)

Unif de Munich, date de 2006 (?). Installation simple, c'est un .jar. Une zone d'éditeur pour taper son code ASM, une vue de la RAM, une vue des registres.
Une fenêtre de doc bien pratique avec les opérandes etc.
Possibilité d'exécuter le code ligne par ligne voir le résultat de chaque opération.
Jeu d'instruction x86 simplifié 

###[BSim](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-004-computation-structures-spring-2009/tools/)
MIT (open courseware)                                                                                                                                                                                             
Aussi un .jar, un peu plus spartiate. Leur jeu d'instruction, moins complet, plus orienté interaction ASM <-> machine (cours de computation structures).




# Pascal
    
## Interpreters

###[Lazarus](http://www.lazarus-ide.org/)

Lourd (beaucoup de dépendances), complexe, intimidant. Beaucoup de fonctionnalités unutiles, mais un éditeur avec syntax hilighting etc.

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

[Racket](https://racket-lang.org/)


# Prolog

[SWI](http://www.swi-prolog.org/)
