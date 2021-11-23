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

## Etape 2 - Dessiner les jetons vides

Pour dessiner les jetons, nous avons besoin d'une structure de données pour les représenter. Un tableau à deux dimensions est la méthode la plus classique. Nous utilisons à nouveau les constantes de la section précédente pour créer le tableau.

```java
int[][] jetons = new int[NB_LIGNES][NB_COLONNES];
```

Il faut ensuite initialiser chaque élément du tableau. Pour cela, on utilise deux boucles `for` imbriquées (une pour chaque ligne et une pour chaque case d'une ligne). Nous utilisons à nouveau les constantes de la section précédente. L'initialisation s'effectuant une seule fois au début du programme, on place le code dans la fonction `setup`.

On définit les valeurs suivantes :

- `0` : case vide (valeur par défaut).
- `1` : case prise par un jeton du joueur 1 (rouge).
- `2` : case prise par un jeton du joueur 2 (bleu).

```java
void setup()
{
    size(640, 360);
    for (int ligne = 0; ligne < NB_LIGNES; ligne++)
    {
        for (int colonne = 0; colonne < NB_COLONNES; colonne++)
        {
            jetons[ligne][colonne] = 0;
        }
    }
}
```

Une fois notre tableau initialisé, nous pouvons le dessiner. A nouveau nous utilisons deux boucles `for` imbriquées mais cette fois dans la fonction `draw`. On utilise la fonction `circle` pour dessiner un cercle en guise de jeton. Les deux premiers paramètres sont les coordonnées du cercle et le troisième, le diamètre du cercle. Pour commencer, nous allons positionner un cercle blanc en utilisant la taille des cases ainsi que les valeurs des itérateurs de boucles pour trouver leur position.

```java
void draw()
{
    ...
    
    //dessin les jetons
    for (int ligne = 0; ligne < NB_LIGNES; ligne++)
    {
        for (int colonne = 0; colonne < NB_COLONNES; colonne++)
        {
            circle(colonne * TAILLE_CASE, ligne * TAILLE_CASE, TAILLE_CASE);
        }
    }
}
```

Mais si vous exécuter ce code, vous constaterez que les cercles sont dessinés **sur** les croisements des lignes. Il faut prendre en compte qu'on positionne les cercles sur leur centre. Et donc nous devons les positionner **au centre des cases**. Pour cela, à nouveau, on utilise la constante `TAILLE_CASE` mais que nous allons diviser par deux.

```java
void draw()
{
    ...
    
    //dessin les jetons
    for (int ligne = 0; ligne < NB_LIGNES; ligne++)
    {
        for (int colonne = 0; colonne < NB_COLONNES; colonne++)
        {
            circle(colonne * TAILLE_CASE + TAILLE_CASE / 2, ligne * TAILLE_CASE + TAILLE_CASE / 2, TAILLE_CASE);
        }
    }
}
```

**Remarque :** J'ai omis volontairement les parenthèses car la multiplication et la division sont prioritaires sur l'addition et la soustraction.

Nous affichons bien les différents jetons du tableau. Il y a cependant un problème. A aucun moment nous n'utilisons le contenu du tableau. Ainsi tous les jetons sont dessinés en blanc (la couleur par défaut).

Nous pouvons facilement le vérifier en modifiant un élément du tableau à une valeur différente de `0` lors de l'initialisation dans la fonction `setup`.

```java
void setup()
{
    size(640, 360);
    for (int ligne = 0; ligne < NB_LIGNES; ligne++)
    {
        for (int colonne = 0; colonne < NB_COLONNES; colonne++)
        {
            jetons[ligne][colonne] = 0;
        }
    }
    // valeur de test rouge
    jetons[2][2] = 1;
    // valeur de test bleue
    jetons[3][3] = 2;
}
```

Nous allons donc ajouter une gestion d'une condition pour déterminer la couleur à utiliser pour dessiner le jeton actuel. Vous pouvez utiliser une instruction `if else` en cascade mais la meilleure solution est d'utiliser une instruction `switch`. La différence réside dans le fait qu'une condition d'une instruction `if` peut être quelconque alors que dans une instruction `switch` on compare une *expression* à des valeurs précises.

```java
void draw()
{
    ...

    //dessin les jetons
    for (int ligne = 0; ligne < NB_LIGNES; ligne++)
    {
        for (int colonne = 0; colonne < NB_COLONNES; colonne++)
        {
            switch(jetons[ligne][colonne])
            {
                case 0:
                    fill(255);
                    break;
                case 1:
                    fill(255, 0, 0);
                    break;
                case 2:
                    fill(0, 0, 255);
                    break;
            }
            circle(colonne * TAILLE_CASE + TAILLE_CASE / 2, ligne * TAILLE_CASE + TAILLE_CASE / 2, TAILLE_CASE);
        }
    }
}
```

**Remarque :** Notez bien que le dessin du cercle en lui-même est fait en dehors de l'instruction `switch`. Dans cette dernière, on ne modifie que la couleur de remplissage car quelle que soit la couleur, on dessine toujours un cercle.

**Attention !** Les différents cas (`case`) d'une instructions `switch` nécéssitent presque toujours une instruction `break`. Si vous l'oubliez, votre code peut avoir un comportement différent de celui attendu. C'est le piège de l'instruction `switch`. Pour faire simple, une instruction `switch` exécute le code correspondant au cas associé à l'expression à tester et continue à exécuter tous les cas suivants sauf si on place une instruction `break` qui permet de sortir de l'instruction `switch` et de passer au code suivant.

Le code complet de cette étape :

```java
final int TAILLE_CASE = 40;
final int NB_LIGNES = 6;
final int NB_COLONNES = 7;

int[][] jetons = new int[NB_LIGNES][NB_COLONNES];

void setup()
{
    size(640, 360);
    for (int ligne = 0; ligne < NB_LIGNES; ligne++)
    {
        for (int colonne = 0; colonne < NB_COLONNES; colonne++)
        {
            jetons[ligne][colonne] = 0;
        }
    }
    // valeur de test rouge
    jetons[2][2] = 1;
    // valeur de test bleue
    jetons[3][3] = 2;
}

void draw()
{
    //Dessin de la grille
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
    
    //dessin les jetons
    for (int ligne = 0; ligne < NB_LIGNES; ligne++)
    {
        for (int colonne = 0; colonne < NB_COLONNES; colonne++)
        {
            switch(jetons[ligne][colonne])
            {
                case 0:
                    fill(255);
                    break;
                case 1:
                    fill(255, 0, 0);
                    break;
                case 2:
                    fill(0, 0, 255);
                    break;
            }
            circle(colonne * TAILLE_CASE + TAILLE_CASE / 2, ligne * TAILLE_CASE + TAILLE_CASE / 2, TAILLE_CASE);
        }
    }
}
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
