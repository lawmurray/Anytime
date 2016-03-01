#!/bin/sh

# create init files
#octave --path oct -q --eval 'prepare_init';

# simulate a dense data set
libbi sample --target joint --model-file Lorenz96.bi --end-time 10 --noutputs 100 --nsamples 1 --output-file data/obs_dense.nc --init-file data/init_zoom.nc --init-np 36761 --seed 1

# extract a sparse data set using OctBi
rm -f data/obs_sparse.nc
octave --path oct -q --eval "bi_sparsify_var('data/obs_dense.nc', 'data/obs_sparse.nc', 'y', [1:4]')"
