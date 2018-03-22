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
printf "%s\nlayout:none\npermalink: /paper_library.html\n%s\n" '---' '---' > header

# reinstert doctype line and url for the paper library
printf "<!DOCTYPE HTML>\n" >> header
printf "<font size="3", color=#7742f4> Click <a href=\"%s\">here</a> to go to documents.\nDocuments are sorted by year/bibtexkey.</font>\n" \
    'https://drive.google.com/drive/folders/0B04bPEjpYXgPOENycDlySnQ2Y2M?usp=sharing'\
    >> header

# concatenate with the library and clean up
cat header tmp > tmp2

scripts/./file2comment.py tmp2 tmp3
diff --ignore-space-change --changed-group-format='%<' --unchanged-group-format='' --ignore-case --speed-large-files tmp3 paper_library.html > diffs
scripts/./newfiles.py diffs diffs2
scripts/./addlinks.py tmp3 diffs2 paper_library.html

rm tmp tmp2 tmp3 $1 header diffs diffs2
