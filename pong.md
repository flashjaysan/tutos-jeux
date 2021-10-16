# Pong

par *flashjaysan*

## Introduction

Ce document est un tutoriel pour réaliser un clone du jeu Pong avec le langage BlitzMax.

- Dans un premier temps, on réalisera le projet sans aucune organisation.
- Puis on structurera le code dans des fonctions pour le rendre plus modulaire.
- On passera ensuite à une organisation en objets.
- On terminera par diverses optimisations.

## Choix techniques

- Résolution 640x360 pixels en 16/9.
- Positionnement inital des éléments sur une grille de tuiles de 40x40.
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

**Remarque :** La position des éléments sera représentée en réalité par le coin supérieur gauche de leur rectangle. Cela sera utile pour placer facilement les éléments sur la grille. En revanche, il faudra être vigilant par rapport au centre et aux bords des rectangles.

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

Pour que le jeu ne se termine pas immédiatement, on crée la boucle de jeu. On utilise une boucle `While` avec une variable booléenne (`Int` dans BlitzMax) initialisée à `vrai`. Cela crée une boucle de jeu infinie tant que la variable est vraie. Si l'utilisateur ferme la fenêtre ou appuie sur la touche `ECHAP`, la variable prend la valeur `faux` et la boucle de jeu se termine.

```
Local gameloop_running: Int = True

While gameloop_running
	gameloop_running = Not (AppTerminate() Or KeyDown(KEY_ESCAPE))
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

Comme on va placer les divers éléments sur la grille au départ, on définit une constante pour la taille des tuiles.

```
Const TILE_SIZE: Int = 40
```

On définit deux variables qui indiquent la position du paddle gauche. On utilise la taille des tuiles pour déterminer sa position à l'écran.

```
Local left_paddle_x: Float = TILE_SIZE
Local left_paddle_y: Float = TILE_SIZE * 3
```

**Remarque :** Pourquoi le type `Float` ? Car si on applique un déplacement au paddle et qu'il n'est pas entier, lors de l'affectation à une variable de type entier, il sera converti en entier et la partie décimale sera perdue.

On dessine un rectangle de couleur bleue pour représenter le paddle gauche. Il faut d'abord définir la couleur de dessin puis dessiner le rectangle.

```
SetColor(0, 152, 220)
DrawRect(left_paddle_x, left_paddle_y, TILE_SIZE, TILE_SIZE * 3)
```

Pour le mouvement, on crée une constante pour définir la vitesse des paddles.

```
Const PADDLE_SPEED: Float = 5
```

Pour le mouvement du paddle gauche, on lui applique la vitesse, positivement ou négativement, selon la touche appuyée par le joueur.

```
If KeyDown(KEY_Z)
    left_paddle_y :- PADDLE_SPEED
End If
If KeyDown(KEY_S)
    left_paddle_y :+ PADDLE_SPEED
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
If left_paddle_y > TILE_SIZE * 6
    left_paddle_y = TILE_SIZE * 6
EndIf
```

#### Paddle droit

On définit deux variables qui indiquent la position du paddle droit. A nouveau, on utilise la taille des tuiles pour déterminer sa position à l'écran.

```
Local right_paddle_x: Float = TILE_SIZE * 14 
Local right_paddle_y: Float = TILE_SIZE * 3
```

On dessine un rectangle de couleur bleue pour représenter le paddle droit. Il faut d'abord définir la couleur de dessin puis dessiner le rectangle.

```
DrawRect(right_paddle_x, right_paddle_y, TILE_SIZE, TILE_SIZE * 3)
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
    right_paddle_y :- PADDLE_SPEED
End If
If KeyDown(KEY_DOWN)
    right_paddle_y :+ PADDLE_SPEED
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
If right_paddle_y > TILE_SIZE * 6
    right_paddle_y = TILE_SIZE * 6
EndIf
```

#### Scores

Chaque joueur a son propre score. On définit donc une variable pour chacun d'eux.

```
Local left_score: Int = 0
Local right_score: Int = 0
```

Pour afficher les score, on définit une position horizontale et verticale. La position verticale de ces deux scores étant la même, on définit une constante plutôt qu'une variable.

```
Const SCORE_Y: Int = 10

Local left_score_x: Int = 10
Local right_score_x: Int = 620
```

On affiche les scores à l'écran en utilisant les différentes variables et constantes créées.

```
DrawText(String(left_score), left_score_x, SCORE_Y)
DrawText(String(right_score), right_score_x, SCORE_Y)
```

#### Balle

On définit deux variables qui indiquent la position de la balle. A nouveau, on utilise la taille des tuiles pour déterminer sa position à l'écran.

```
Local ball_x: Float = TILE_SIZE * 8
Local ball_y: Float = TILE_SIZE * 4
```

**Remarque :** Si vous êtes rigoureux, vous avez peut-être remarqué que la balle n'est pas tout à fait au centre de l'écran. Cela est dû au fait que notre résolution est composée d'une grille 16x9. Le nombre de cases horizontale étant pair, on ne peut pas positionner un élément au centre. Pour corriger ce problème, on peut soustraire à la position, la moitié de la taille de la balle (qui rappelons le, est de TILE_SIZE). Le problème ne se pose pas verticalement car la grille est constituée d'un nombre impair de cases verticalement.

```
Local ball_x: Int = TILE_SIZE * 8 - TILE_SIZE / 2
```

On dessine un rectangle de couleur jaune pour représenter la balle. Il faut d'abord définir la couleur de dessin puis dessiner le rectangle.

```
SetColor(255, 200, 37)
DrawRect(ball_x, ball_y, TILE_SIZE, TILE_SIZE)
```

Pour le mouvement de la balle, on a besoin de deux variables. En effet, la balle peut se déplacer en diagonale et sa direction peut changer au cours du jeu. Pour augmenter la difficulté, on va choisir une valeur légèrement supérieure à celle des paddles.

```
Local ball_speed_x: Float = PADDLE_SPEED * 1.3
Local ball_speed_y: Float = PADDLE_SPEED * 1.1
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
If ball_y > TILE_SIZE * 8
    ball_y = TILE_SIZE * 8
    ball_speed_y :* -1
EndIf
```

Pour le bord gauche de l'écran, il suffit de vérifier que la position horizontale de la balle est positive ou nulle. Si ce n'est pas le cas, on positionne la balle au centre de l'écran. On change le signe de la valeur de déplacement horizontal. Enfin, on augmente le score du joueur droit.

```
If ball_x < 0
    ball_x = TILE_SIZE * 8 - TILE_SIZE / 2
    ball_y = TILE_SIZE * 4
    ball_speed_x :* -1
	right_score :+ 1
EndIf
```

Pour le bord droit de l'écran, c'est plus compliqué. La position de la balle est représentée par le coin supérieur gauche du rectangle. Il faut donc vérifier si la position horizontale est supérieure à une case à gauche du bord droit de la fenêtre (la balle faisant une tuile de large) soit quinze cases du bord gauche de la fenêtre. Si ce n'est pas le cas, on positionne la balle au centre de l'écran. On change le signe de la valeur de déplacement horizontal. Enfin, on augmente le score du joueur gauche.

```
If ball_x > TILE_SIZE * 15
    ball_x = TILE_SIZE * 8 - TILE_SIZE / 2
    ball_y = TILE_SIZE * 4
    ball_speed_x :* -1
	left_score :+ 1
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
left_paddle_x = TILE_SIZE
right_paddle_x = TILE_SIZE * 14
```

On réinitialise la position de la balle ainsi que sa direction.

```
ball_x = TILE_SIZE * 8 - TILE_SIZE / 2
ball_y = TILE_SIZE * 4
ball_speed_x = PADDLE_SPEED * 1.3
ball_speed_y = PADDLE_SPEED * 1.1
```

On réinitialise les scores.

```
left_score = 0
right_score = 0
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
If ball_x + TILE_SIZE > left_paddle_x And ball_x < left_paddle_x + TILE_SIZE And ball_y + TILE_SIZE > left_paddle_y And ball_y < left_paddle_y + TILE_SIZE * 3
    ball_x = TILE_SIZE * 2
    ball_speed_x :* -1
EndIf
```

Pour le paddle droite, on veut que la balle soit repositionnée à gauche du paddle de manière à stopper la collision. Comme le paddle est positionné verticalement sur la grille, on peut placer la balle sur la colonne précédente dans la grille. On change également le sens de sa direction horizontale.

```
If ball_x + TILE_SIZE > right_paddle_x And ball_x < right_paddle_x + TILE_SIZE And ball_y + TILE_SIZE > right_paddle_y And ball_y < right_paddle_y + TILE_SIZE * 3
    ball_x = TILE_SIZE * 13
    ball_speed_x :* -1
EndIf
```

### Programmation procédurale



### Programmation orientée objet



### Optimisation

Utilisation de constantes.

 Pour être bien organisé, nous allons définir deux constantes pour la résolution.

```
Const SCREEN_WIDTH: Int = 640
Const SCREEN_HEIGHT: Int = 360

Graphics(SCREEN_WIDTH, SCREEN_HEIGHT)
```

clamp des paddles
delta_time