#include "header.h"

int main(int argc, char* argv[]){
    char* option = argv[1]; //mettre en paramètre le traitement travaillé dans le shell (ex: ./lifeisahighway T temp/exemple.csv...)
    switch(option[0]){
        case 'S': //insérer traitement pour s
            traitement_s(argc, argv);
            break;
        case 'T': //pour t
            traitement_t(argc, argv);
            break;
    }
    return 0;
    
}