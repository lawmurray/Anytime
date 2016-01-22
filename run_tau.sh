#!/bin/sh

rm results/tau.csv
for f in `seq 0 999`
do
  libbi sample @config_tau.conf @tau.conf --init-np $f | cut -d ' ' -f 2 >> results/tau.csv
done
