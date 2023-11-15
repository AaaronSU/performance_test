#!/bin/bash

n=256
r=256
pourcentage="5"
dir_name="benchmark/n$n\_r$r"


check_file() {
    # Récupérer la ligne contenant les données (en supposant que le fichier s'appelle 'benchmark/dotprod_clang_o0.dat')
    data_line=$(grep "BASE" $1)

    # Extraire la valeur encore avant
    value_stddev=$(echo "$data_line" | awk -F';' '{gsub(/\(/, "", $12); print $(NF-1)}')

    # # Afficher les deux valeurs
    # echo "La valeur avant le pourcentage de stddev est : $value_stddev"


    # Utilisation de grep pour extraire la valeur
    extracted_value=$(echo "$value_stddev" | grep -oP '\(\s*\K[0-9.]+(?=\s*%\))')

    # if [ -n "$extracted_value" ]; then
    #     echo "La valeur extraite est : $extracted_value"
    # else
    #     echo "Aucune valeur extraite."
    # fi

    # Utilisation de la découpe pour extraire la partie entière
    integer_part="${extracted_value%.*}"

    # echo "La partie entière est : $integer_part"

    if [ "$integer_part" -gt $pourcentage ]; then
        return 1  # Renvoie 1 (faux) sinon
    fi


    # UNROLL
    # Récupérer la ligne contenant les données (en supposant que le fichier s'appelle 'benchmark/dgemm_clang_o0.dat')
    data_line_unroll=$(grep "UNROLL4" $1)

    stddev_value_unroll=$(echo "$data_line_unroll" | awk -F';' '{gsub(/\(/, "", $12); print $(NF-1)}')

    echo "La valeur précédant le pourcentage de stddev est : $stddev_value_unroll"

    # Utilisation de grep pour extraire la valeur
    extracted_value_unroll=$(echo "$stddev_value_unroll" | grep -oP '\(\s*\K[0-9.]+(?=\s*%\))')

    if [ -n "$extracted_value_unroll" ]; then
        echo "La valeur extraite est : $extracted_value_unroll"
    else
        echo "Aucune valeur extraite."
    fi

    # Utilisation de la découpe pour extraire la partie entière
    integer_part_unroll="${extracted_value_unroll%.*}"

    echo "La partie entière de UNROLL est : $integer_part_unroll"

    if [ "$integer_part_unroll" -gt $pourcentage ]; then
        return 1  # Renvoie 1 (faux) sinon
    fi


    # UNROLL_8
    # Récupérer la ligne contenant les données (en supposant que le fichier s'appelle 'benchmark/dgemm_clang_o0.dat')
    data_line_unroll_8=$(grep "UNROLL8" $1)

    stddev_value_unroll_8=$(echo "$data_line_unroll_8" | awk -F';' '{gsub(/\(/, "", $12); print $(NF-1)}')

    echo "La valeur précédant le pourcentage de stddev est : $stddev_value_unroll_8"

    # Utilisation de grep pour extraire la valeur
    extracted_value_unroll_8=$(echo "$stddev_value_unroll_8" | grep -oP '\(\s*\K[0-9.]+(?=\s*%\))')

    if [ -n "$extracted_value_unroll_8" ]; then
        echo "La valeur extraite est : $extracted_value_unroll_8"
    else
        echo "Aucune valeur extraite."
    fi

    # Utilisation de la découpe pour extraire la partie entière
    integer_part_unroll_8="${extracted_value_unroll_8%.*}"

    echo "La partie entière de UNROLL8 est : $integer_part_unroll_8"
    if [ $pourcentage -gt "$integer_part_unroll_8" ]; then
        return 0  # Renvoie 0 (vrai) si nombre1 est supérieur à nombre2
    else
        return 1  # Renvoie 1 (faux) sinon
    fi

}

mkdir $dir_name


# Version o0
make clean
make CC=gcc OFLAGS=-o0
./dotprod $n $r > $dir_name/dotprod_gcc_o0.dat
check_file $dir_name/dotprod_gcc_o0.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_gcc_o0.dat
    check_file $dir_name/dotprod_gcc_o0.dat
done
cat $dir_name/dotprod_gcc_o0.dat

make clean
make CC=clang OFLAGS=-o0
./dotprod $n $r > $dir_name/dotprod_clang_o0.dat
check_file $dir_name/dotprod_clang_o0.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_clang_o0.dat
    check_file $dir_name/dotprod_clang_o0.dat
done
cat $dir_name/dotprod_clang_o0.dat

make clean
make CC=icc OFLAGS=-o0
./dotprod $n $r > $dir_name/dotprod_icc_o0.dat
check_file $dir_name/dotprod_icc_o0.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_icc_o0.dat
    check_file $dir_name/dotprod_icc_o0.dat
done
cat $dir_name/dotprod_icc_o0.dat

make clean
make CC=icx OFLAGS=-o0
./dotprod $n $r > $dir_name/dotprod_icx_o0.dat
check_file $dir_name/dotprod_icx_o0.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_icx_o0.dat
    check_file $dir_name/dotprod_icx_o0.dat
done
cat $dir_name/dotprod_icx_o0.dat


# Version o1
make clean
make CC=gcc OFLAGS=-o1
./dotprod $n $r > $dir_name/dotprod_gcc_o1.dat
check_file $dir_name/dotprod_gcc_o1.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_gcc_o1.dat
    check_file $dir_name/dotprod_gcc_o1.dat
done
cat $dir_name/dotprod_gcc_o1.dat

make clean
make CC=clang OFLAGS=-o1
./dotprod $n $r > $dir_name/dotprod_clang_o1.dat
check_file $dir_name/dotprod_clang_o1.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_clang_o1.dat
    check_file $dir_name/dotprod_clang_o1.dat
done
cat $dir_name/dotprod_clang_o1.dat

make clean
make CC=icc OFLAGS=-o1
./dotprod $n $r > $dir_name/dotprod_icc_o1.dat
check_file $dir_name/dotprod_icc_o1.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_icc_o1.dat
    check_file $dir_name/dotprod_icc_o1.dat
done
cat $dir_name/dotprod_icc_o1.dat

make clean
make CC=icx OFLAGS=-o1
./dotprod $n $r > $dir_name/dotprod_icx_o1.dat
check_file $dir_name/dotprod_icx_o1.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_icx_o1.dat
    check_file $dir_name/dotprod_icx_o1.dat
done
cat $dir_name/dotprod_icx_o1.dat


# Version o2
make clean
make CC=gcc OFLAGS=-o2
./dotprod $n $r > $dir_name/dotprod_gcc_o2.dat
check_file $dir_name/dotprod_gcc_o2.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_gcc_o2.dat
    check_file $dir_name/dotprod_gcc_o2.dat
done
cat $dir_name/dotprod_gcc_o2.dat

make clean
make CC=clang OFLAGS=-o2
./dotprod $n $r > $dir_name/dotprod_clang_o2.dat
check_file $dir_name/dotprod_clang_o2.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_clang_o2.dat
    check_file $dir_name/dotprod_clang_o2.dat
done
cat $dir_name/dotprod_clang_o2.dat

make clean
make CC=icc OFLAGS=-o2
./dotprod $n $r > $dir_name/dotprod_icc_o2.dat
check_file $dir_name/dotprod_icc_o2.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_icc_o2.dat
    check_file $dir_name/dotprod_icc_o2.dat
done
cat $dir_name/dotprod_icc_o2.dat

make clean
make CC=icx OFLAGS=-o2
./dotprod $n $r > $dir_name/dotprod_icx_o2.dat
check_file $dir_name/dotprod_icx_o2.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_icx_o2.dat
    check_file $dir_name/dotprod_icx_o2.dat
done
cat $dir_name/dotprod_icx_o2.dat


# Version o3
make clean
make CC=gcc OFLAGS=-o3
./dotprod $n $r > $dir_name/dotprod_gcc_o3.dat
check_file $dir_name/dotprod_gcc_o3.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_gcc_o3.dat
    check_file $dir_name/dotprod_gcc_o3.dat
done
cat $dir_name/dotprod_gcc_o3.dat

make clean
make CC=clang OFLAGS=-o3
./dotprod $n $r > $dir_name/dotprod_clang_o3.dat
check_file $dir_name/dotprod_clang_o3.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_clang_o3.dat
    check_file $dir_name/dotprod_clang_o3.dat
done
cat $dir_name/dotprod_clang_o3.dat

make clean
make CC=icc OFLAGS=-o3
./dotprod $n $r > $dir_name/dotprod_icc_o3.dat
check_file $dir_name/dotprod_icc_o3.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_icc_o3.dat
    check_file $dir_name/dotprod_icc_o3.dat
done
cat $dir_name/dotprod_icc_o3.dat

make clean
make CC=icx OFLAGS=-o3
./dotprod $n $r > $dir_name/dotprod_icx_o3.dat
check_file $dir_name/dotprod_icx_o3.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_icx_o3.dat
    check_file $dir_name/dotprod_icx_o3.dat
done
cat $dir_name/dotprod_icx_o3.dat


# Version ofast
make clean
make CC=gcc OFLAGS=-ofast
./dotprod $n $r > $dir_name/dotprod_gcc_ofast.dat
check_file $dir_name/dotprod_gcc_ofast.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_gcc_ofast.dat
    check_file $dir_name/dotprod_gcc_ofast.dat
done
cat $dir_name/dotprod_gcc_ofast.dat

make clean
make CC=clang OFLAGS=-ofast
./dotprod $n $r > $dir_name/dotprod_clang_ofast.dat
check_file $dir_name/dotprod_clang_ofast.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_clang_ofast.dat
    check_file $dir_name/dotprod_clang_ofast.dat
done
cat $dir_name/dotprod_clang_ofast.dat

make clean
make CC=icc OFLAGS=-ofast
./dotprod $n $r > $dir_name/dotprod_icc_ofast.dat
check_file $dir_name/dotprod_icc_ofast.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_icc_ofast.dat
    check_file $dir_name/dotprod_icc_ofast.dat
done
cat $dir_name/dotprod_icc_ofast.dat

make clean
make CC=icx OFLAGS=-ofast
./dotprod $n $r > $dir_name/dotprod_icx_ofast.dat
check_file $dir_name/dotprod_icx_ofast.dat
until [ $? -eq 0 ]; do
    ./dotprod $n $r > $dir_name/dotprod_icx_ofast.dat
    check_file $dir_name/dotprod_icx_ofast.dat
done
cat $dir_name/dotprod_icx_ofast.dat
