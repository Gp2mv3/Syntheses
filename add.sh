#!/bin/bash

#                        _              _
#     ___ ___  _ __  ___| |_ __ _ _ __ | |_ ___
#    / __/ _ \| '_ \/ __| __/ _` | '_ \| __/ _ \
#   | (_| (_) | | | \__ \ || (_| | | | | ||  __/
#    \___\___/|_| |_|___/\__\__,_|_| |_|\__\___|

args=("$@")
nbr_arg=5
section=( "summary" "notes" "exam" "test" "exercises" )
sols="only none both"
exammonths="Janvier Juin Août"
testmonths="Février Mars Avril Mai Septembre Octobre Novembre Décembre"
# On ne peut juste pas avoir de tests pendant les mois d'examen (blocus l'empêche), ni pendant les vacances d'été.
# months="Janvier Mars Juin Août Novembre" # Backward compatibility
minmajs="Mineure Majeure All"
size_titre=20


#     __                  _   _
#    / _|_   _ _ __   ___| |_(_) ___  _ __
#   | |_| | | | '_ \ / __| __| |/ _ \| '_ \
#   |  _| |_| | | | | (__| |_| | (_) | | | |
#   |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|


function subdirectory {
    if [ $1 == exam ] || [ $1 == test ]; then
      makef=Makefileexam
      fullname="$name-$1-$year-$month-$minmaj"
      base=exam
    else
      if [ $1 == exercises ]; then
        makef=Makefileexercises
      else
        makef=Makefile
      fi
      fullname="$name-$1"
      base=tex
    fi

    fulldir="$dir/$1"
    mkdir -p "$fulldir"

    if [ $1 == exam ] || [ $1 == test ]; then
      if ! [ -f "$fulldir/$1.mk" ]; then
        sed "s/name/$name/g; s/type/$1/g" ./templates/exam.mk >> "$fulldir/$1.mk"
      fi

      fulldir="$fulldir/$year"
      mkdir -p "$fulldir"
      if ! [ -f "$fulldir/$year.mk" ]; then
        sed "s/year/$year/g; s/type/$1/g" ./templates/year.mk >> "$fulldir/$year.mk"
      fi

      fulldir="$fulldir/$month"
      mkdir -p "$fulldir"
      if ! [ -f "$fulldir/$month.mk" ]; then
        sed "s/month/$month/g; s/year/$year/g" ./templates/month.mk >> "$fulldir/$month.mk"
      fi

      fulldir="$fulldir/$minmaj"
      mkdir -p "$fulldir"
    fi

    if ! [ -f "$fulldir/Makefile" ]; then
        sed "s/sol/$sol/g; s/section/$1/g; s/name/$name/g; s/minmaj/$minmaj/g; s/month/$month/g" ./templates/$makef >> "$fulldir/Makefile"
    fi

    import="epl$1"

    if ! [ -f "$fulldir/$1/$fullname.tex" ]; then
        sed "s/name/$name/g; s/quadri/$quadri/g; s/sigle/$sigle/g; s/code/$code/g; s/import/$import/g; s/year/$year/g; s/month/$month/g" ./templates/$base.tex > "$fulldir/$fullname.tex"
    fi
}

function mk {
    mk=$dir/$name.mk
    if ! [ -f $mk ]; then
        sed "s/quadri/$quadri/g; s/name/$short/g; s/option/$option/g; s/code/$code/g" ./templates/mk.mk >> $mk
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

contains() {
    [[ $1 =~ $2 ]] && return 0 || return 1
}

#    _          _
#   | |__   ___| |_ __
#   | '_ \ / _ \ | '_ \
#   | | | |  __/ | |_) |
#   |_| |_|\___|_| .__/
#                |_|
# help

if [ $# -lt $nbr_arg ] ||  [ $1 = "--help" ]; then
    echo "
    use: bash add.sh quadri titre sigle code repertory sol year month minmaj
    e.g: bash add.sh 1      math  FSAB  1101 summary
    e.g: bash add.sh 1      math  FSAB  1201 exercises only
    e.g: bash add.sh 1      info  FSAB  1401 exam      both 2015 Juin  All

    where repertory is summary, notes, exam, test, exercises or all
          sol       is only: only contains the solution
                       none: only contains the statement
                       both: contains both"

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
    echo "Quadrimestre must be a integer in range 1..8"
    error=true
fi

if [ ${#args[1]} -gt $size_titre ]; then
    echo "Title size (actually ${args[1]}) must be lower than $size_titre"
    error=true
fi

if valid_section $5 ; then
    echo "Please choose summary, notes, exam, test, exercises or all"
    error=true
fi

if ! contains "${sols}" $6; then
    echo "Please choose sol among \`\`${sols}''. You chose \`\`$6''."
    error=true
fi

if [ $5 = exam ]; then
    if ! contains "${exammonths}" $8; then
        echo "Please choose the month among \`\`${exammonths}''. If you feel one is missing, let us know. You chose \`\`$8''."
        error=true
    fi
fi

if [ $5 = test ]; then
    if ! contains "${testmonths}" $8; then
        echo "Please choose the month among \`\`${testmonths}''. If you feel one is missing, let us know. You chose \`\`$8''."
        error=true
    fi
fi

if ! contains "${minmajs}" $9; then
    echo "Please choose \`\`${minmajs}\'\'. You chose \`\`$9''."
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
sigle=$3
code=$4
dir="src/q$1/$2-$3$4"
quadri=$1
short=$2
option=$3
code=$4
name=$short-$option$code
ext=$5
sol=$6
year=$7
month=$8
minmaj=$9

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
    subdirectory $ext
fi
