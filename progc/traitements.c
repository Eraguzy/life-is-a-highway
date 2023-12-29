#include "header.h"

void infixepours(Arbre* arbre, int* count){
    if(arbre != NULL){
        infixepours(arbre->droite, count);
        if (*count < 50){
            printf("Ligne %d : %s\n", *count, arbre->csv);
            (*count)++;
        }
        infixepours(arbre->gauche, count);
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

    while (fgets(line, sizeof(line), fichier1) != NULL) {
        // mettre la ligne dans le noeud
        printf("Ligne lue : %s", line);

        int id;
        float min, max, moy;

        if (sscanf(line, "%d;%f;%f;%f", &id, &min, &max, &moy) == 4) {
            //différence entre la 3e et la 2e colonne
            difference = max - min;
            
            printf("Différence entre la 3e et la 2e colonne : %.5f\n", difference);
        } 
        arbre = ajoutabr(arbre, difference, line, h); //remplit avl
    }
    infixepours(arbre, &count);
    fclose(fichier1);
}

void traitement_t(int argc, char* argv[]){

}
