# Projet Puissance 4 en Processing

## Préparatifs

Le projet nécessite l'utilisation de la souris. Pour utiliser les fonctions de gestions d'évènements, nous devons utiliser les fonctions `setup` qui s'exécute une seule fois au lancement du programme et `draw` qui se répète en boucle.

```java
void setup()
{

}

void draw()
{

}
```

Nous allons définir une taille de fenêtre plus grande que celle par défaut (100x100). J'ai choisi la taille 640x360 mais vous pouvez choisir une autre taille. L'important est de choisir une taille suffisante pour voir nos cases de jeu. Nous utilisons la fonction `size` à l'intérieur de la fonction `setup` pour définir la taille de la fenêtre.

**Attention !** La fonction `size` n'accepte pas de variable en paramètres. Il faut utiliser des valeurs *littérales* (codées en dur).

```java
void setup()
{
    size(640, 360);
}

void draw()
{

}
```

## Etape 1 - Dessiner une grille

La méthode la plus simple est de partir du bord supérieur gauche de la fenêtre.

### Sous Etape 1.1 - Dessiner les lignes horizontales

Nous allons tracer les lignes horizontales. Pour encadrer nos six lignes, il faut tracer `6 + 1` lignes horizontales. Nous utilisons une boucle `for` et nous utilisons la valeur d'incrément de la boucle ainsi que la taille des cases pour calculer la hauteur de la ligne à tracer. Pour l'instant, nous allons tracer des lignes du bord gauche de l'écran (`0`), jusqu'au bord droit de l'écran (`width`).

```java
void setup()
{
    size(640, 360);
}

void draw()
{
    // dessine les 7 lignes horizontales
    for (int i = 0; i < 6 + 1; i++)
    {
        line(0, i * 20, width, i * 20);
    }
}
```

### Sous-étape 1.2 - Réduire la taille des lignes

Comme vous pouvez le voir si vous exécutez le code précédent, les lignes horizontales dépassent de la zone d'affichage.

Pour les lignes horizontales, nous devons arrêter le tracé à la limite droite (soit nombre de colonnes x taille de case). On remplace la largeur de l'écran `width` par `7 * 20`.

```java
// dessine les 7 lignes horizontales
for (int i = 0; i < 6 + 1; i++)
{
    line(0, i * 20, 7 * 20, i * 20);
}
```

### Sous Etape 1.3 - Dessiner les lignes verticales

Nous allons tracer les lignes verticales. Pour encadrer nos 7 colonnes, il faut tracer `7 + 1` lignes verticales. Nous utilisons une boucle `for` et nous utilisons la valeur d'incrément de la boucle ainsi que la taille des cases pour calculer la largeur de la ligne à tracer. Pour l'instant, nous allons tracer des lignes du bord supérieur de l'écran (`0`), jusqu'au bord inférieur de l'écran (`height`).

```java
void setup()
{
    size(640, 360);
}

void draw()
{
    // dessine les 7 lignes horizontales
    for (int i = 0; i < 6 + 1; i++)
    {
        line(0, i * 20, 7 * 20, i * 20);
    }
    // dessine les 8 lignes verticales
    for (int i = 0; i < 7 + 1; i++)
    {
        line(i * 20 , 0, i * 20, height);
    }
}
```

### Sous-étape 1.4 - Réduire la taille des lignes verticales

Comme vous pouvez le voir si vous exécutez le code précédent, les lignes verticales dépassent de la zone d'affichage.

Pour les lignes horizontales, nous devons arrêter le tracé à la limite droite (soit nombre de colonnes x taille de case). On remplace la largeur de l'écran `width` par `7 * 20`.

```java
// dessine les 8 lignes verticales
for (int i = 0; i < 7 + 1; i++)
{
    line(i * 20, 0, i * 20, 6 * 20);
}
```

### Sous-étape 1.5 - Créer des constantes réutilisables

Si vous regardez le code actuel, vous pouvez constater que les valeurs `20` sont utilisées à de nombreux endroits. Pour éviter de modifier cette valeur à tous ces endroits, nous allons utiliser une constante globale (qu'on va placer en dehors des fonctions). Une constante est une variable qu'on initialise lors de sa déclaration et qu'on ne peut plus modifier par la suite. Dans Processing, on utilise le mot clé `final` pour définir une constante. Généralement, on écrit une constante en convention `ALL_CAPS` (tout en majuscules séparés par des underscore `_`) et on la place en tête de programme.

**Conseil :** Lorsqu'on remarque qu'on utilise plusieurs fois une valeur littéral (codée en dur), cela indique généralement qu'on doit définir une variable ou une constante pour représenter cette valeur. De cette manière, lorsqu'on souhaite modifier cette valeur, on le fait à un seul endroit de son code.

```java
final int TAILLE_CASE = 20;
```

Nous remplaçons ensuite la valeur `20` par cette constante.

```java
final int TAILLE_CASE = 20;

void setup()
{
    size(640, 360);
}

void draw()
{
    // dessine les 7 lignes horizontales
    for (int i = 0; i < 6 + 1; i++)
    {
        line(0, i * TAILLE_CASE, 7 * TAILLE_CASE, i * TAILLE_CASE);
    }
    // dessine les 8 lignes verticales
    for (int i = 0; i < 7 + 1; i++)
    {
        line(i * TAILLE_CASE, 0, i * TAILLE_CASE, 6 * TAILLE_CASE);
    }
}
```

Désormais, si vous modifiez la constante dans le code, la grille devrait se dessiner relativement à cette nouvelle valeur.

Nous pouvons également définir des constantes pour le nombre de lignes et le nombre de colonnes de la grille.

```java
final int NB_LIGNES = 6;
final int NB_COLONNES = 7;
```

Et remplacer ces valeurs dans le code par la constante.

```java
final int TAILLE_CASE = 40;
final int NB_LIGNES = 6;
final int NB_COLONNES = 7;

void setup()
{
    size(640, 360);
}

void draw()
{
    // dessine les 7 lignes horizontales
    for (int i = 0; i < NB_LIGNES + 1; i++)
    {
        line(0, i * TAILLE_CASE, NB_COLONNES * TAILLE_CASE, i * TAILLE_CASE);
    }
    // dessine les 8 lignes verticales
    for (int i = 0; i < NB_COLONNES + 1; i++)
    {
        line(i * TAILLE_CASE, 0, i * TAILLE_CASE, NB_LIGNES * TAILLE_CASE);
    }
}
```

**Remarque :** Notre grille est dessinée correctement. Nous pourrions toutefois aller plus loin en centrant cette grille dans la fenêtre. Cependant, comme ce tutoriel doit rester accessible, je préfère rester sur la solution actuelle et que l'on se base sur l'origine `(0, 0)` pour positionner nos éléments et trouver à quelle case correspond une position.

```java

```

```java

```

```java

```

```java

```

```java

```

```java

```

```java

```

```java

```

```java

```

```java

```

```java

```

```java

```

```java

```

```java

```

```java

```
