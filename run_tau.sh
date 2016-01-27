#!/bin/sh

export CUDA_VISIBLE_DEVICES=2
for d in `seq 1 16`
do
  rm results/tau$d.csv
  for f in `seq 0 1791`
  do
    libbi sample @config.conf @tau.conf --init-np $f --dry-parse --dry-build | cut -d ' ' -f 2 >> results/tau$d.csv
  done
done
