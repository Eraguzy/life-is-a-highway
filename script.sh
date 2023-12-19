#!/bin/bash
#verifie le bon nombre d'arguments
if [ $# -lt 2 ]
then
echo "Pas le bon nombre d'arguments !"
exit 1
fi

if [ -e "$1" ]
then
    if [ "$1" == "data/data.csv" ]; then
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

awk -F';' '$2 == 1' data/data.csv > etape1.csv
#grep ";1;" data/data.csv > etape1.csv

#if [ -e "exec" ]
#then
#        echo "L'executable est présent"
#else
#        echo "L'executable n'est pas présent"
#        gcc -o exec progc/exec.c
#        if [ $? -eq 0 ]
#        then
#         echo "Compilation réussie."
#        else
#         echo "La compilation a échoué."
#         exit 5
#        fi
#fi

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

traitement_d1() {
	cut -d';' -f6 etape1.csv > d1temp.csv
	awk '{
		# Compter les occurrences de chaque nom (sixième colonne)
		count[$i]++
	}
	END {
		#Precss
		for (prenom in count) {
			print prenom, ";", count[prenom]
		}
	}' d1temp.csv \
	| sort -k2 -t";" -n -r \
	| head -n 10 > d1temp2.csv
	
	rm d1temp.csv
	
	output_file="histogramme.png"

	gnuplot <<-EOF
	set terminal png size 1000,1000
	set output "$output_file"
	set datafile separator ";"
	set style data histogram
	set style fill solid
	set boxwidth 0.5
	set ylabel "Histogramme des chiffres associés aux prénoms"
	set yrange [0:450]
	
	set xtics rotate by 90 offset 0,-11
	set ytics rotate by 90
	set bmargin 13
	
	plot "d1temp2.csv" using 2:xtic(1) with boxes notitle
	EOF

	convert -rotate 90 $output_file $output_file

	xdg-open "$output_file"
	
}

if [ $d1 -eq 1 ]
then
mesurer_temps_execution traitement_d1
fi
