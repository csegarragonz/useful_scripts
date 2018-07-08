#!/bin/bash

filename="${1%%.*}"
pdflatex $1
count=`ls -1 *.bib 2>/dev/null | wc -l`
if [ $count != 0 ]
then 
bibtex $filename
fi
pdflatex $1
pdflatex $1
echo $1
echo $filename

