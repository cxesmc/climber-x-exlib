# climber-x-exlib
Convenience repository holding external libraries needed to run CLIMBER-X.

## Configure and compile each library

For a typical local system using a `gcc/gfortran` compiler, all libraries
can be installed simply by running the included `install.sh` script. This
will configure and compile the following:

```bash
exlib/fftw-omp
exlib/fftw-serial
exlib/lis-omp
exlib/lis-serial
```

Some specific install scripts are available for HPC systems.

`install_pik_hpc.sh` : PIK HPC2024 (Foote) system

## Use the libraries

Now a symlink can be made to these libraries for use within CLIMBER-X:

```bash
cd climber-x/utils
ln -s /path/to/climber-x-exlib/exlib
```




## To get the original libraries

This step is mainly only relevant for the maintainers of this repository,
or in the case that a user wants to try out different versions.

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
