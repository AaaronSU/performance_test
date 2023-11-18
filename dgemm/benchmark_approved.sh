#!/bin/bash

n=50
r=50
pourcentage="3"

dir_name="benchmark"

rm -r $dir_name
mkdir $dir_name


check_file() {

    # Ligne IJK

    # Récupérer la ligne contenant les données (en supposant que le fichier s'appelle 'benchmark/dgemm_clang_o0.dat')
    data_line_ijk=$(grep "IJK" $1)

    stddev_value_ijk=$(echo "$data_line_ijk" | awk -F';' '{gsub(/\(/, "", $12); print $(NF-2)}')

    echo "La valeur précédant le pourcentage de stddev est : $stddev_value_ijk"

    # Utilisation de grep pour extraire la valeur
    extracted_value_ijk=$(echo "$stddev_value_ijk" | grep -oP '\(\s*\K[0-9.]+(?=\s*%\))')

    if [ -n "$extracted_value_ijk" ]; then
        echo "La valeur extraite est : $extracted_value_ijk"
    else
        echo "Aucune valeur extraite."
    fi

    # Utilisation de la découpe pour extraire la partie entière
    integer_part_ijk="${extracted_value_ijk%.*}"

    echo "La partie entière de IJK est : $integer_part_ijk"

    if [ "$integer_part_ijk" -gt $pourcentage ]; then
        return 1  # Renvoie 1 (faux) sinon
    fi




    # IKJ
    # Récupérer la ligne contenant les données (en supposant que le fichier s'appelle 'benchmark/dgemm_clang_o0.dat')
    data_line_ikj=$(grep "IKJ" $1)

    stddev_value_ikj=$(echo "$data_line_ikj" | awk -F';' '{gsub(/\(/, "", $12); print $(NF-2)}')

    echo "La valeur précédant le pourcentage de stddev est : $stddev_value_ikj"

    # Utilisation de grep pour extraire la valeur
    extracted_value_ikj=$(echo "$stddev_value_ikj" | grep -oP '\(\s*\K[0-9.]+(?=\s*%\))')

    if [ -n "$extracted_value_ikj" ]; then
        echo "La valeur extraite est : $extracted_value_ikj"
    else
        echo "Aucune valeur extraite."
    fi

    # Utilisation de la découpe pour extraire la partie entière
    integer_part_ikj="${extracted_value_ikj%.*}"

    echo "La partie entière de IKJ est : $integer_part_ikj"

    if [ "$integer_part_ikj" -gt $pourcentage ]; then
        return 1  # Renvoie 1 (faux) sinon
    fi
    

    # IEX
    # Récupérer la ligne contenant les données (en supposant que le fichier s'appelle 'benchmark/dgemm_clang_o0.dat')
    data_line_iex=$(grep "IEX" $1)

    stddev_value_iex=$(echo "$data_line_iex" | awk -F';' '{gsub(/\(/, "", $12); print $(NF-2)}')

    echo "La valeur précédant le pourcentage de stddev est : $stddev_value_iex"

    # Utilisation de grep pour extraire la valeur
    extracted_value_iex=$(echo "$stddev_value_iex" | grep -oP '\(\s*\K[0-9.]+(?=\s*%\))')

    if [ -n "$extracted_value_iex" ]; then
        echo "La valeur extraite est : $extracted_value_iex"
    else
        echo "Aucune valeur extraite."
    fi

    # Utilisation de la découpe pour extraire la partie entière
    integer_part_iex="${extracted_value_iex%.*}"

    echo "La partie entière de IEX est : $integer_part_iex"

    if [ "$integer_part_iex" -gt $pourcentage ]; then
        return 1  # Renvoie 1 (faux) sinon
    fi

    # UNROLL
    # Récupérer la ligne contenant les données (en supposant que le fichier s'appelle 'benchmark/dgemm_clang_o0.dat')
    data_line_unroll=$(grep "UNROLL4" $1)

    stddev_value_unroll=$(echo "$data_line_unroll" | awk -F';' '{gsub(/\(/, "", $12); print $(NF-2)}')

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

    stddev_value_unroll_8=$(echo "$data_line_unroll_8" | awk -F';' '{gsub(/\(/, "", $12); print $(NF-2)}')

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

    echo "La partie entière de UNROLL est : $integer_part_unroll_8"

    if [ $pourcentage -gt "$integer_part_unroll_8" ]; then
        return 0  # Renvoie 0 (vrai) si nombre1 est supérieur à nombre2
    else
        return 1  # Renvoie 1 (faux) sinon
    fi




    # # CBLAS
    # # Récupérer la ligne contenant les données (en supposant que le fichier s'appelle 'benchmark/dgemm_clang_o0.dat')
    # data_line_cblas=$(grep "CBLAS" $1)

    # stddev_value_cblas=$(echo "$data_line_cblas" | awk -F';' '{gsub(/\(/, "", $12); print $(NF-2)}')

    # echo "La valeur précédant le pourcentage de stddev est : $stddev_value_cblas"

    # # Utilisation de grep pour extraire la valeur
    # extracted_value_cblas=$(echo "$stddev_value_cblas" | grep -oP '\(\s*\K[0-9.]+(?=\s*%\))')

    # if [ -n "$extracted_value_cblas" ]; then
    #     echo "La valeur extraite est : $extracted_value_cblas"
    # else
    #     echo "Aucune valeur extraite."
    # fi

    # # Utilisation de la découpe pour extraire la partie entière
    # integer_part_cblas="${extracted_value_cblas%.*}"

    # echo "La partie entière est : $integer_part_cblas"

    # if [ $pourcentage -gt "$integer_part_cblas" ]; then
    #     return 0  # Renvoie 0 (vrai) si nombre1 est supérieur à nombre2
    # else
    #     return 1  # Renvoie 1 (faux) sinon
    # fi
}

# Version o1
make clean
make CC=gcc OFLAGS=-o1
./dgemm $n $r > $dir_name/dgemm_gcc_o1.dat
check_file $dir_name/dgemm_gcc_o1.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_gcc_o1.dat
    check_file $dir_name/dgemm_gcc_o1.dat
done
cat $dir_name/dgemm_gcc_o1.dat

make clean
make CC=clang OFLAGS=-o1
./dgemm $n $r > $dir_name/dgemm_clang_o1.dat
check_file $dir_name/dgemm_clang_o1.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_clang_o1.dat
    check_file $dir_name/dgemm_clang_o1.dat
done
cat $dir_name/dgemm_clang_o1.dat

make clean
make CC=icc OFLAGS=-o1
./dgemm $n $r > $dir_name/dgemm_icc_o1.dat
check_file $dir_name/dgemm_icc_o1.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_icc_o1.dat
    check_file $dir_name/dgemm_icc_o1.dat
done
cat $dir_name/dgemm_icc_o1.dat

make clean
make CC=icx OFLAGS=-o1
./dgemm $n $r > $dir_name/dgemm_icx_o1.dat
check_file $dir_name/dgemm_icx_o1.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_icx_o1.dat
    check_file $dir_name/dgemm_icx_o1.dat
done
cat $dir_name/dgemm_icx_o1.dat


# Version o2
make clean
make CC=gcc OFLAGS=-o2
./dgemm $n $r > $dir_name/dgemm_gcc_o2.dat
check_file $dir_name/dgemm_gcc_o2.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_gcc_o2.dat
    check_file $dir_name/dgemm_gcc_o2.dat
done
cat $dir_name/dgemm_gcc_o2.dat

make clean
make CC=clang OFLAGS=-o2
./dgemm $n $r > $dir_name/dgemm_clang_o2.dat
check_file $dir_name/dgemm_clang_o2.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_clang_o2.dat
    check_file $dir_name/dgemm_clang_o2.dat
done
cat $dir_name/dgemm_clang_o2.dat

make clean
make CC=icc OFLAGS=-o2
./dgemm $n $r > $dir_name/dgemm_icc_o2.dat
check_file $dir_name/dgemm_icc_o2.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_icc_o2.dat
    check_file $dir_name/dgemm_icc_o2.dat
done
cat $dir_name/dgemm_icc_o2.dat

make clean
make CC=icx OFLAGS=-o2
./dgemm $n $r > $dir_name/dgemm_icx_o2.dat
check_file $dir_name/dgemm_icx_o2.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_icx_o2.dat
    check_file $dir_name/dgemm_icx_o2.dat
done
cat $dir_name/dgemm_icx_o2.dat


# Version o3
make clean
make CC=gcc OFLAGS=-o3
./dgemm $n $r > $dir_name/dgemm_gcc_o3.dat
check_file $dir_name/dgemm_gcc_o3.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_gcc_o3.dat
    check_file $dir_name/dgemm_gcc_o3.dat
done
cat $dir_name/dgemm_gcc_o3.dat

make clean
make CC=clang OFLAGS=-o3
./dgemm $n $r > $dir_name/dgemm_clang_o3.dat
check_file $dir_name/dgemm_clang_o3.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_clang_o3.dat
    check_file $dir_name/dgemm_clang_o3.dat
done
cat $dir_name/dgemm_clang_o3.dat

make clean
make CC=icc OFLAGS=-o3
./dgemm $n $r > $dir_name/dgemm_icc_o3.dat
check_file $dir_name/dgemm_icc_o3.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_icc_o3.dat
    check_file $dir_name/dgemm_icc_o3.dat
done
cat $dir_name/dgemm_icc_o3.dat

make clean
make CC=icx OFLAGS=-o3
./dgemm $n $r > $dir_name/dgemm_icx_o3.dat
check_file $dir_name/dgemm_icx_o3.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_icx_o3.dat
    check_file $dir_name/dgemm_icx_o3.dat
done
cat $dir_name/dgemm_icx_o3.dat


# Version ofast
make clean
make CC=gcc OFLAGS=-ofast
./dgemm $n $r > $dir_name/dgemm_gcc_ofast.dat
check_file $dir_name/dgemm_gcc_ofast.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_gcc_ofast.dat
    check_file $dir_name/dgemm_gcc_ofast.dat
done
cat $dir_name/dgemm_gcc_ofast.dat

make clean
make CC=clang OFLAGS=-ofast
./dgemm $n $r > $dir_name/dgemm_clang_ofast.dat
check_file $dir_name/dgemm_clang_ofast.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_clang_ofast.dat
    check_file $dir_name/dgemm_clang_ofast.dat
done
cat $dir_name/dgemm_clang_ofast.dat

make clean
make CC=icc OFLAGS=-ofast
./dgemm $n $r > $dir_name/dgemm_icc_ofast.dat
check_file $dir_name/dgemm_icc_ofast.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_icc_ofast.dat
    check_file $dir_name/dgemm_icc_ofast.dat
done
cat $dir_name/dgemm_icc_ofast.dat

make clean
make CC=icx OFLAGS=-ofast
./dgemm $n $r > $dir_name/dgemm_icx_ofast.dat
check_file $dir_name/dgemm_icx_ofast.dat
until [ $? -eq 0 ]; do
    ./dgemm $n $r > $dir_name/dgemm_icx_ofast.dat
    check_file $dir_name/dgemm_icx_ofast.dat
done
cat $dir_name/dgemm_icx_ofast.dat
