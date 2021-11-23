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

Nous allons commencer par tracer les lignes horizontales. Pour encadrer nos six lignes, il faut tracer `6 + 1` lignes horizontales. Nous utilisons une boucle `for` et nous utilisons la valeur d'incrément de la boucle ainsi que la taille des cases pour calculer la hauteur de la ligne à tracer. Pour l'instant, nous allons tracer des lignes du bord gauche de l'écran (`0`), jusqu'au bord droit de l'écran (`width`).

```java
void setup()
{
    size(640, 360);
}

void draw()
{
    // dessine les 7 lignes horizontales
    for (int i = 0; i < 7; i++)
    {
        line(0, i * 20, width, i * 20);
    }
}
```

### Sous Etape 1.2 - Dessiner les lignes verticales

Nous allons commencer par tracer les lignes verticales. Pour encadrer nos 7 colonnes, il faut tracer `7 + 1` lignes verticales. Nous utilisons une boucle `for` et nous utilisons la valeur d'incrément de la boucle ainsi que la taille des cases pour calculer la largeur de la ligne à tracer. Pour l'instant, nous allons tracer des lignes du bord supérieur de l'écran (`0`), jusqu'au bord inférieur de l'écran (`height`).

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
    // dessine les 8 lignes verticales
    for (int i = 0; i < 7 + 1; i++)
    {
        line(i * 20 , 0, i * 20, height);
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
