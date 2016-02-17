#!/bin/sh

export CUDA_VISIBLE_DEVICES=7
libbi sample @config.conf @bifurc.conf --init-file data/init.nc
libbi sample @config.conf @bifurc.conf --init-file data/init_zoom.nc
