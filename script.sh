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
        echo "Le chemin "$1" est bon."
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
	case ${!i} in # activation des args si demandé
		"-d1") d1=1;;
		"-d2") d2=1;;
		"-t") t=1;;
		"-l") l=1;;
		"-s") s=1;;
		"-h")
		echo " "
		echo "Options disponibles :"
		echo "-d1 : Affiche les conducteurs avec le plus de trajets"
		echo "-d2 : Affiche les conducteurs avec la plus grande distance parcourue"
		echo "-t : Affiche les villes les plus traversées"
		echo "-l : Affiche les trajets les plus longs"
		echo "-s : Affiche des statistiques sur les étapes des trajets"
		echo "-h : Affiche cette aide"
		echo " "
		echo "Exemple d'utilisation une fois dans le bon répertoire : bash script.sh data/data.csv -d1 -d2"
		echo "Plus de détails : https://github.com/Eraguzy/life-is-a-highway#life-is-a-highway-"
		exit 4;; # quitte si y'a -h
		*) echo " ${!i} n'existe pas";;
	esac
done

echo "                      _____________________________________________________"
echo "                      |                                                     |"
echo "             _______  |                                                     |"
echo "            / _____ | |  	 CY TRUCKS PAR LUCAS, ELIAS ET LOUEVA 	    |"
echo "           / /(__) || |                                                     |"
echo "  ________/ / |OO| || |                                                     |"
echo " |         |-------|| |                                                     |"
echo " (|         |     -.|||_______________________                              |"
echo " |  ____   \       ||_________||____________  |             ____      ____  |"
echo "/| / __ \   |______||     / __ \   / __ \   | |            / __ \    / __ \ |\\"
echo "\|| /  \ |_______________| /  \ |_| /  \ |__| |___________| /  \ |__| /  \|_|/"
echo "   | () |                 | () |   | () |                  | () |    | () |"
echo "    \__/                   \__/     \__/                    \__/      \__/"

images='images'
progc='progc'
temp='temp'


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
if [ -e "progc/lifeisahighway" ]
then
	echo " "
    echo "L'executable est présent."
else
	echo " "
    echo "L'executable n'est pas présent. Compilation en cours..."
	make -C progc -f makefile
    if [ $? -eq 0 ] # recup la valeur de retour de make
    then
    	echo "Compilation réussie."
    else
    	echo "La compilation a échoué."
    	exit 5
    fi
fi

echo " "
echo "traitement en cours..." #juste esthétique :)
echo " "

mesurer_temps_execution() {
    local start_time=$(date +%s) # temps de depart
    $1 # Appelez la fonction passée en paramètre
    local end_time=$(date +%s) # temps de fin
    local elapsed_time=$(echo "$end_time - $start_time" | bc) #diff entre fin et debut (bc car shell ne prend pas en compte les float de base)
    echo "La fonction a pris $elapsed_time secondes pour s'exécuter."
}

traitement_d1() {
	awk -F';' '$2 == 1' data/data.csv > temp/etape1.csv #recupère toutes les lignes contenant l'etape 1
	#grep ";1;" data/data.csv > etape1.csv
	
	cut -d';' -f6 temp/etape1.csv > temp/d1temp.csv 
	awk '{
		# Compter les occurrences de chaque nom (sixième colonne)
		count[$i]++
	}
	END {
		#mettre les resultats dans un fichier temporaire
		for (prenom in count) {
			print prenom, ";", count[prenom]
		}
	}' temp/d1temp.csv \
	| sort -k2 -t";" -n -r \
	| head -n 10 > temp/d1temp2.csv #tri décr. par nombre occurences et on récupère les 10 premieres lignes
	
	rm temp/d1temp.csv

	export ARG1="$(pwd)/images/histogramme_d1.png" #exportation pour gnuplot
	export ARG2="$(pwd)/temp/d1temp2.csv"

	gnuplot gnuplot/histogramme_d1.gp #generer histogramme
	
	convert -rotate 90 images/histogramme_d1.png images/histogramme_d1.png

	xdg-open "images/histogramme_d1.png"
	
}

if [ "$d1" -eq 1 ] # option activée = calcul du temps d'exécution + exécution du traitement demandé (pareil pour tous les autres traitements)
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
	}' temp/cut.csv |  sort -t";" -k2 -n -r | head -n10  | sort -t";" -k1 -n  > temp/ltemp.csv #garde les 10 premiers par somme de distance, garde les 10 premiers et trie par id trajet
	
	export ARG1="$(pwd)/images/histogramme_l.png" #export données vers gnuplot
	export ARG2="$(pwd)/temp/ltemp.csv"

	gnuplot gnuplot/histogramme_l.gp #crée le graphique
	
	xdg-open "images/histogramme_l.png" #ouverture de l'image
}

if [ "$l" -eq 1 ]
then
	mesurer_temps_execution traitement_l
fi

traitement_d2() {
    cut -d";" -f5,6 data/data.csv > temp/cut.csv # garde les noms et les conducteurs
    LC_NUMERIC="C" awk -F";" '{ # calcule les sommes des etapes
        distance[$2] += $1
    }
    END {
        for (cond in distance)
             print distance[cond] ";" cond;
    }' temp/cut.csv | sort -t";" -k1 -n -r | head -n10 > temp/d2temp.csv #garde les 10 distances les + longues

    export ARG1="$(pwd)/images/histogramme_d2.png" #export pour gnuplot
    export ARG2="$(pwd)/temp/d2temp.csv"

    gnuplot gnuplot/histogramme_d2.gp #créer histogramme
    
    convert -rotate 90 images/histogramme_d2.png images/histogramme_d2.png #rotation de l'image

    xdg-open "images/histogramme_d2.png" #ouverture de l'image
}

if [ "$d2" -eq 1 ]
then
    mesurer_temps_execution traitement_d2
fi

traitement_s() {
	#awk pour récupérer les min max et moy de chaque trajet
	#lcnumeric = force le awk à prendre le point en norme au lieu de la virgule
	#NR > 1 =  compte pas la ligne 1
	LC_NUMERIC=C awk -F ';' '{
		if (NR > 1) {
			trajet = $1
			distance = $5
			conducteur = $6

			# etape la plus courte (stocke dans un tableau)
			# si la case est vide (""), alors on entre dans la condition; sinon, on garde la valeur si elle est + petite
			if (min_distance[trajet] == "" || distance < min_distance[trajet]) {
				min_distance[trajet] = distance
			}

			# etape la plus longue 
			if (max_distance[trajet] == "" || distance > max_distance[trajet]) {
				max_distance[trajet] = distance
			}

			# addition dans un tableau de la distance totale + compte des etapes par trajet
			total_distance[trajet] += distance
			count[trajet]++
		}
	}
	END {
		for (trajet in min_distance) {
			# moyenne pour chaque itération, reformatte la moyenne pour devenir un chiffre à virgule
			moyenne_distance = total_distance[trajet] / count[trajet]
			formatmoyenne = sprintf("%.5f", moyenne_distance)
			# résultats dans un csv temp 
			printf "%s;%s;%s;%s\n", trajet, min_distance[trajet], max_distance[trajet], formatmoyenne
		}
	}' data/data.csv > temp/stemp.csv # part de data.csv et redirige en sortie vers un fichier temporaire

	./progc/lifeisahighway S "$(readlink -f temp/stemp.csv)"

	export ARG1="images/traitement-s.png" # variables d'env pour gnuplot (fichier de sortie et fichier à traiter)
	export ARG2="temp/stemp2.csv"
 	#creation du graphique et ouverture de l'image 
	gnuplot gnuplot/traitement-s.gp
 	xdg-open "images/traitement-s.png"
}


if [ "$s" -eq 1 ]
then
    mesurer_temps_execution traitement_s
fi

#TRAITEMENT T (pour l'instant pas vrm les memes valeurs que le prof mais l'ordre est bon)
traitement_t() {
	#on compte le nombre de trajets différents par ville, et le nombre de fois ou une ville a été l'étape 1 d'un trajet
	awk -F';' '{
		if (!villes_deja_comptees[$1, $3]) {
			villes_par_trajet[$3]++;
			villes_deja_comptees[$1, $3] = 1;
		}

		if (!villes_deja_comptees[$1, $4]) {
			villes_par_trajet[$4]++;
			villes_deja_comptees[$1, $4] = 1;
		}
		if($2 == 1){
			etape_1[$3]++;
		}
	}
	END {
		for (ville in villes_par_trajet) {
			print ville ";" villes_par_trajet[ville] ";" etape_1[ville]
		}
	}' data/data.csv > temp/tempt.csv
 
	#utilisation d'un programme c afin de trier le fichier tempt.csv
	./progc/lifeisahighway T "$(readlink -f temp/tempt.csv)"
 	export ARG1="$(pwd)/images/histogramme_t.png" #export données vers gnuplot
	export ARG2="$(pwd)/temp/tempt3.csv"

	gnuplot gnuplot/histogramme_t.gp #crée le graphique
	
	xdg-open "images/histogramme_t.png" #ouverture de l'image

}

if [ "$t" -eq 1 ]
then
    mesurer_temps_execution traitement_t
fi
