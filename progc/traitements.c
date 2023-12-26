#include <header.h>

void traitement_s(int argc, char* argv[]){
    FILE* fichier1 = fopen("temp/stemp.csv", "r");
    if (fichier1 == NULL) {
        printf("Erreur lors de l'ouverture du fichier");
        exit(1);
    }

    Arbre* arbre = NULL;
    char ligne[256];

    while (fgets(ligne, sizeof(ligne), fichier1) != NULL) {
        
    }

    fclose(fichier1);
}

void traitement_t(int argc, char* argv[]){

}