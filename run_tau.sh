#!/bin/sh

export CUDA_VISIBLE_DEVICES=3
SKIP=""

for f in `seq 0 75263`
do
    libbi filter @config.conf @tau.conf --init-np $f --output-file results/tau.nc.$f $SKIP
    SKIP="--dry-parse --dry-build" # next time skip build to speed up
done
