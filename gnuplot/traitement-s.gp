ARG1 = system("echo $ARG1") # recup les arguments créés en shell
ARG2 = system("echo $ARG2")

# Extraction des noms des colonnes pour la légende
col_min = "Min"
col_max = "Max"
col_moy = "Moyenne"

set terminal png size 1600,800
set output ARG1
set datafile separator ";"

# ajustement esthétique
set rmargin 7
set bmargin 8
set style data linespoints
set style fill transparent solid 0.5
set boxwidth 0.7
set title "Trajet - Min, Max, Moy"
set xlabel "ID Trajet" offset 0, -3
set ylabel "Valeur (km)" 
set yrange [0:*]
set xtics rotate by 45 right

# Tracé des courbes avec remplissage entre min et max
plot ARG2 using ($0+1):2:3 with filledcurves fc rgb '#ADD8E6' notitle, \
    ARG2 using ($0+1):2:xtic(1) with lines lt 1 title col_min, \
    ARG2 using ($0+1):3:xtic(1) with lines lt 2 title col_max, \
    ARG2 using ($0+1):4:xtic(1) with lines title col_moy lc rgb 'red'

