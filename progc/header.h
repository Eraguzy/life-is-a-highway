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
        char* elmnt;
    }Arbre;

    Arbre* creerarbre(int x);
    Arbre* ajoutabr(Arbre* a, int x);
#endif