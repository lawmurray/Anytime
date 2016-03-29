#!/bin/sh

export CUDA_VISIBLE_DEVICES=0,1,2,3,6,7

SIZE=6
SIZEM1=5

libbi sample @config.conf @posterior.conf --tmoves 14400 --enable-mpi --mpi-np $SIZE --enable-diagnostics 4

for i in `seq 0 $SIZEM1`
do
  ncpdq -O -a np,nr,n results/posterior.nc.$i results/posterior_t.nc.$i
  ncks -O --mk_rec_dmn np results/posterior_t.nc.$i results/posterior_t.nc.$i
  cp sir.log.$i sir_time.log.$i
done
ncrcat -O results/posterior_t.nc.[0-$SIZEM1] results/posterior_t.nc
ncpdq -O -a nr,n,np results/posterior_t.nc results/posterior_time.nc


libbi sample @config.conf @posterior.conf --nmoves 10 --enable-mpi --mpi-np $SIZE --enable-diagnostics 4

for i in `seq 0 $SIZEM1`
do
  ncpdq -O -a np,nr,n results/posterior.nc.$i results/posterior_t.nc.$i
  ncks -O --mk_rec_dmn np results/posterior_t.nc.$i results/posterior_t.nc.$i
  cp sir.log.$i sir_samples.log.$i
done
ncrcat -O results/posterior_t.nc.[0-$SIZEM1] results/posterior_t.nc
ncpdq -O -a nr,n,np results/posterior_t.nc results/posterior_samples.nc
