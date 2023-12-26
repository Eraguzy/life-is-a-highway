#include <header.h>

Arbre* creerarbre(int x){
    Arbre* new = malloc(sizeof(Arbre));
    if (new == NULL){
        printf("erreur malloc\n");
        exit 1;
    }

    new->droite == NULL;
    new->gauche == NULL;
    new->elmnt = x;
}

Arbre* ajoutabr(Arbre* a, int x){
    if(a == NULL){
        return creerarbre(x);
    }
    if(x > a->elmnt){
        a->droite = ajoutabr(a->droite, x);
    }
    if(x < a->elmnt){
        a->gauche = ajoutabr(a->gauche, x);
    }
    return a;
}