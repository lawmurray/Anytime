#!/bin/sh

cat /dev/null > results/tau3.csv
for f in `seq 0 179`
do
  libbi sample @config_tau.conf @tau.conf --init-np $f | cut -d ' ' -f 2 >> results/tau3.csv
done
