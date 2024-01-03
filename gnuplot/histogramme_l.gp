ARG1 = system("echo $ARG1")
ARG2 = system("echo $ARG2")

set terminal png size 1000,1000
set output ARG1
set datafile separator ";"
set style data histogram
set style fill solid
set boxwidth 0.7
set title "Option -l : Distance = f(Route)"
set xlabel "ROUTE ID"
set ylabel "DISTANCE (Km)"
set yrange [0:*]

plot ARG2 using 2:xtic(1) with boxes notitle

