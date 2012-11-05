#! /bin/bash

clients=('1 2 3' '1 2 3' '1' '3')
officials=(true false false false)
in_root='.'
in_names='chimie elec info math meca philo physique methodnum'
home='/home/blegat'
dropbox="${home}/Dropbox"
out_roots=("$dropbox/Synthèses_EPL" "$dropbox/EPL-Backup"
"$dropbox/UCL_EPL_BAC1" "$dropbox/EPL")
out_names='CHIMIE PHYSIQUE INFO MATH PHYSIQUE PHILO PHYSIQUE METHODNUM'

read_th() {
  IFS=' ' read -ra array
  echo "${array[0]}"
}

in_dir () {
  echo "$in_root/q$1/$2"
}

input () {
  echo "`in_dir $1 $2 $3`/$2.pdf"
}


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

output () {
  local out_d=`out_dir $1 $2 $3`
  if [ "x$out_d" != "x" ]; then
    echo "$out_d/Synthèse_q$1_$2.pdf"
  fi
}

same () {
  local sign_1=`md5sum $1 | read_th 1`
  local sign_2=`md5sum $2 | read_th 1`
  echo [ "$sign_1" == "$sign_2" ]
}

is_in() {
  if [ "x$2" == "x" ]; then
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

for i in ${!clients[*]}; do
  quadris=${clients[$i]}
  out_root=${out_roots[$i]}
  official=${officials[$i]}
  for quadri in $quadris; do
    if [ `is_in $quadri` == "1" ]; then
      i=0
      for in_name in $in_names; do
        if [ `is_in $in_name "$*"` == "1" ]; then
          in=`input $quadri $in_name $i`
          out=`output $quadri $in_name $i`
          if [ "x$out" == "x" ]; then
            echo "Missing out_names !"
            exit 1
          fi
          if [ -f "$in" ]; then
            out_d=`out_dir $quadri $in_name $i`
            if [ ! -d "$out_d" ]; then
              echo "Missing directory: $out_d"
              exit 1
            fi
            if [ ! -f "$out" ] || ! `same $in $out`; then
              echo "cp $in $out"
              cp $in $out
            fi
          fi
        fi
        let "i++"
      done
    fi
  done
done
