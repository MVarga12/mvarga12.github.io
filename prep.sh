#!/bin/bash

####
# simple code to take an html library created with JabRef and 
# prepare it for use with jekyll, with inserted url for paper library
# found in my google drive
# mjv 3/16/18
####

printf "Preparing library %s" $1

# remove the doctype line from the html library
tail -n +2 $1 > tmp

# create new header in the jekyll style
printf "%s\nlayout:none\nurl: /paper_library.html\n%s\n" '---' '---' > header

# reinstert doctype line and url for the paper library
printf "<!DOCTYPE HTML>\n" >> header
printf "Click <a href=\"%s\">here</a> to go to documents.\nDocuments are sorted by year/bibtexkey.\n" \
    'https://drive.google.com/drive/folders/0B04bPEjpYXgPOENycDlySnQ2Y2M?usp=sharing'\
    >> header

# concatenate with the library and clean up
cat header tmp > library.html
rm tmp $1 header  
