#!/bin/bash

input_directory="./benchmark"
output_directory="./stat_gen"
valid_options=("O0" "O1" "O2" "O3" "Ofast")
compilers=("gcc" "clang" "icc" "icx")

if [ ! -d "$output_directory" ]; then
  echo "Directory does not exist, creating it..."
  mkdir -p "$output_directory"  # Create the directory and its parent directories if they don't exist
else
  echo "Directory already exists."
fi

grep_stat(){
  grep "$1" "$2" | awk -F';' '{gsub(/\(/, "", $12); print $(NF)}'
}


for sous_repertoire in "$input_directory"/*; do
  # Vérifiez si le chemin est un répertoire
  if [ -d "$sous_repertoire" ]; then
      # Extrait le nom du sous-répertoire
      nom_sous_repertoire=$(basename "$sous_repertoire")
  fi

  mkdir -p "$output_directory/$nom_sous_repertoire"

  for option_name in "${valid_options[@]}"; do

    output_file="$output_directory/$nom_sous_repertoire/$option_name.dat"

    declare -A data

    # Parcourez les fichiers de données
    for compiler in "${compilers[@]}"; do
        file="$input_directory/$nom_sous_repertoire/reduc_${compiler}_${option_name}.dat"
        if [ -f "$file" ]; then
            base=$(grep_stat "BASE" "$file")
            unroll4=$(grep_stat "UNROLL4" "$file")
            unroll8=$(grep_stat "UNROLL8" "$file")
            cblas=$(grep_stat "CBLAS" "$file")

            data["$compiler"]="$base $unroll4 $unroll8 $cblas"
        fi
    done

    printf "%6s %11s %11s %11s %11s\n" "Version" "base" "unroll4" "unroll8" "cblas" > "$output_file"
    for compiler in "${compilers[@]}"; do
        printf "%7s\t${data[$compiler]}\n" "$compiler" >> "$output_file"
    done

    echo "Le fichier $output_file a été créé avec succès."
  done;

done