CFLAGS=-g -Wall

OFLAGS=-O3

INTEL_LFLAGS=-qmkl
GNU_LFLAGS=-lm -lcblas

FILES=main.c tools.c kernels.c

all: dotprod

dotprod:
ifeq ($(CC),icc)
	$(CC) $(CFLAGS) $(OFLAGS) $(FILES) -o $@ $(INTEL_LFLAGS)
else
ifeq ($(CC),icx)
	$(CC) $(CFLAGS) $(OFLAGS) $(FILES) -o $@ $(INTEL_LFLAGS)
else
ifeq ($(CC),gcc)
	$(CC) $(CFLAGS) $(OFLAGS) $(FILES) -o $@ $(GNU_LFLAGS)
else
ifeq ($(CC),clang)
	$(CC) $(CFLAGS) $(OFLAGS) $(FILES) -o $@ $(GNU_LFLAGS)
else
	@echo "ERROR: no compiler specified using CC. Possible values for CC: gcc, icc, icx, clang"
endif
endif
endif
endif

gen: gen_benchmark gen_stat gen_img

gen_benchmark:
	taskset -c 1 ./script/gen_benchmark.sh 2048 100 4
	taskset -c 1 ./script/gen_benchmark.sh 4096 100 4
	taskset -c 1 ./script/gen_benchmark.sh 81920 100 4
	taskset -c 1 ./script/gen_benchmark.sh 589824 100 4

gen_stat:
	./script/gen_stat.sh

gen_img:
	./script/gen_img.sh

clean:
	@rm -Rf dotprod
