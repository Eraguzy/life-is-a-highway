ARG1 = system("echo $ARG1")
ARG2 = system("echo $ARG2")

set style data histograms
set style histogram clustered
set boxwidth 0.8
set title "Option -t : Nb routes = f(Town)"
set ylabel "NB ROUTES"
set xlabel "TOWN NAMES"
set xtics rotate by -45
set key autotitle columnheader
set term pngcairo size 800,600

plot ARG2 using 2:xticlabels(1) title "Total Trajets", '' using 3 title "Trajets Départ"
