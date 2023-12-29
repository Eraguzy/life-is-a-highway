# Définition des données à utiliser
data_file = ARG2
set output ARG1

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5   # Min
set style line 2 lc rgb '#dd181f' lt 1 lw 2 pt 7 ps 1.5   # Max
set style line 3 lc rgb '#00a643' lt 1 lw 2 pt 7 ps 1.5   # Moyenne

set title "Trajet - Min, Max, Moy"
set xlabel "Étape"
set ylabel "Valeur"
set key top left
set grid

# Tracé des courbes
plot data_file using 1:2 with linespoints ls 1 title "Min", \
     data_file using 1:3 with linespoints ls 2 title "Max", \
     data_file using 1:4 with linespoints ls 3 title "Moyenne"