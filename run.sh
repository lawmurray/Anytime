#!/bin/sh

SIZE=128
SIZEM1=127
HOSTFILE=hostfile
TIME=300
MOVES=10

libbi sample @config.conf @posterior.conf --tmoves $TIME --enable-mpi --mpi-np $SIZE --mpi-hostfile $HOSTFILE --enable-diagnostics 4
for i in `seq 0 $SIZEM1`
do
  ncpdq -O -a np,nr,n results/posterior.nc.$i results/posterior_t.nc.$i
  ncks -O --mk_rec_dmn np results/posterior_t.nc.$i results/posterior_t.nc.$i
  cp sir.log.$i sir_time.log.$i
done
ncrcat -O results/posterior_t.nc.* results/posterior_t.nc
ncpdq -O -a nr,n,np results/posterior_t.nc results/posterior_time.nc
rm results/posterior_t.nc*

libbi sample @config.conf @posterior.conf --nmoves $MOVES --enable-mpi --mpi-np $SIZE --mpi-hostfile $HOSTFILE --enable-diagnostics 4
for i in `seq 0 $SIZEM1`
do
  ncpdq -O -a np,nr,n results/posterior.nc.$i results/posterior_t.nc.$i
  ncks -O --mk_rec_dmn np results/posterior_t.nc.$i results/posterior_t.nc.$i
  cp sir.log.$i sir_samples.log.$i
done
ncrcat -O results/posterior_t.nc.* results/posterior_t.nc
ncpdq -O -a nr,n,np results/posterior_t.nc results/posterior_samples.nc
rm results/posterior_t.nc*
