#!/bin/sh

#libbi sample @config.conf @posterior.conf

for i in `seq 0 3`
do
  ncpdq -O -a np,nr,n results/posterior.nc.$i results/posterior_t.nc.$i
  ncks -O --mk_rec_dmn np results/posterior_t.nc.$i results/posterior_t.nc.$i
done
ncrcat -O results/posterior_t.nc.* results/posterior_t.nc
ncpdq -O -a nr,n,np results/posterior_t.nc results/posterior.nc
