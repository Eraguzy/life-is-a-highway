all: lifeisahighway clean

main.o: main.c header.h
	gcc main.c -o main.o

lifeisahighway: main.o
	gcc $^ -o lifeisahighway 
# nom de l'exec final : lifeisahighway
# $^ = toutes les dépendances

clean: 
	rm -f *.o
	rm -rf *.dSYM
# nettoyage fichiers objets + dsym qui apparaissent sur vscode