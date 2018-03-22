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
printf "%s\nlayout:none\npermalink: /textbook_library.html\n%s\n" '---' '---' > header

# reinstert doctype line and url for the paper library
printf "<!DOCTYPE HTML>\n" >> header
printf "<font size="3", color=#7742f4> Click <a href=\"%s\">here</a> to go to documents.\nTextbooks can be found in their accompanying directory (\"first author\'s last name\"_\"short title\".pdf).</font>\n" \
    'https://drive.google.com/open?id=0B04bPEjpYXgPcUZoMFpva29IbmM'\
    >> header

# concatenate with the library and clean up
cat header tmp > tmp2 #textbook_library.html

scripts/./file2comment.py tmp2 tmp3
diff --ignore-space-change --changed-group-format='%<' --unchanged-group-format='' --ignore-case --speed-large-files tmp3 paper_library.html > diffs
scripts/./newfiles.py diffs diffs2
scripts/./addlinks2.py tmp3 diffs2 textbook_library.html

rm tmp tmp2 tmp3 $1 header diffs diffs2
