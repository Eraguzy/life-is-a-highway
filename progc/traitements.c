#include "header.h"

void traitement_s(int argc, char* argv[]){
    FILE* fichier1 = fopen(argv[2], "r");
    if (fichier1 == NULL) {
        printf("Erreur lors de l'ouverture du fichier");
        exit(1);
    }

    Arbre* arbre = NULL;

    char line[100];  // Assurez-vous que cette taille est suffisante pour contenir une ligne complète
    float difference;
    int* h = malloc(sizeof(int));

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
        arbre = ajoutabr(arbre, difference, line, h);

    }
#if 0
    while (fscanf(fichier1, "%99[^;];%f;%f;%99[^\n]", trajet, &min_distance, &max_distance, ligne) == 4){
        float difference = max_distance - min_distance;
        arbre = ajoutabr(arbre, difference, ligne, h);
    }
#endif

    fclose(fichier1);
}

void traitement_t(int argc, char* argv[]){

}
