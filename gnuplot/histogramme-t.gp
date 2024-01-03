ARG1 = system("echo $ARG1")
ARG2 = system("echo $ARG2")


set terminal png size 1000,1000
set output ARG1
set datafile separator ";"
set style fill solid
set style data histograms
set style histogram clustered
set boxwidth 0.8
set title "Option -t : Nb routes = f(Town)"
set ylabel "NB ROUTES"
set xlabel "TOWN NAMES"
set xtics rotate by -45
set key autotitle columnheader

plot ARG2 using 2:xticlabels(1) title "Total routes", '' using 3 title "First town"
