#!/bin/bash
#verifie le bon nombre d'arguments

if [ $# -lt 2 ]
then
	echo "Pas le bon nombre d'arguments !"
	exit 1
fi

if [ -e "$1" ] # verifie que le chemin est bon et que le fichier étudié porte le bon nom
then
    if [ "$1" == "data/data.csv" ]
    then
        echo "Le chemin est bon."
    else
        echo "Le chemin existe mais n'est pas le chemin de data.csv."
        exit 2
    fi
else
    echo "Le chemin n'existe pas."
    exit 3
fi

#verifie les arguments : reste à 0 si l'option n'est pas activée
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
		exit 4;; # quitte si y'a -h
		*) echo " ${!i} existe pas";;
	esac
done

images='images'
progc='progc'
temp='temp'

echo "                      _____________________________________________________"
echo "                      |                                                     |"
echo "             _______  |                                                     |"
echo "            / _____ | |  	 CY TRUCKS PAR LUCAS, ELIAS ET LOUEVA       |"
echo "           / /(__) || |                                                     |"
echo "  ________/ / |OO| || |                                                     |"
echo " |         |-------|| |                                                     |"
echo " (|         |     -.|||_______________________                              |"
echo " |  ____   \       ||_________||____________  |             ____      ____  |"
echo "/| / __ \   |______||     / __ \   / __ \   | |            / __ \    / __ \ |\\"
echo "\|| /  \ |_______________| /  \ |_| /  \ |__| |___________| /  \ |__| /  \|_|/"
echo "   | () |                 | () |   | () |                  | () |    | () |"
echo "    \__/                   \__/     \__/                    \__/      \__/"

#verifie si le dossier temp existe, s'il n'existe pas ou si ce n'est pas un fichier, le dossier temp est créé
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
#if [ -e "progc/exec" ]
#then
#        echo "L'executable est présent."
#else
#        echo "L'executable n'est pas présent."
#        gcc -o exec progc/exec.c
#        if [ $? -eq 0 ] # recup la valeur de retour de gcc
#        then
#        	echo "Compilation réussie."
#        else
#        	echo "La compilation a échoué."
#        	exit 5
#        fi
#fi

if [ ! -e "gnuplot" ]
then
	echo "Il manque le fichier gnuplot."
	exit 5
fi

mesurer_temps_execution() {
    local start_time=$(date +%s) # temps de depart
    $1 # Appelez la fonction passée en paramètre
    local end_time=$(date +%s) # temps de fin
    local elapsed_time=$(echo "$end_time - $start_time" | bc) #diff entre fin et debut (bc car shell ne prend pas en compte les float de base)
    echo "La fonction a pris $elapsed_time secondes pour s'exécuter."
}

traitement_d1() {
	awk -F';' '$2 == 1' data/data.csv > temp/etape1.csv
	#grep ";1;" data/data.csv > etape1.csv
	
	cut -d';' -f6 temp/etape1.csv > temp/d1temp.csv
	awk '{
		# Compter les occurrences de chaque nom (sixième colonne)
		count[$i]++
	}
	END {
		#Precss
		for (prenom in count) {
			print prenom, ";", count[prenom]
		}
	}' temp/d1temp.csv \
	| sort -k2 -t";" -n -r \
	| head -n 10 > temp/d1temp2.csv
	
	rm temp/d1temp.csv

	export ARG1="$(pwd)/images/histogramme_d1.png"
	export ARG2="$(pwd)/temp/d1temp2.csv"

	gnuplot gnuplot/histogramme_horizontal.gp
	
	convert -rotate 90 images/histogramme_d1.png images/histogramme_d1.png

	xdg-open "images/histogramme_d1.png"
	
}

if [ "$d1" -eq 1 ]
then
	mesurer_temps_execution traitement_d1
fi

#TRAITEMENT L 
traitement_l() {
        # Utiliser awk pour calculer la somme des distances par trajet
        cut -d";" -f1,5 data/data.csv >temp/cut.csv
	LC_NUMERIC="C" awk -F";" '{
            distance[$1] +=$2
	}
        END {
            for (trajet in distance) {
            	printf trajet ";" distance[trajet] "\n"
            }      
	}' temp/cut.csv |  sort -t";" -k2 -n -r | head -n10  | sort -t";" -k1 -n  > temp/ltemp.csv
	
	export ARG1="$(pwd)/images/histogramme_l.png"
	export ARG2="$(pwd)/temp/ltemp.csv"

	gnuplot gnuplot/histogramme_vertical.gp
	
	xdg-open "images/histogramme_l.png"
}

if [ "$l" -eq 1 ]
then
	mesurer_temps_execution traitement_l
fi

traitement_d2() {
    cut -d";" -f5,6 data/data.csv > temp/cut.csv
    LC_NUMERIC="C" awk -F";" '{
        distance[$2] += $1
    }
    END {
        for (cond in distance)
             print distance[cond] ";" cond;
    }' temp/cut.csv | sort -t";" -k1 -n -r | head -n10 > temp/ltemp.csv
    export ARG1="$(pwd)/images/histogramme_d2.png"
    export ARG2="$(pwd)/temp/ltemp.csv"

    gnuplot plot_histogram.gp
    
    convert -rotate 90 images/histogramme_d2.png images/histogramme_d2.png

    open "images/histogramme_d2.png"
}
if [ "$d2" -eq 1 ]
then
    mesurer_temps_execution traitement_d2
fi

