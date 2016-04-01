#!/bin/sh

#octave --path oct -q --eval "plot_and_print()"

for svg in `ls figs/*.svg`
  do
    inkscape --export-pdf $svg
  done

#for pdf in `ls figs/*.pdf`
#do
#  pdfcrop $pdf $pdf
#done
