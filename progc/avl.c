#include "header.h"

//fonction qui retourne la valeur la plus grande
int max(int a, int b){
    return a>=b ? a:b;
}

//fonction qui retourne la valeur la plus petite
int min(int a, int b){
    return a<=b ? a:b;
}

//fonction qui crée un noeud de l'arbre et l'initialise avec les données des paramètres de la fonction
Arbre* creerarbre(float x, int y, char* c){
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
    new->elmnt2 = y;
    strcpy(new->csv, c); //gestion spéciale pour le char
    new->eq = 0;
    return new;
}

//fonction qui rajoute un noeud dans l'arbre, en respectant le principe des avl
Arbre* ajoutabr(Arbre* a, float x, int y, char* c, int* h){
    if(a == NULL){
        *h = 1;
        return creerarbre(x, y, c);
    }
    if(x > a->elmnt){
        a->droite = ajoutabr(a->droite, x, y, c, h);
    }
    if(x < a->elmnt){
        a->gauche = ajoutabr(a->gauche, x, y, c, h);
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

int Comparaison(char* a, char* b) {

	//On compare les deux chaines pour effectuer un tri lexicographique priorisant les lettres par rapport aux espaces
	while (*a != '\0' && *b != '\0') {
		if (*a == ' ' && *b != ' ') {
			return 1;
		} 
		else if (*a != ' ' && *b == ' ') {
			return -1;
		}
		else if (*a > *b) {
            		return 1;
		} 
		else if (*a < *b) {
			return -1;
		}
		a++;
		b++;
	}

	//Si l'une des deux chaines est vide et qu'elles sont identiques jusqu'au dernier caractère comparé, on place la chaine vide en première
	if (*a == '\0' && *b != '\0') {
		return -1;
	} 
	else if (*a != '\0' && *b == '\0') {
		return 1;
	}

	//Les deux chaines sont strictement identiques
	return 0;
}

//même fonction mais en ajoutant les noeuds en fonction d'une chaine de caractère (pour le tri alphabétique)
Arbre* ajoutabrchar(Arbre* a, float x, int y, char* c, int* h){
	if(a == NULL){
		*h = 1;
		return creerarbre(x, y, c);
	}
	if (Comparaison(c, a->csv) > 0) {
		a->droite = ajoutabrchar(a->droite, x, y, c, h);
	}
	if (Comparaison(c, a->csv) < 0) {
		a->gauche = ajoutabrchar(a->gauche, x, y, c, h);
		*h = -(*h);
	}
	else {
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

//fonction qui permet de faire une rotation à gauche pour le rééquilibrage
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

//fonction qui permet de faire une rotation à droite pour le rééquilibrage
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

//fonction qui fait une double rotation gauche
Arbre* doublegauche(Arbre* a){
    if(a == NULL){
        return NULL;
    }
    a->droite = rotationdroite(a->droite);
    return rotationgauche(a);
}

//fonction qui fait une double rotation droite
Arbre* doubledroite(Arbre* a){
    if(a == NULL){
        return NULL;
    }
    a->gauche = rotationgauche(a->gauche);
    return rotationdroite(a);
}

//fonction qui rééquilibre l'arbre, en fonction du facteur d'équilibre du noeud
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

//fonction qui libère l'arbre c'est à dire tous les noeuds de l'arbre
void libererTousMesCopains(Arbre* a) {
    if (a != NULL) {
        libererTousMesCopains(a->gauche);
        libererTousMesCopains(a->droite);
        free(a->csv);
        free(a);
    }
}
