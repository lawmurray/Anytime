#!/bin/sh

CUDA_VISIBLE_DEVICES=7
SKIP=""

for d in `seq 0 3`
do
  rm -f results/tau_simulate.csv.$d results/tau_filter.csv.$d

  for f in `seq 0 1791`
  do
      libbi sample @config.conf @tau_simulate.conf --init-np $f $SKIP | cut -d ' ' -f 2 >> results/tau_simulate.csv.$d
      libbi filter @config.conf @tau_filter.conf --init-np $f $SKIP | cut -d ' ' -f 2 >> results/tau_filter.csv.$d

      SKIP="--dry-parse --dry-build" # next time skip build to speed up
  done
done
