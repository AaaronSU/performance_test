mkdir -p img

input_directory="./stat_gen"
output_directory="./img"

for sous_repertoire in "$input_directory"/*; do
  # Vérifiez si le chemin est un répertoire
  if [ -d "$sous_repertoire" ]; then
      # Extrait le nom du sous-répertoire
      nom_sous_repertoire=$(basename "$sous_repertoire")
  fi

  mkdir -p "$output_directory/$nom_sous_repertoire"

  for fichier in $input_directory/$nom_sous_repertoire/*; do
    if [ -f "$fichier" ]; then
        # Supprimer l'extension du nom du fichier
        nom_sans_extension=$(basename "$fichier" | sed 's/\.[^.]*$//')

        gnuplot -e "load './script/gen_img.gb'; 
                    set title 'try'; 
                    set output '$output_directory/$nom_sous_repertoire/$nom_sans_extension.png'; 
                    plot '$fichier' using 5:xtic(1) ti col, '' u 2 ti col, '' u 3 ti col, '' u 4 ti col"
    fi
  done

done