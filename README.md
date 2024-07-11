# climber-x-exlibs
Convenience repository holding external libraries needed to run CLIMBER-X.

## Configure and compile each library

```bash

### FFTW ###

FFTWSRC=fftw-3.3.10

# with omp enabled
cd $FFTWSRC
./configure --prefix=$PWD/../fftw-omp --enable-openmp CC=icx F77=ifx 'FFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback' 'CFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback'
make
make install
cd ../

# serial (without omp) 
./configure --prefix=$PWD/../fftw-serial --enable-openmp CC=icx F77=ifx 'FFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback' 'CFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback'
make
make install
cd ../

### LIS ###

# Only relevant to PIK-HPC2024: error when compiling with most recent intel OneAPI 2024.0
module load intel/oneAPI/2023.2.0

LISSRC=lis-2.1.6

# with omp enabled
cd $LISSRC
./configure --prefix=$PWD/../lis-omp --enable-omp --enable-f90 CC=icc FC=ifort 'FFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback' 'CFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback'
make
make install
cd ../

# serial (without omp) 
cd $LISSRC
make clean
./configure --prefix=$PWD/../lis-serial --enable-f90 CC=icc FC=ifort 'FFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback' 'CFLAGS=-Ofast -march=core-avx2 -mtune=core-avx2 -traceback'
make
make install
cd ../

# Only relevant to PIK-HPC2024: to revert previous change
module load intel/oneAPI/2024.0.0

```

Now a symlink can be made to these libraries for use within CLIMBER-X:

```bash
cd climber-x/utils
ln -s /path/to/fftw-serial
ln -s /path/to/fftw-omp
ln -s /path/to/lis-serial
ln -s /path/to/lis-omp
```




## To get the original libraries

```bash
### FFTW
wget https://www.fftw.org/fftw-3.3.10.tar.gz
tar -xvf fftw-3.3.10.tar.gz
rm fftw-3.3.10.tar.gz

### LIS
wget https://www.ssisc.org/lis/dl/lis-2.1.6.zip
unzip lis-2.1.6.zip
rm lis-2.1.6.zip
```

Then, proceed with configure/compile instructions above.
