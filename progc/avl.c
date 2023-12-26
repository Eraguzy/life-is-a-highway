#include <header.h>

int max(int a, int b){
    return a>=b ? a:b;
}

int min(int a, int b){
    return a<=b ? a:b;
}

Arbre* creerarbre(int x, char* c){
    Arbre* new = malloc(sizeof(Arbre));
    if (new == NULL){
        printf("erreur malloc\n");
        exit(1);
    }
    new->csv = malloc(strlen(c) + 1); //allocation pour la partie char du noeud
    if (new->csv == NULL){
        printf("erreur malloc\n");
        exit(1);
    }

    new->droite = NULL;
    new->gauche = NULL;
    new->elmnt = x;
    strcpy(new->csv, c); //gestion spéciale pour le char
    new->eq = 0;
    return new;
}

Arbre* ajoutabr(Arbre* a, int x, char* c, int* h){
    if(a == NULL){
        *h = 1;
        return creerarbre(x, c);
    }
    if(x > a->elmnt){
        a->droite = ajoutabr(a->droite, x, c, h);
    }
    if(x < a->elmnt){
        a->gauche = ajoutabr(a->gauche, x, c, h);
        *h = -(*h);
    }
    else{
        *h = 0;
        return a;
    }

    if(*h != 0){
        a->eq = a->eq + *h;
        a = equilibreravl(a);
        if(a->eq == 0){
            *h = 0;
        }
        else {
            *h = 1;
        }
    }
    return a;
}

Arbre* rotationgauche(Arbre* a){ 
    if(a == NULL){
        return a;
    }
    Arbre* pivot = a->droite;

    a->droite = pivot->gauche;
    pivot->gauche = a;
    int eqa = a->eq;
    int eqp = pivot->eq;

    a->eq = eqa - max(eqp, 0) - 1;
    pivot->eq = min(min(eqa-2, eqa + eqp-2), min( eqa + eqp-2, eqp-1));
    a = pivot;
    return a;
}

Arbre* rotationdroite(Arbre* a){ 
    if(a == NULL){
        return a;
    }
    Arbre* pivot = a->gauche;

    a->gauche = pivot->droite;
    pivot->droite = a;
    int eqa = a->eq;
    int eqp = pivot->eq;

    a->eq = eqa - min(eqp, 0) + 1;
    pivot->eq = max(max(eqa+2, eqa + eqp+2), max( eqa + eqp+2, eqp+1));
    a = pivot;
    return a;
}

Arbre* doublegauche(Arbre* a){
    if(a == NULL){
        return NULL;
    }
    a->droite = rotationdroite(a->droite);
    return rotationgauche(a);
}

Arbre* doubledroite(Arbre* a){
    if(a == NULL){
        return NULL;
    }
    a->gauche = rotationgauche(a->gauche);
    return rotationdroite(a);
}

Arbre* equilibreravl(Arbre* a){
    if(a == NULL){
        return NULL;
    }
    if(a->eq >= 2){
        if(a->droite->eq <= 0){
            a = doublegauche(a);
        }
        else{
            a = rotationgauche(a);
        }
    }
    else if(a->eq <= -2){
        if(a->gauche->eq >= 0){
            a = doubledroite(a);
        }
        else{
            a = rotationdroite(a);
        }
    }
    return a;   
}