#!/bin/sh

export CUDA_VISIBLE_DEVICES=7

#libbi sample @config.conf @bifurc.conf --init-file data/init.nc --output-file results/bifurc.nc
#libbi sample @config.conf @bifurc.conf --init-file data/init_zoom.nc --output-file results/bifurc_zoom.nc

octave --path oct -q --eval "image_bifurc('results/bifurc.nc', 'figs/bifurc');"
octave --path oct -q --eval "image_bifurc('results/bifurc_zoom.nc', 'figs/bifurc_zoom');"
