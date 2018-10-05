#!/bin/bash

# First look for the main tex file if there are various tex files
echo "hola"
echo $1
filename="${1%%.*}"
echo $filename
shopt -s nullglob
for i in *.latexmain; do
    filename="${i%%.*}"
done
filetexname="$filename.tex"
echo $filetexname

# Compile it with references if a .bib document exists in the current directory
pdflatex $filetexname
count=`ls -1 *.bib 2>/dev/null | wc -l`
if [ $count != 0 ]
then
bibtex $filename
fi
pdflatex $filetexname
pdflatex $filetexname
