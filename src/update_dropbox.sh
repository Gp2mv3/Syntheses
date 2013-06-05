#! /bin/bash

# Dossier parent du dossier Dropbox
home="$HOME"
# Dossier Dropbox
dropbox="${home}/Dropbox"
# Les dossiers dans lesquels copier les synthèses
out_roots=("$dropbox/Synthèses_EPL" "$dropbox/EPL-Backup"
"$dropbox/UCL_EPL_BAC1" "$dropbox/EPL"
"$dropbox/MAP" "$dropbox/INFO")
# Les quadrimestres concernés pour chaque dossier
clients=('1 2 3 4' '1 2 3 4' '1 2' '3 4' '4' '4')
# Si le filtre est vide, toutes les synthèses sont copiées,
# sinon, uniquement les synthèses mentionnées
filters=('' '' '' 'eco sigsys' 'edo opti' 'coo os')
# Official sert à détecter Synthèses_EPL car la dropbox a une structure
# différente des autres:
#   q1/math/Synthèse_q1_math.pdf
# au lieu de
#   Q1/MATH/Synthèse_q1_math.pdf
officials=(true false false false false false)
# Racine d'où on part pour trouver les synthèses à copier
in_root='.'
# Noms utilisés ici
in_names='chimie eco edo elec info math meca methodnum coo opti os philo physique sigsys'
# Noms respectifs utilisés sur dropbox
out_names='CHIMIE ECO EDO PHYSIQUE INFO MATH PHYSIQUE METHODNUM COO OPTIMISATION OS PHILO PHYSIQUE SIGSYS'

# Usage: read_th
# Renvoie le premier élément de l'array donné par stdin
read_th() {
  IFS=' ' read -ra array
  echo "${array[0]}"
}

# Usage: in_dir quadri in_name
# Renvoie le nom du dossier où trouver le pdf compilé
in_dir () {
  echo "$in_root/q$1/$2"
}

# Usage: in_dir quadri in_name
# Renvoie le chemin vers le pdf compilé
input () {
  echo "`in_dir $1 $2 $3`/$2.pdf"
}

# Usage: out_name_at index_of_name
# Renvoie le out_name du cours d'indice index_of_name
out_name_at () {
  local left=$1
  local found=0
  for out_name in $out_names; do
    if [ $left -eq 0 ]; then
      echo $out_name
      local found=1
    fi
    let "left--"
  done
}

# Usage: in_name_at index_of_name
# Renvoie le in_name du cours d'indice index_of_name
in_name_at () {
  local left=$1
  local found=0
  for in_name in $in_names; do
    if [ $left -eq 0 ]; then
      echo $in_name
      local found=1
    fi
    let "left--"
  done
}

# Usage: output quadri name index_of_name
# Renvoie le nom du dossier de l'output
out_dir () {
  local out_name=`out_name_at $3`
  local in_name=`in_name_at $3`
  if [ "x$out_name" != "x" ]; then
    if $official; then
      echo "$out_root/q$1/${in_name}"
    else
      echo "$out_root/Q$1/${out_name}/Synthèses"
    fi
  fi
}

# Usage: output quadri name index_of_name
# Renvoie le nom de l'output
output () {
  local out_d=`out_dir $1 $2 $3`
  if [ "x$out_d" != "x" ]; then
    echo "$out_d/Synthèse_q$1_$2.pdf"
  fi
}

# Usage: same file1 file2
# Vérifie que file1 et file2 sont pareil en vérifiant leur somme md5
same () {
  # Prend uniquement le premier élément de l'output de md5sum
  local sign_1=`md5sum $1 | read_th 1`
  local sign_2=`md5sum $2 | read_th 1`
  echo [ "$sign_1" == "$sign_2" ]
}

# Usage: in_or_empty element array
# Renvoie 1 si l'array est vide ou si element est dans array
in_or_empty() {
  if [ -z "$2" ]; then
    echo 1
    return
  fi
  for i in $2; do
    if [ "x$i" == "x$1" ]; then
      echo 1
      return
    fi
  done
  echo 0
}

show() {
  echo $@
}

#if [ "$#" == "0" ]; then
#if [ "$*" == "" ]; then
  #echo "empty"
#fi

if [ -z $home ]; then
  echo "Please set your HOME environment variable to your home directory."
  exit 1
fi

if [ ! -d $dropbox ]; then
  echo "$dropbox: No such file or directory"
  exit 1
fi

# Boucle sur les destinations (i.e. les dropboxs)
for i in ${!clients[*]}; do
  quadris=${clients[$i]}
  out_root=${out_roots[$i]}
  official=${officials[$i]}
  filter=${filters[$i]}
  # Boucle sur les quadrimetres
  for quadri in $quadris; do
    # Regarde dans les arguments s'il faut faire ce quadri
    # ./update_dropbox.sh q1 # il faut faire q1
    # ./update_dropbox.sh    # il faut faire q1
    # ./update_dropbox.sh q3 # il ne faut pas faire q1
    if [ `in_or_empty "q$quadri" "$*"` == "1" ]; then
      # Indice du cours dans in_names et out_names
      index_of_name=0
      # Boucle sur les cours
      for in_name in $in_names; do
        # Regarde dans les arguments s'il faut faire ce cours
        # ./update_dropbox.sh math # il faut faire math
        # ./update_dropbox.sh      # il faut faire math
        # ./update_dropbox.sh info # il ne faut pas faire math
        # Vérifie la même chose avec le filtre
        if [ `in_or_empty "$in_name" "$*"` == "1" ] &&
          [ `in_or_empty "$in_name" "$filter"` == "1" ]; then
          in=`input $quadri $in_name $index_of_name`
          out=`output $quadri $in_name $index_of_name`
          if [ -z "$out" ]; then
            # On a pas trouvé le nom de l'output
            echo "Missing out_names !"
            exit 1
          fi
          # Si l'input existe
          # Ça permet de trier les cours qui ne sont pas dans ce quadri
          if [ -f "$in" ]; then
            # Fichier de l'output
            out_d=`out_dir $quadri $in_name $index_of_name`
            if [ ! -d "$out_d" ]; then
              # Le fichier de l'output n'existe pas
              echo "Missing directory: $out_d"
              exit 1
            fi
            # Si l'output n'existe pas ou qu'elle est différente
            # que l'input (leur somme md5 est différent)
            if [ ! -f "$out" ] || ! `same $in $out`; then
              echo "cp $in $out"
              cp $in $out
            fi
          fi
        fi
        let "index_of_name++"
      done
    fi
  done
done
