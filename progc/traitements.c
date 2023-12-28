#include "header.h"

void traitement_s(int argc, char* argv[]){
    FILE* fichier1 = fopen(argv[2], "r");
    if (fichier1 == NULL) {
        printf("Erreur lors de l'ouverture du fichier");
        exit(1);
    }

    Arbre* arbre = NULL;
    float min_distance, max_distance;
    char ligne[100];
    char trajet[100]; // Assure-toi que la taille est suffisante
    int* h;

    fscanf(fichier1, "%99[^;];%f;%f;%99[^\n]", trajet, &min_distance, &max_distance, ligne);
    float difference = max_distance - min_distance;
    arbre = ajoutabr(arbre, difference, ligne, h);
    printf("%f\n", arbre->elmnt);
    printf("%s\n", arbre->csv);

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