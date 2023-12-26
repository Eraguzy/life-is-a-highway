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
        int elmnt;
        char* csv; //contient toutes les autres infos de l'élément (qui ne servent pas au tri)
    }Arbre;

    int min(int a, int b);
    int max(int a, int b);
    Arbre* creerarbre(int x, char* c);
    Arbre* ajoutabr(Arbre* a, int x, char* c, int* h);
    Arbre* equilibreravl(Arbre* a);
    void traitement_t(int argc, char* argv[]);
    void traitement_s(int argc, char* argv[]);
#endif