#!/bin/bash

# If there is a local compilation file that overrides ours we will use that.
# Note that the list of names is completely arbitrary and might grow.
if [ -f make.sh ];
then
    ./make.sh
else
    # We then look for the main tex file if there are various tex files
    filename="${1%%.*}"
    shopt -s nullglob
    for i in *.latexmain; do
        filename="${i%%.*}"
    done
    filetexname="$filename.tex"
    # Compile it with references if a .bib document exists
    count=`ls -1 *.bib 2>/dev/null | wc -l`
    pdflatex $filetexname
    if [ $count != 0 ];
    then
    bibtex $filename
    fi
    pdflatex $filetexname
    pdflatex $filetexname
fi
