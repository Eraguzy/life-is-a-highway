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
    }Arbre;

    int min(int a, int b);
    int max(int a, int b);
    Arbre* creerarbre(int x);
    Arbre* ajoutabr(Arbre* a, int x, int* h);
    Arbre* equilibreravl(Arbre* a);
#endif