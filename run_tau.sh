#!/bin/sh

export CUDA_VISIBLE_DEVICES=3
SKIP=""

for f in `seq 0 3583`
do
    libbi filter @config.conf @tau.conf --init-file data/init_tau.nc --init-np $f --output-file results/tau.nc.$f $SKIP
    libbi filter @config.conf @tau.conf --init-file data/init_tau_zoom.nc --init-np $f --output-file results/tau_zoom.nc.$f $SKIP
    SKIP="--dry-parse --dry-build" # next time skip build to speed up
done
