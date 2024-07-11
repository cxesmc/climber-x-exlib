#!/bin/bash


COMPILER_OPTS_DEFAULT=""
COMPILER_OPTS_IFX="CC=icx F77=ifx 'FFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback' 'CFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback'"

COMPILER_OPTS=$COMPILER_OPTS_DEFAULT

if [[ $1 = "ifx" ]]; then
    COMPILER_OPTS=$COMPILER_OPTS_IFX
fi

echo "COMPILER_OPTS = $COMPILER_OPTS"
exit 0



SRCDIR=$PWD

### FFTW ###

FFTWSRC=fftw-3.3.10

# with omp enabled
cd $FFTWSRC
./configure --prefix=$SRCDIR/exlib/fftw-omp --enable-openmp $COMPILER_OPTS
make clean
make
make install
cd $SRCDIR

# serial (without omp) 
cd $FFTWSRC
./configure --prefix=$SRCDIR/exlib/fftw-serial $COMPILER_OPTS
make clean
make
make install
cd $SRCDIR

### LIS ###

LISSRC=lis-2.1.6

# with omp enabled
cd $LISSRC
./configure --prefix=$SRCDIR/exlib/lis-omp --enable-f90 --enable-omp
make clean
make
make install
cd $SRCDIR

# serial (without omp) 
cd $LISSRC
./configure --prefix=$SRCDIR/exlib/lis-serial --enable-f90 
make clean
make
make install
cd $SRCDIR

echo ""
echo "" 
./check.sh
echo ""
