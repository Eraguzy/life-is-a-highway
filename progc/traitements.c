#include "header.h"

void infixeinversepours(Arbre* arbre, FILE* fgnu, int* count){ //parcours inversé infixe
    if(arbre != NULL){
        infixeinversepours(arbre->droite, fgnu, count);
        if (*count < 51){ //de 1 à 51
            fprintf(fgnu, "%s", arbre->csv);
            (*count)++;
        }
        infixeinversepours(arbre->gauche, fgnu, count);
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
        arbre = ajoutabr(arbre, difference, 0, line, h); //remplit avl
    }

    FILE* fgnu = fopen("temp/stemp2.csv", "w"); //fichier de sortie
    if (fgnu == NULL) {
        printf("Erreur lors de l'ouverture du fichier");
        exit(1);
    }
    infixeinversepours(arbre, fgnu, &count); //sert à garder les 50 plus grands noeuds, on les met dans un fichier pour ensuite générer notre graphique

    fclose(fichier1);
    fclose(fgnu);
}

void infixeinversepourt(Arbre* arbre, FILE* fgnu, int* count){ //parcours inversé infixe
	if(arbre != NULL){
		infixeinversepourt(arbre->droite, fgnu, count);
		if (*count < 11){ //de 1 à 11
			fprintf(fgnu, "%s;%f;%d\n", arbre->csv, arbre->elmnt, arbre->elmnt2);
			(*count)++;
		}
		infixeinversepourt(arbre->gauche, fgnu, count);
	}
}

void infixepourt(Arbre* arbre, FILE* fgnu2, int* count){ //parcours inversé infixe
	if(arbre != NULL){
		infixepourt(arbre->gauche, fgnu2, count);
		int convertion = (int) arbre->elmnt;
		fprintf(fgnu2, "%s;%d;%d\n", arbre->csv, convertion, arbre->elmnt2);
		infixepourt(arbre->droite, fgnu2, count);
	}
}

void traitement_t(int argc, char* argv[]){
	FILE* fichier1 = fopen(argv[2], "r");
	if (fichier1 == NULL) {
		printf("Erreur lors de l'ouverture du fichier");
		exit(1);
	}

	Arbre* arbre = NULL;
	
	char line[100]; //taille suffisante
	int* h = malloc(sizeof(int));
	int count = 1;
	int etape1;
	float traversee;
	char ville[100];
	
	while (fgets(line, sizeof(line), fichier1) != NULL) { //remplir avl avec le fichier
	// mettre la ligne dans le noeud
		sscanf(line, "%99[^;];%f;%d", ville, &traversee, &etape1);
		arbre = ajoutabr(arbre, traversee, etape1, ville, h); //remplit avl
	}

	FILE* fgnu = fopen("temp/tempt2.csv", "w"); //fichier de sortie
	if (fgnu == NULL) {
		printf("Erreur lors de l'ouverture du fichier");
		exit(1);
	}
	infixeinversepourt(arbre, fgnu, &count); //sert à garder les 10 plus grands noeuds
	
	fclose(fgnu);
	
	Arbre* arbre2 = NULL;
	
	fgnu = fopen("temp/tempt2.csv", "r");
	if (fgnu == NULL) {
		printf("Erreur lors de l'ouverture du fichier");
		exit(1);
	}
	
	while (fgets(line, sizeof(line), fgnu) != NULL) { //remplir avl avec le fichier
	// mettre la ligne dans le noeud
		sscanf(line, "%99[^;];%f;%d", ville, &traversee, &etape1);
		arbre2 = ajoutabrchar(arbre2, traversee, etape1, ville, h); //remplit avl
	}
	
	fclose(fgnu);

	FILE* fgnu2 = fopen("temp/tempt3.csv", "w"); //fichier de sortie
	if (fgnu2 == NULL) {
		printf("Erreur lors de l'ouverture du fichier");
		exit(1);
	}
	infixepourt(arbre2, fgnu2, &count); //sert à remettre dans l'ordre alphabétique
    
	fclose(fichier1);
	fclose(fgnu2);
}
