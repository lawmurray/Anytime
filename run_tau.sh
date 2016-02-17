#!/bin/sh

export CUDA_VISIBLE_DEVICES=7
SKIP=""
for d in `seq 1 4`
do
  rm -f results/tau$d.csv
  for f in `seq 0 1791`
  do
      libbi filter @config.conf @tau.conf --init-np $f $SKIP | cut -d ' ' -f 2 >> results/tau$d.csv
      SKIP="--dry-parse --dry-build"
  done
done
