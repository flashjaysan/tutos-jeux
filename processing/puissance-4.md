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

## Etape 3 - Découper le programme

Le programme commence à devenir de plus en plus gros. Pour mieux le cerner, nous allons créer des fonctions et nous allons déplacer des morceaux de code dans ces fonctions et à la place d'origine, appeler la fonction associée.

Dans la fonction `setup`, nous n'allons garder que l'appel à la fonction `size` qui n'est pas vraiment liée à l'initialisation du jeu en lui-même mais plutôt à un réglage graphique général. Pour le reste, nous allons créer une fonction `initialiser` et placer le code à l'intérieur.

```java
void initialiser()
{
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

**Attention !** Quand on déplace du code dans une fonction, il faut penser à appeler cette fonction là où le code se trouvait avant !

```java
void setup()
{
    size(640, 360);
    initialiser();
}
```

Pour la fonction `draw`, nous avons deux parties. La première partie dessine la grille et la seconde dessine les jetons. Nous allons créer une fonction pour chacune de ces parties.

Créez la fonction `dessinerGrille` et placez le code associé à l'intérieur.

```java
void dessinerGrille()
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
}
```

A nouveau, n'oubliez pas d'appeler cette fonction là où se trouvait le code d'origine.

```java
void draw()
{
    dessinerGrille();
    
    ...
}
```

Créez la fonction `dessinerJetons` et placez le code associé à l'intérieur.

```java
void dessinerJetons()
{
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

A nouveau, n'oubliez pas d'appeler cette fonction là où se trouvait le code d'origine.

```java
void draw()
{
    dessinerGrille();
    dessinerJetons();
}
```

## Etape 4 - Modifier l'état d'un jeton avec la souris

Jusque là, nous avons converti notre structure de donnée en dessin en passant des coordonnées dans le tableau à des coordonnées à l'écran. Nous allons maintenant effectuer une conversion inverse à ce que nous avons fait précédemment. En effet, nous devons convertir les coordonnées où le joueur clique à l'écran en coordonnées dans le tableau en mémoire. Pour cela, il suffit de diviser les coordonnées d'écran par la taille des cases.

**Remarque :** Les coordonnées de la souris `mouseX` et `mouseY` et la taille des cases `TAILLE_CASE` étant toutes des valeurs de type `int`, une division donnera un résultat entier (la partie décimale sera tronquée). C'est exactement le résultat désiré pour obtenir des coordonnées dans notre tableau. Notez toutefois que pour d'autres situations impliquant des valeurs à virgule (`float`), vous devrez peut-être convertir le résultat de la division en entier.

### Etape 4.1 - Conversion des coordonnées du clic en coordonnées dans le tableau

Pour gérer le clic de souris, nous utilisons la fonction `mousePressed`.

```java
void mousePressed()
{
    int colonneCliquee = mouseX / TAILLE_CASE;
    int ligneCliquee = mouseY / TAILLE_CASE;
}
```

### Etape 4.2 - Vérification que le clic est bien dans le tableau

Avant d'accéder au tableau pour modifier sa valeur, nous devons nous assurer que le clic a bien été effectué dans le tableau.

```java
void mousePressed()
{
    int colonneCliquee = mouseX / TAILLE_CASE;
    int ligneCliquee = mouseY / TAILLE_CASE;
    // vérifier qu'on a bien cliqué dans le tableau
    if (colonneCliquee < NB_COLONNES && ligneCliquee < NB_LIGNES)
    {
        
    }
}
```

### Etape 4.3 - Modification du jeton correspondant au clic

Si le clic est bien dans le tableau, on modifie la valeur du jeton correspondant.

```java
void mousePressed()
{
    int colonneCliquee = mouseX / TAILLE_CASE;
    int ligneCliquee = mouseY / TAILLE_CASE;
    // vérifier qu'on a bien cliqué dans le tableau
    if (colonneCliquee < NB_COLONNES && ligneCliquee < NB_LIGNES)
    {
        jetons[ligneCliquee][colonneCliquee] = 1;
    }
}
```

Pour l'instant, chaque clic passe le jeton associé à la valeur `1` ce qui dessine le jeton à l'écran en rouge. Nous voulons que chaque clic passe du joueur 1 au joueur 2 et inversement. Comme nous avons seulement deux joueurs, nous pouvons utiliser une variable de type `boolean` pouvant valoir soit `true` (vrai) soit `false` (faux). Définissons une variable `joueur1` en tête du programme.

```java
boolean joueur1;
```

**Remarque :** Nous n'initialisons pas cette variable lors de sa définition car nous allons l'initialiser dans la fonction `initialiser` sachant que cette variable fait partie de l'état du jeu à initialiser.

Initialisez cette variable à `true` dans la fonction `initialiser` pour indiquer que le joueur 1 commence toujours à jouer le premier.

```java
void initialiser()
{
    for (int ligne = 0; ligne < NB_LIGNES; ligne++)
    {
        for (int colonne = 0; colonne < NB_COLONNES; colonne++)
        {
            jetons[ligne][colonne] = 0;
        }
    }
    joueur1 = true;
}
```

**Remarque :** Si ce n'est pas encore fait, profitez en pour supprimer les lignes suivantes dans la fonction `initialiser`.

```java
// valeur de test rouge
jetons[2][2] = 1;
// valeur de test bleue
jetons[3][3] = 2;
```

Dans la fonction `mousePressed`, vérifiez la valeur de cette variable pour déterminer si on doit donner la valeur `1` au jeton (pour le joueur 1) ou la valeur `2` (pour le joueur 2).

```java
void mousePressed()
{
    int colonneCliquee = mouseX / TAILLE_CASE;
    int ligneCliquee = mouseY / TAILLE_CASE;
    // vérifier qu'on a bien cliqué dans le tableau
    if (colonneCliquee < NB_COLONNES && ligneCliquee < NB_LIGNES)
    {
        if (joueur1)
        {
            jetons[ligneCliquee][colonneCliquee] = 1;
        }
        else
        {
            jetons[ligneCliquee][colonneCliquee] = 2;
        }
    }
}
```

**Remarque :** La variable `joueur1` étant de type `boolean`, nous pouvons tester directement sa valeur sans comparer à une valeur particulière. Utiliser `variableBooleenne` comme condition est équivalent à utiliser `variableBooleenne == true`. Utiliser `!variableBooleenne` comme condition est équivalent à utiliser `variableBooleenne == false` ou `variableBooleenne != true`.

**Attention !** Le code actuel teste la valeur de la variable `joueur1` mais ne la modifie jamais. On ne passe donc jamais au joueur 2. Inversez la valeur contenue dans cette variable à chaque modification.

```java
void mousePressed()
{
    int colonneCliquee = mouseX / TAILLE_CASE;
    int ligneCliquee = mouseY / TAILLE_CASE;
    // vérifier qu'on a bien cliqué dans le tableau
    if (colonneCliquee < NB_COLONNES && ligneCliquee < NB_LIGNES)
    {
        if (joueur1)
        {
            jetons[ligneCliquee][colonneCliquee] = 1;
        }
        else
        {
            jetons[ligneCliquee][colonneCliquee] = 2;
        }
        joueur1 = !joueur1;
    }
}
```

**Remarque :** L'instruction `joueur1 = !joueur1` inverse la valeur. L'opérateur logique de négation `!` change la valeur booléenne sur la valeur opposée. Cela revient à écrire :

```java
if (joueur1)
{
    joueur1 = false;
}
else
{
    joueur1 = true;
}
```

Désormais, à chaque clic valide, on change de joueur ce qui a pour effet de dessiner le jeton associé avec la couleur associée au joueur.

Cependant, si on clique plusieurs fois sur la même case, le jeton change d'état à chaque fois. Nous devons vérifier que l'état du jeton cliqué est à `0` pour pouvoir le modifier.

Ajoutez dans la condition qui vérifie si le clic est dans le tableau une nouvelle condition qui vérifie que la case à modifier est à `0`.

```java
void mousePressed()
{
    int colonneCliquee = mouseX / TAILLE_CASE;
    int ligneCliquee = mouseY / TAILLE_CASE;
    // vérifier qu'on a bien cliqué dans le tableau
    if (colonneCliquee < NB_COLONNES && ligneCliquee < NB_LIGNES && jetons[ligneCliquee][colonneCliquee] == 0)
    {
        if (joueur1)
        {
            jetons[ligneCliquee][colonneCliquee] = 1;
        }
        else
        {
            jetons[ligneCliquee][colonneCliquee] = 2;
        }
        joueur1 = !joueur1;
    }
}
```

**Attention !** Il est très important de tester si le clic est dans le tableau **avant** de tester si la case cliquée est à `0`. En effet, si le clic n'est pas dans le tableau, vérifier si la case cliquée (qui n'existe pas) est à `0` provoquera une erreur. Dans Processing (mais aussi dans de nombreux autres langages), l'opérateur logique ET `&&` interrompt le test si la condition à gauche de cet opérateur est fausse. Si c'est le cas, la condition à droite n'est pas testée ce qui a pour effet ici d'empêcher l'erreur de se produire.

Le code complet jusque là :

```java
final int TAILLE_CASE = 40;
final int NB_LIGNES = 6;
final int NB_COLONNES = 7;

int[][] jetons = new int[NB_LIGNES][NB_COLONNES];
boolean joueur1;

void setup()
{
    size(640, 360);
    initialiser();
}

void initialiser()
{
    for (int ligne = 0; ligne < NB_LIGNES; ligne++)
    {
        for (int colonne = 0; colonne < NB_COLONNES; colonne++)
        {
            jetons[ligne][colonne] = 0;
        }
    }
    joueur1 = true;
}

void draw()
{
    dessinerGrille();
    dessinerJetons();
}

void dessinerGrille()
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
}

void dessinerJetons()
{
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

void mousePressed()
{
    int colonneCliquee = mouseX / TAILLE_CASE;
    int ligneCliquee = mouseY / TAILLE_CASE;
    // vérifier qu'on a bien cliqué dans le tableau
    if (colonneCliquee < NB_COLONNES && ligneCliquee < NB_LIGNES && jetons[ligneCliquee][colonneCliquee] == 0)
    {
        if (joueur1)
        {
            jetons[ligneCliquee][colonneCliquee] = 1;
        }
        else
        {
            jetons[ligneCliquee][colonneCliquee] = 2;
        }
        joueur1 = !joueur1;
    }
}

```
