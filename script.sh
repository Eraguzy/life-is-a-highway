#!/bin/bash
#verifie le bon nombre d'arguments
if [ $# -lt 2 ]
then
	echo "Pas le bon nombre d'arguments !"
	exit 1
fi

if [ -e "$1" ]
then
    nom_fichier=$(basename "$1")
    if [ "$nom_fichier" == "data.csv" ]; then
        echo "Le chemin est bon."
    else
        echo "Le chemin existe mais n'est pas le chemin de data.csv."
        exit 2
    fi
else
    echo "Le chemin n'existe pas."
    exit 3
fi

#verifie les arguments 
d1=0
d2=0
t=0
s=0
l=0

for i in `seq 2 $#`
do
	case ${!i} in
		"-d1") d1=1;;
		"-d2") d2=1;;
		"-t") t=1;;
		"-l") l=1;;
		"-s") s=1;;
		"-h") echo "Options qui existent : -d1, -d2, -l, -t, -s"
		exit 4;;
		*) echo " ${!i} existe pas";;
	esac
done

images='images'
progc='progc'
temp='temp'
demo='demo'
data='data'

#verifie si le dossier temp existe, s'il n'existe pas ou si ce n'est pas un fichier, le dossier temp est créé (ça fonctionne)
if [ -e  "$temp" ]
then 
	if [ ! -d "$temp" ]
	then
		mkdir "$temp"
		echo "le dossier "$temp" n'existe pas. Il vient d'être créé."	
	else
		echo "le dossier "$temp" existe et vient d'être vidé"
		find "$temp" -mindepth 1 -delete
	fi
else 
	mkdir "$temp"
	echo "le dossier "$temp" n'existe pas. Il vient d'être créé."	
fi

#verifie si le dossier image existe, sinon on le crée
if [ -e  "$images" ]
then 
	if [ ! -d "$images" ]
	then
		mkdir "$images"
		echo "le dossier "$images" n'existe pas. Il vient d'être créé."	
	else
		echo "le dossier "$images" existe."	
	fi
else 
	mkdir "$images"
	echo "le dossier "$images" n'existe pas. Il vient d'être créé."	
fi

#verifie si l'executable existe, sinon il compile le fichier .c et si il n'y arrive pas il affiche un message d'erreur et quitte le programme
if [ -e "exec" ]
then
        echo "L'executable est présent"
else
        echo "L'executable n'est pas présent"
        gcc -o exec progc/exec.c
        if [ $? -eq 0 ]
        then
        	echo "Compilation réussie."
        else
        	echo "La compilation a échoué."
        	exit 5
        fi
fi

mesurer_temps_execution() {

    # Enregistrez le moment de début
    local start_time=$(date +%s)

    # Appelez la fonction passée en paramètre
    $1

    # Enregistrez le moment de fin
    local end_time=$(date +%s)

    # Calculez la différence entre le moment de fin et le moment de début en secondes
    local elapsed_time=$(echo "$end_time - $start_time" | bc)

    # Affichez la durée d'exécution en secondes avec un détail
    echo "La fonction a pris $elapsed_time secondes pour s'exécuter."
}

ma_fonction_a_mesurer() {
    sleep 2
}

mesurer_temps_execution ma_fonction_a_mesurer
