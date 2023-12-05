#!/bin/bash

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
		"-h") echo "Options qui existent : -d1, -d2, -l, -t, -s";;
		*) echo " ${!i} existe pas";;
	esac
done

