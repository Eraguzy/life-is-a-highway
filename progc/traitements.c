#include "header.h"

void infixepours(Arbre* arbre, FILE* fgnu, int* count){ //parcours inversé infixe
    if(arbre != NULL){
        infixepours(arbre->droite, fgnu, count);
        if (*count < 51){ //de 1 à 51
            fprintf(fgnu, "%s", arbre->csv);
            (*count)++;
        }
        infixepours(arbre->gauche, fgnu, count);
    }
}

void traitement_s(int argc, char* argv[]){
    FILE* fichier1 = fopen(argv[2], "r");
    if (fichier1 == NULL) {
        printf("Erreur lors de l'ouverture du fichier");
        exit(1);
    }

    Arbre* arbre = NULL;

    char line[100]; //taille suffisante
    float difference;
    int* h = malloc(sizeof(int));
    int count = 1;

    while (fgets(line, sizeof(line), fichier1) != NULL) { //remplir avl avec le fichier
        // mettre la ligne dans le noeud
        int id;
        float min, max, moy;

        if (sscanf(line, "%d;%f;%f;%f", &id, &min, &max, &moy) == 4) {
            //différence entre la 3e et la 2e colonne
            difference = max - min;
        } 
        arbre = ajoutabr(arbre, difference, line, h); //remplit avl
    }

    FILE* fgnu = fopen("temp/stemp2.csv", "w"); //fichier de sortie
    if (fgnu == NULL) {
        printf("Erreur lors de l'ouverture du fichier");
        exit(1);
    }
    infixepours(arbre, fgnu, &count); //sert à garder les 50 plus grands noeuds, on les met dans un fichier pour les gnuplotter

    fclose(fichier1);
    fclose(fgnu);
}

void traitement_t(int argc, char* argv[]){

}
