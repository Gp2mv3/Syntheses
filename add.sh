#!/bin/bash

#                        _              _       
#     ___ ___  _ __  ___| |_ __ _ _ __ | |_ ___ 
#    / __/ _ \| '_ \/ __| __/ _` | '_ \| __/ _ \
#   | (_| (_) | | | \__ \ || (_| | | | | ||  __/
#    \___\___/|_| |_|___/\__\__,_|_| |_|\__\___|
                                            
args=("$@")
nbr_arg=4
section=( "summary" "notes" "exam" "exercises" )
size_titre=10


#     __                  _   _             
#    / _|_   _ _ __   ___| |_(_) ___  _ __  
#   | |_| | | | '_ \ / __| __| |/ _ \| '_ \ 
#   |  _| |_| | | | | (__| |_| | (_) | | | |
#   |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|
                                        

function subdirectory {
mkdir -p "$dir/$1"

if ! [ -f $dir/$1"/Makefile" ]; then
    sed "s/section/$1/g; s/name/$name/g" ./templates/Makefile >> $dir/$1"/Makefile"
fi

sigle=3
code=4
import="epl$1"

if ! [ -f $dir/$1"/$name-$1.tex" ]; then
    sed "s/name/$name/g; s/quadri/$quadri/g; s/sigle/$sigle/g; s/code/$code/g; s/import/$import/g" ./templates/tex.tex > $dir/$1"/$name-$1.tex"
fi
}

function mk {
mk=$dir/$name.mk
if ! [ -f $mk ]; then
    sed "s/quadri/$quadri/g; s/name/$name/g" ./templates/mk.mk >> $mk
fi
}

function append {
for line in ${@:2}; do
    echo $line
done

}

#TODO nettoyage
function valid_section {
if [ $1 = "all" ]; then
    return 1
fi

for i in ${section[@]} ; do
    if [ $i = $1 ]; then 
        return 1
    fi
done
return 0 
}



#    _          _       
#   | |__   ___| |_ __  
#   | '_ \ / _ \ | '_ \ 
#   | | | |  __/ | |_) |
#   |_| |_|\___|_| .__/ 
#                |_|    
# help

if [ $# != $nbr_arg ] ||  [ $1 = "--help" ]; then
    echo "
    use: bash add.sh quadri titre code repertory 

    where repertory is summary, notes, exam, exercises or all"

    exit
fi


#     ___ _ __ _ __ ___  _ __ 
#    / _ \ '__| '__/ _ \| '__|
#   |  __/ |  | | | (_) | |   
#    \___|_|  |_|  \___/|_|   
# errors, argument
error=false

re='^[1-8]+$'
if ! [[ $1 =~ $re ]] ||  [ $1 -lt 1 ] || [ $1 -gt 8 ]; then
    echo "Quadrimestre must be a integer in range 1..7"
    error=true
fi

if [ ${#args[1]} -gt $size_titre ]; then
    echo "Title size (actually ${args[1]}) must be lower than $size_titre"
    error=true
fi

if valid_section $4 ; then
    echo "Please choice summary, notes, exam, exercises or all"
    error=true
fi

if [ $error = true ]; then
    exit
fi


                                   
#    _ __  _ __ ___   ___ ___  ___ ___ 
#   | '_ \| '__/ _ \ / __/ _ \/ __/ __|
#   | |_) | | | (_) | (_|  __/\__ \__ \
#   | .__/|_|  \___/ \___\___||___/___/
#   |_|                                
dir="src/q$1/$2-$3"
quadri=$1
name=$2-$3
ext=$4


echo Starting:
echo Create directory...

mkdir -p $dir
mk

echo Create subdirectory...
if [ $ext = "all" ] 
then
    for s in "${section[@]}" ; do
        subdirectory $s 
    done
else
    subdirectory $4 
fi
