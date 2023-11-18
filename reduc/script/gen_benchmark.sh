#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Erreur : Nombre d'arguments incorrect. Utilisation : $0 <n> <r> <pourcentage>"
    exit 1
fi

n=$1
r=$2
pourcentage=$3

dir_name="benchmark/n$n"
mkdir -p $dir_name

verify_line() {
    data_line=$(grep $2 $1)
    value_stddev=$(echo "$data_line" | awk -F';' '{gsub(/\(/, "", $12); print $(NF-1)}')
    extracted_value=$(echo "$value_stddev" | grep -oP '\(\s*\K[0-9.]+(?=\s*%\))')
    integer_part="${extracted_value%.*}"

    if [ $3 -gt "$integer_part" ]; then
        return 0  # Renvoie 0 (vrai) si nombre1 est supérieur à nombre2
    else
        return 1  # Renvoie 1 (faux) sinon
    fi
}

check_file() {
    file_name=$1

    # BASE
    if !(verify_line $file_name "BASE" $pourcentage); then
        return 1
    fi

    # UNROLL
    if !(verify_line $file_name "UNROLL4" $pourcentage); then
        return 1
    fi

    # UNROLL_8
    if !(verify_line $file_name "UNROLL8" $pourcentage); then
        return 1
    fi

    # CBLAS
    # if !(verify_line $file_name "CBLAS" "25"); then
    #     return 1
    # fi

    return 0

}

apply_fonction() {
    compiler=$1
    oflag=$2

    make clean
    make CC=$compiler OFLAGS="-$oflag"
    taskset -c 1 ./reduc "$n" "$r" > "$dir_name/reduc_${compiler}_${oflag}.dat"
    check_file "$dir_name/reduc_${compiler}_${oflag}.dat"
    until [ $? -eq 0 ]; do
        taskset -c 1 ./reduc "$n" "$r" > "$dir_name/reduc_${compiler}_${oflag}.dat"
        check_file "$dir_name/reduc_${compiler}_${oflag}.dat"
    done
    cat "$dir_name/reduc_${compiler}_${oflag}.dat"
}

# Version O0
apply_fonction "gcc" "O0"
apply_fonction "clang" "O0"
apply_fonction "icc" "O0"
apply_fonction "icx" "O0"

# Version O1
apply_fonction "gcc" "O1"
apply_fonction "clang" "O1"
apply_fonction "icc" "O1"
apply_fonction "icx" "O1"

# Version O2
apply_fonction "gcc" "O2"
apply_fonction "clang" "O2"
apply_fonction "icc" "O2"
apply_fonction "icx" "O2"

# # Version O3
apply_fonction "gcc" "O3"
apply_fonction "clang" "O3"
apply_fonction "icc" "O3"
apply_fonction "icx" "O3"

# Version Ofast
apply_fonction "gcc" "Ofast"
apply_fonction "clang" "Ofast"
apply_fonction "icc" "Ofast"
apply_fonction "icx" "Ofast"

make clean
