#!/bin/bash

directory="stat_gen"

valid_options=("o1" "o2" "o3" "ofast")
option_name=""

# Vérifier si un argument a été fourni
if [ $# -eq 0 ]; then
  echo "Veuillez fournir un argument valide parmi les options suivantes: ${valid_options[@]}"
  exit 1
fi

# Vérifier si l'argument est une option valide
for valid_option in "${valid_options[@]}"; do
  if [ "$1" == "$valid_option" ]; then
    option_name="$1"
    break
  fi
done

# Si option_name est vide, l'argument n'est pas valide
if [ -z "$option_name" ]; then
  echo "L'argument n'est pas valide. Veuillez utiliser l'une des options suivantes: ${valid_options[@]}"
  exit 1
fi

# Afficher le nom attribué à l'option
echo "L'argument est : $option_name"


# Créez le fichier de sortie
output_file="$directory/$option_name.dat"

# Définissez les versions de compilateur à utiliser
compilers=("gcc" "clang" "icc" "icx")

# Créez un tableau associatif pour stocker les données
declare -A data


if [ ! -d "$directory" ]; then
  echo "Directory does not exist, creating it..."
  mkdir -p "$directory"  # Create the directory and its parent directories if they don't exist
else
  echo "Directory already exists."
fi

# Parcourez les fichiers de données
for compiler in "${compilers[@]}"; do
    file="benchmark/dgemm_${compiler}_$option_name.dat"
    if [ -f "$file" ]; then
        ijk=$(grep "IJK" $file | awk -F';' '{gsub(/\(/, "", $12); print $(NF-1)}')
        ikj=$(grep "IKJ" $file | awk -F';' '{gsub(/\(/, "", $12); print $(NF-1)}')

        iex=$(grep "IEX" $file | awk -F';' '{gsub(/\(/, "", $12); print $(NF-1)}')
        unroll4=$(grep "UNROLL4" $file | awk -F';' '{gsub(/\(/, "", $12); print $(NF-1)}')

        unroll8=$(grep "UNROLL8" $file | awk -F';' '{gsub(/\(/, "", $12); print $(NF-1)}')
        cblas=$(grep "CBLAS" $file | awk -F';' '{gsub(/\(/, "", $12); print $(NF-1)}')

        data["$compiler"]="$ijk $ikj $iex $unroll4 $unroll8 $cblas"
    fi
done


printf "%6s      %6s      %6s      %6s      %7s     %7s     %6s\n" "Version" "ijk" "ikj" "iex" "unroll4" "unroll8" "cblas" > "$output_file"
for compiler in "${compilers[@]}"; do
    printf "%7s\t${data[$compiler]}\n" "$compiler" >> "$output_file"
done

echo "Le fichier $output_file a été créé avec succès."
