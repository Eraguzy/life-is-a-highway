all: lifeisahighway clean

main.o: main.c header.h
	gcc -c main.c -o main.o

avl.o: avl.c header.h
	gcc -c avl.c -o avl.o

traitements.o: traitements.c header.h
	gcc -c traitements.c -o traitements.o

lifeisahighway: main.o avl.o traitements.o
	gcc $^ -o lifeisahighway 
# nom de l'exec final : lifeisahighway
# $^ = toutes les dépendances

clean: 
	rm -f *.o
	rm -rf *.dSYM
# nettoyage fichiers objets + dsym qui apparaissent sur vscode