#!/bin/sh

export CUDA_VISIBLE_DEVICES=7
SKIP=""

for d in `seq 0 3`
do
  for f in `seq 0 1791`
  do
      libbi filter @config.conf @tau.conf --init-np $f --output-file results/tau.nc.$d.$f $SKIP

      SKIP="--dry-parse --dry-build" # next time skip build to speed up
  done
done
