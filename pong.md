# Pong

par *flashjaysan*

## Introduction

Ce document est un tutoriel pour réaliser un clone du jeu Pong avec le langage BlitzMax.

- Dans un premier temps, on réalisera le projet sans aucune organisation.
- Puis on structurera le code dans des fonctions pour le rendre plus modulaire.
- On passera ensuite à une organisation via la programmation orientée objet.
- On terminera par diverses optimisations.

## Choix techniques

- Résolution de 640x360 pixels en 16/9.
- Positionnement inital des éléments sur une grille de 40x40 pixels constituée de 16x9 tuiles.
- L'arrière plan est rempli d'une couleur verte (51, 152, 75).
- Les paddles sont représentés par des rectangles de couleur bleue (0, 152, 220) d'1x3 tuiles.
- La balle est représentée par un rectangle de couleur jaune (255, 200, 37) d'1x1 tuile.
- Le jeu se joue à deux sur un même clavier.
- Il n'y a pas de gestion d'un paddle par l'ordinateur.
- Le joueur de gauche contrôle le paddle avec les touches `Z` (pour monter le paddle) et `S` (pour descendre le paddle).
- Le joueur de droite contrôle le paddle avec les touches `HAUT` (pour monter le paddle) et `BAS` (pour descendre le paddle).
- Pas de son ni de musique. Le projet se voulant indépendant de toute ressource externe.

## Analyse du projet

On constate la nécessité d'utiliser les éléments suivants :

- Paddle gauche : un rectangle de couleur de 1x3 cases.
- Paddle droit : idem.
- Balle : un carré de couleur de 1x1 case.
- Score gauche : un texte.
- Score droite : un texte.

**Remarque :** La position des éléments sera représentée en réalité par le coin supérieur gauche de leur rectangle. Cela sera utile pour placer facilement les éléments sur la grille. En revanche, il faudra être vigilant par rapport au centre et aux bords de ces rectangles.

## Tutoriel

### Version basique

#### Squelette de base

On commence le projet en choisissant le mode `SuperStrict`. Ce mode nous oblige à déclarer toutes les variables avant leur utilisation et à leur attribuer un type explicitement.

```
SuperStrict
```

On crée la fenêtre de jeu.

```
Graphics(640, 360)
```

Pour que le jeu ne se termine pas immédiatement, on crée la boucle de jeu. On utilise une boucle `While` avec une variable booléenne (`Int` dans BlitzMax) initialisée à `vrai`. Cela crée une boucle de jeu infinie tant que la variable est vraie. Si l'utilisateur ferme la fenêtre, la variable prend la valeur `faux` et la boucle de jeu se termine.

```
Local gameloop_running: Int = True

While gameloop_running
	gameloop_running = Not AppTerminate()
Wend
```

On efface la surface d'affichage. Comme on veut la remplir avec notre couleur verte, nous devons définir la couleur de remplissage (lorsqu'on efface la surface) avant la boucle de jeu. On en profite pour échanger les tampons d'affichage arrière et avant.

```
SetClsColor(51, 152, 75)

While gameloop_running
	gameloop_running = Not (AppTerminate() Or KeyDown(KEY_ESCAPE))
	Cls()
	Flip()
Wend
```

#### Paddle gauche

Comme on va placer les divers éléments sur la grille au départ, on définit une variable `tile_size` pour représenter la taille des tuiles.

```
Local tile_size: Int = 40
```

On définit deux variables `left_paddle_x` et `left_paddle_y` qui indiquent la position du paddle gauche. On utilise la taille des tuiles pour déterminer sa position à l'écran.

```
Local left_paddle_x: Float = tile_size
Local left_paddle_y: Float = tile_size * 3
```

**Remarque :** Pourquoi le type `Float` ? Car si on applique un déplacement au paddle et qu'il n'est pas entier, lors de l'affectation à une variable de type entier, il sera converti en entier et la partie décimale sera perdue.

On dessine un rectangle de couleur bleue pour représenter le paddle gauche. Il faut d'abord définir la couleur de dessin puis dessiner le rectangle.

```
SetColor(0, 152, 220)
DrawRect(left_paddle_x, left_paddle_y, tile_size, tile_size * 3)
```

Pour le mouvement, on crée une variable `paddle_speed` pour définir la vitesse des paddles.

```
Local paddle_speed: Float = 5
```

Pour le mouvement du paddle gauche, on lui applique la vitesse, positivement ou négativement, selon la touche appuyée par le joueur.

```
If KeyDown(KEY_Z)
    left_paddle_y :- paddle_speed
End If
If KeyDown(KEY_S)
    left_paddle_y :+ paddle_speed
End If
```

Utiliser deux `if` séparés au lieu d'un `if else if` permet de gérer l'appui sur les deux touches simultanées. Si le joueur appuie sur les deux touches en même temps, le paddle reste immobile.

**Remarque :** Si vous exécutez le jeu, vous constaterez que le paddle peut sortir de la zone visible eu haut et en bas. On doit donc tester sa position dans l'écran et rétablir une position correcte pour forcer le paddle à rester dans la zone visible.

Pour le bord supérieur de l'écran, il suffit de vérifier que la position verticale du paddle est positive ou nulle. Si ce n'est pas le cas, on positionne le paddle au bord de la fenêtre (`0`).

```
If left_paddle_y < 0
    left_paddle_y = 0
EndIf
```

Pour le bord inférieur de l'écran, c'est plus compliqué. La position du paddle est représentée par le coin supérieur gauche du rectangle. Il faut donc vérifier si la position verticale est supérieure à trois case au dessus du bord inférieur de la fenêtre (le paddle faisant trois tuiles de haut) soit six cases du bord supérieur de la fenêtre. Si ce n'est pas le cas, on positionne le paddle au bord de cette case.

```
If left_paddle_y > tile_size * 6
    left_paddle_y = tile_size * 6
EndIf
```

#### Paddle droit

On définit deux variables `right_paddle_x` et `right_paddle_y` qui indiquent la position du paddle droit. A nouveau, on utilise la taille des tuiles pour déterminer sa position à l'écran.

```
Local right_paddle_x: Float = tile_size * 14 
Local right_paddle_y: Float = tile_size * 3
```

On dessine un rectangle de couleur bleue pour représenter le paddle droit. Il faut d'abord définir la couleur de dessin puis dessiner le rectangle.

```
DrawRect(right_paddle_x, right_paddle_y, tile_size, tile_size * 3)
```

**Remarque :** Les deux paddles étant de la même couleur dans ce projet, il est inutile de définir la couleur de dessin pour le paddle droit. Bien entendu, si on venait à changer la couleur de dessin pour dessiner la balle, il faudrait modifier à nouveau cette couleur pour les autres éléments. Ici, on a choisi de dessiner les deux paddles avant de dessiner la balle pour éviter de modifier la couleur deux fois au lieu d'une.

- Changement de couleur pour les paddles.
- Dessin du paddle gauche.
- Dessin du paddle droit.
- Changement de couleur pour la balle.
- Dessin de la balle.

Pour le mouvement du paddle droit, on lui applique la vitesse, positivement ou négativement, selon la touche appuyée par le joueur.

```
If KeyDown(KEY_UP)
    right_paddle_y :- paddle_speed
End If
If KeyDown(KEY_DOWN)
    right_paddle_y :+ paddle_speed
End If
```

**Remarque :** Comme pour le paddle gauche, le paddle droit peut sortir de la zone visible eu haut et en bas. On doit donc tester sa position dans l'écran et rétablir une position correcte pour forcer le paddle à rester dans la zone visible.

Pour le bord supérieur de l'écran, il suffit de vérifier que la position verticale du paddle est positive ou nulle. Si ce n'est pas le cas, on positionne le paddle au bord de la fenêtre (`0`).

```
If right_paddle_y < 0
    right_paddle_y = 0
EndIf
```

Pour le bord inférieur de l'écran, c'est plus compliqué. La position du paddle est représentée par le coin supérieur gauche du rectangle. Il faut donc vérifier si la position verticale est supérieure à trois case au dessus du bord inférieur de la fenêtre (le paddle faisant trois tuiles de haut) soit six cases du bord supérieur de la fenêtre. Si ce n'est pas le cas, on positionne le paddle au bord de cette case.

```
If right_paddle_y > tile_size * 6
    right_paddle_y = tile_size * 6
EndIf
```

#### Scores

Chaque joueur a son propre score. On définit donc deux variables `left_score` et `right_score` qu'on initialise à `0`.

```
Local left_score: Int = 0
Local right_score: Int = 0
```

Pour afficher les score, on définit une position horizontale avec les variables `left_score_x` et `right_score_x` et verticale. La position verticale de ces deux scores étant la même, on définit une seule variable `score_y`.

```
Local left_score_x: Int = 10
Local right_score_x: Int = 620
Local score_y: Int = 10
```

On affiche les scores à l'écran en utilisant les différentes variables et constantes créées.

```
DrawText(String(left_score), left_score_x, score_y)
DrawText(String(right_score), right_score_x, score_y)
```

**Remarque :** Les scores étant des entiers, il faut les convertir en chaînes avec la commande `String`.

#### Balle

On définit deux variables `ball_x` et `ball_y` qui indiquent la position de la balle. A nouveau, on utilise la taille des tuiles pour déterminer sa position à l'écran.

```
Local ball_x: Float = tile_size * 8
Local ball_y: Float = tile_size * 4
```

**Remarque :** Si vous êtes rigoureux, vous avez peut-être remarqué que la balle n'est pas tout à fait au centre de l'écran. Cela est dû au fait que notre résolution est composée d'une grille 16x9. Le nombre de cases horizontale étant pair, on ne peut pas positionner un élément au centre. Pour corriger ce problème, on peut soustraire à la position, la moitié de la taille de la balle (qui rappelons le, est de tile_size). Le problème ne se pose pas verticalement car la grille est constituée d'un nombre impair de cases verticalement.

```
Local ball_x: Int = tile_size * 8 - tile_size / 2
```

On dessine un rectangle de couleur jaune pour représenter la balle. Il faut d'abord définir la couleur de dessin puis dessiner le rectangle.

```
SetColor(255, 200, 37)
DrawRect(ball_x, ball_y, tile_size, tile_size)
```

Pour le mouvement de la balle, on a besoin de deux variables `ball_speed_x` et `ball_speed_y`. En effet, la balle peut se déplacer en diagonale et sa direction peut changer au cours du jeu. Pour augmenter la difficulté, on va choisir une valeur légèrement supérieure à celle des paddles.

```
Local ball_speed_x: Float = paddle_speed * 1.3
Local ball_speed_y: Float = Ppaddle_speed * 1.1
```

On applique le déplacement à la balle.

```
ball_x :+ ball_speed_x
ball_y :+ ball_speed_y
```

On doit maintenant vérifier que la balle ne touche pas les bords de l'écran. Deux cas peuvent se présenter.

- La balle touche le bord supérieur ou inférieur de l'écran : On change le sens du déplacement vertical de la balle. On doit également repositionner la balle dans l'écran pour éviter qu'elle sorte de l'écran.
- La balle touche le bord gauche ou droit de l'écran : La balle est repositionnée au centre de l'écran et on change le sens de son déplacement horizontal. En outre, le joueur opposé au bord de l'écran marque un point.

Pour le bord supérieur de l'écran, il suffit de vérifier que la position verticale de la balle est positive ou nulle. Si ce n'est pas le cas, on positionne la balle au bord de la fenêtre (`0`). On change également le signe de la valeur de déplacement vertical.

```
If ball_y < 0
    ball_y = 0
    ball_speed_y :* -1
EndIf
```

Pour le bord inférieur de l'écran, c'est plus compliqué. La position de la balle est représentée par le coin supérieur gauche du rectangle. Il faut donc vérifier si la position verticale est supérieure à une case au dessus du bord inférieur de la fenêtre (la balle faisant une tuile de haut) soit huit cases du bord supérieur de la fenêtre. Si ce n'est pas le cas, on positionne la balle au bord de cette case. On change également le signe de la valeur de déplacement vertical.

```
If ball_y > tile_size * 8
    ball_y = tile_size * 8
    ball_speed_y :* -1
EndIf
```

Pour le bord gauche de l'écran, il suffit de vérifier que la position horizontale de la balle est positive ou nulle. Si ce n'est pas le cas, on positionne la balle au centre de l'écran. On change le signe de la valeur de déplacement horizontal. Enfin, on augmente le score du joueur droit.

```
If ball_x < 0
    ball_x = tile_size * 8 - tile_size / 2
    ball_y = tile_size * 4
    ball_speed_x :* -1
	right_score :+ 1
EndIf
```

Pour le bord droit de l'écran, c'est plus compliqué. La position de la balle est représentée par le coin supérieur gauche du rectangle. Il faut donc vérifier si la position horizontale est supérieure à une case à gauche du bord droit de la fenêtre (la balle faisant une tuile de large) soit quinze cases du bord gauche de la fenêtre. Si ce n'est pas le cas, on positionne la balle au centre de l'écran. On change le signe de la valeur de déplacement horizontal. Enfin, on augmente le score du joueur gauche.

```
If ball_x > tile_size * 15
    ball_x = tile_size * 8 - tile_size / 2
    ball_y = tile_size * 4
    ball_speed_x :* -1
	left_score :+ 1
EndIf
```

#### Collisions

On a disposé tous les éléments à l'écran et géré leur déplacement et les scores. Mais il nous faut maintenant gérer les collisions de la balle et des paddles. Pour cela, on va utiliser la technique AABB (Axis Aligned Bounding Box) car tous les rectangles sont alignés sur les axes.

Deux rectangles alignés sur les axes entrent en contact lorsque toutes ces conditions sont remplies :

- le côté droit du premier rectangle est à droite du côté gauche du second rectangle.
- le côté gauche du premier rectangle est à gauche du côté droit du second rectangle.
- le côté haut du premier rectangle est au dessus du côté bas du second rectangle.
- le côté bas du premier rectangle est au dessous du côté haut du second rectangle.

Pour le paddle gauche, on veut que la balle soit repositionnée à droite du paddle de manière à stopper la collision. Comme le paddle est positionné verticalement sur la grille, on peut placer la balle sur la colonne suivante dans la grille. On change également le sens de sa direction horizontale.

```
If ball_x + tile_size > left_paddle_x And ball_x < left_paddle_x + tile_size And ball_y + tile_size > left_paddle_y And ball_y < left_paddle_y + tile_size * 3
    ball_x = tile_size * 2
    ball_speed_x :* -1
EndIf
```

Pour le paddle droite, on veut que la balle soit repositionnée à gauche du paddle de manière à stopper la collision. Comme le paddle est positionné verticalement sur la grille, on peut placer la balle sur la colonne précédente dans la grille. On change également le sens de sa direction horizontale.

```
If ball_x + tile_size > right_paddle_x And ball_x < right_paddle_x + tile_size And ball_y + tile_size > right_paddle_y And ball_y < right_paddle_y + tile_size * 3
    ball_x = tile_size * 13
    ball_speed_x :* -1
EndIf
```

#### Fin de partie

Lorsqu'un joueur marque 11 points, la partie est terminée. On doit réinitialiser les scores ainsi que les positions et directions des différents éléments.

```
If left_score >= 11 Or right_score >= 11

EndIf
```

On réinitialise la position du paddle gauche et du paddle droit. Leur position horizontale étant permanente, on ne réinitialise que la position verticale.

```
left_paddle_x = tile_size
right_paddle_x = tile_size * 14
```

On réinitialise la position de la balle ainsi que sa direction.

```
ball_x = tile_size * 8 - tile_size / 2
ball_y = tile_size * 4
ball_speed_x = paddle_speed * 1.3
ball_speed_y = paddle_speed * 1.1
```

On réinitialise les scores.

```
left_score = 0
right_score = 0
```

#### Programme Complet

Voici le programme complet tel que nous l'avons décrit jusqu'ici.

```
SuperStrict

Local tile_size: Int = 40
Local paddle_speed: Float = 5

Local left_paddle_x: Float = tile_size
Local left_paddle_y: Float = tile_size * 3

Local right_paddle_x: Float = tile_size * 14 
Local right_paddle_y: Float = tile_size * 3

Local ball_x: Float = tile_size * 8 - tile_size / 2
Local ball_y: Float = tile_size * 4
Local ball_speed_x: Float = paddle_speed * 1.3
Local ball_speed_y: Float = paddle_speed * 1.1

Local left_score: Int = 0
Local right_score: Int = 0
Local left_score_x: Int = 10
Local right_score_x: Int = 620
Local score_y: Int = 10

Graphics(640, 360)

SetClsColor(51, 152, 75)

Local gameloop_running: Int = True

While gameloop_running
	gameloop_running = Not AppTerminate()
	
	If KeyDown(KEY_Z)
		left_paddle_y :- paddle_speed
	EndIf
	If KeyDown(KEY_S)
		left_paddle_y :+ paddle_speed
	EndIf
	If left_paddle_y < 0
		left_paddle_y = 0
	EndIf
	If left_paddle_y > tile_size * 6
		left_paddle_y = tile_size * 6
	EndIf
	If KeyDown(KEY_UP)
		right_paddle_y :- paddle_speed
	End If
	If KeyDown(KEY_DOWN)
		right_paddle_y :+ paddle_speed
	EndIf
	If right_paddle_y < 0
		right_paddle_y = 0
	EndIf
	If right_paddle_y > tile_size * 6
		right_paddle_y = tile_size * 6
	EndIf
	ball_x :+ ball_speed_x
	ball_y :+ ball_speed_y
	If ball_y < 0
		ball_y = 0
		ball_speed_y :* -1
	EndIf
	If ball_y > tile_size * 8
		ball_y = tile_size * 8
		ball_speed_y :* -1
	EndIf
	If ball_x < 0
		ball_x = tile_size * 8 - tile_size / 2
		ball_y = tile_size * 4
		ball_speed_x :* -1
		right_score :+ 1
	EndIf
	If ball_x > tile_size * 15
		ball_x = tile_size * 8 - tile_size / 2
		ball_y = tile_size * 4
		ball_speed_x :* -1
		left_score :+ 1
	EndIf
	If ball_x + tile_size > left_paddle_x And ball_x < left_paddle_x + tile_size And ball_y + tile_size > left_paddle_y And ball_y < left_paddle_y + tile_size * 3
		ball_x = tile_size * 2
		ball_speed_x :* -1
	EndIf
	If ball_x + tile_size > right_paddle_x And ball_x < right_paddle_x + tile_size And ball_y + tile_size > right_paddle_y And ball_y < right_paddle_y + tile_size * 3
		ball_x = tile_size * 13
		ball_speed_x :* -1
	EndIf
	If left_score >= 11 Or right_score >= 11
		left_paddle_x = tile_size
		right_paddle_x = tile_size * 14 
		ball_x = tile_size * 8 - tile_size / 2
		ball_y = tile_size * 4
		ball_speed_x = paddle_speed * 1.3
		ball_speed_y = paddle_speed * 1.1
		left_score = 0
		right_score = 0
	EndIf
	
	Cls()
	SetColor(0, 152, 220)
	DrawRect(left_paddle_x, left_paddle_y, tile_size, tile_size * 3)
	DrawRect(right_paddle_x, right_paddle_y, tile_size, tile_size * 3)
	SetColor(255, 200, 37)
	DrawRect(ball_x, ball_y, tile_size, tile_size)
	DrawText(String(left_score), left_score_x, score_y)
	DrawText(String(right_score), right_score_x, score_y)
	Flip()
Wend
```

### Programmation procédurale



### Programmation orientée objet



### Optimisation

 ou appuie sur la touche `ECHAP` pour quitter la boucle de jeu.

Utilisation de constantes.

 Pour être bien organisé, nous allons définir deux constantes pour la résolution.

```
Const SCREEN_WIDTH: Int = 640
Const SCREEN_HEIGHT: Int = 360

Graphics(SCREEN_WIDTH, SCREEN_HEIGHT)
```

clamp des paddles
delta_time