#!/bin/bash

# Update all the pdf (usefull when updating lib.tex)

arr=("elec math meca" "chimie elec math meca philo", "physique math chimie")
for i in ${!arr[*]}; do
	let "q = i + 1"
	cd "q$q"
	for j in ${arr[$i]}; do
		cd $j
		make all
		touch "$j.tex"
		make addpdf
		cd ..
	done
	cd ..
done
