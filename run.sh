#!/bin/sh

export CUDA_VISIBLE_DEVICES=4,5,6,7

#libbi sample @config.conf @posterior.conf --tmoves 28800 --enable-mpi --mpi-np 4 --enable-diagnostics 4
libbi sample @config.conf @posterior.conf --nmoves 4 --enable-mpi --mpi-np 4 --enable-diagnostics 4

for i in `seq 0 3`
do
  ncpdq -O -a np,nr,n results/posterior.nc.$i results/posterior_t.nc.$i
  ncks -O --mk_rec_dmn np results/posterior_t.nc.$i results/posterior_t.nc.$i
done
ncrcat -O results/posterior_t.nc.[0-3] results/posterior_t.nc
ncpdq -O -a nr,n,np results/posterior_t.nc results/posterior.nc
