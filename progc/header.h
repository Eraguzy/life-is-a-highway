#ifndef def
    #define def
    #include <stdio.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <string.h>
    #include <time.h>

    typedef struct arbre{
        struct arbre* gauche;
        struct arbre* droite;
        int eq;
        float elmnt;
        int elmnt2;
        char* csv; //contient toutes les autres infos de l'élément (qui ne servent pas au tri)
    }Arbre;

    int min(int a, int b);
    int max(int a, int b);
    Arbre* creerarbre(float x, int y, char* c);
    Arbre* ajoutabr(Arbre* a, float x, int y, char* c, int* h); //tri selon h
    int Comparaison(char* str1, char* str2);
    Arbre* ajoutabrchar(Arbre* a, float x, int y, char* c, int* h); //tri selon c
    Arbre* equilibreravl(Arbre* a);
    void traitement_t(int argc, char* argv[]);
    void traitement_s(int argc, char* argv[]);
    void infixeinversepours(Arbre* arbre, FILE* fgnu, int* count);
    void infixeinversepourt(Arbre* arbre, FILE* fgnu, int* count);
    void infixepourt(Arbre* arbre, FILE* fgnu2, int* count);
    void libererTousMesCopains(Arbre* arbre);
#endif
