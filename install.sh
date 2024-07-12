#!/bin/bash

# Make sure we stop on errors
set -e 

COMPILER_OPTS_DEFAULT=""
COMPILER_OPTS_IFX="CC=icx F77=ifx 'FFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback' 'CFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback'"

COMPILER_OPTS=$COMPILER_OPTS_DEFAULT

if [[ $1 = "ifx" ]]; then
    COMPILER_OPTS=$COMPILER_OPTS_IFX
fi

echo "COMPILER_OPTS = $COMPILER_OPTS"
echo ""

# Define the root source directory
SRCDIR=$PWD

### FFTW ###

FFTWSRC=fftw-3.3.10

# with omp enabled
cd $FFTWSRC
eval "./configure --disable-doc --prefix=$SRCDIR/exlib/fftw-omp --enable-openmp $COMPILER_OPTS"
make clean
make
make install
cd $SRCDIR

# serial (without omp) 
cd $FFTWSRC
eval "./configure --disable-doc --prefix=$SRCDIR/exlib/fftw-serial $COMPILER_OPTS"
make clean
make
make install
cd $SRCDIR

### LIS ###

if [[ $2 = "pik" ]]; then
    module load intel/oneAPI/2023.2.0 #(error when compiling with most recent intel OneAPI 2024.0)
fi

LISSRC=lis-2.1.6

# with omp enabled
cd $LISSRC
eval "./configure --prefix=$SRCDIR/exlib/lis-omp --enable-f90 --enable-omp $COMPILER_OPTS"
make clean
make
make install
cd $SRCDIR

# serial (without omp) 
cd $LISSRC
eval "./configure --prefix=$SRCDIR/exlib/lis-serial --enable-f90 $COMPILER_OPTS" 
make clean
make
make install
cd $SRCDIR


if [[ $2 = "pik" ]]; then
    module load intel/oneAPI/2024.0.0 #(to revert previous change)
fi

echo ""
echo "" 
./check.sh
echo ""
