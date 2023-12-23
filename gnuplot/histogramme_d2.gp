ARG1 = system("echo $ARG1")
ARG2 = system("echo $ARG2")

set terminal png size 1000,1000
set output ARG1
set datafile separator ";"
set style data histogram
set style fill solid
set boxwidth 0.7
set xlabel "DRIVER NAMES" rotate by 180 offset 0,0.5
set ylabel "Option -d2 : Distance = f(Driver)"
set y2label "Distance (en KM) "
set y2range [0:*]

set xtics rotate by 90
set xtics right
set y2tics rotate by 90 
set y2tics center offset 0,0
set bmargin 13
set tmargin 4

unset ytics
unset yrange

plot ARG2 using 1:xtic(2) with boxes notitle axes x1y2
