#!/bin/bash

for i in `seq 1 8`
do
  octave --path oct -q --eval "prepare_toy($i)" &
done
