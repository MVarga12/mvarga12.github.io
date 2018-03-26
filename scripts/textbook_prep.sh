#!/usr/local/bin/fish
#/bin/bash

####
# simple code to take an html library created with JabRef and 
# prepare it for use with jekyll, with inserted url for paper library
# found in my google drive
# mjv 3/16/18
####

jenv shell oracle64-1.8.0.162
java -jar /Applications/JabRef.app/Contents/java/app/JabRef-4.1.jar -i ../../Textbook_Library.bib -o tmp_html,textbook_table -n
printf "Preparing library %s" tmp_html

# remove the doctype line from the html library
tail -n +2 tmp_html > tmp

# create new header in the jekyll style
printf "%s\nlayout:none\npermalink: /textbook_library.html\n%s\n" '---' '---' > header

# reinstert doctype line and url for the paper library
printf "<!DOCTYPE HTML>\n" >> header
printf "<font size="3", color=#7742f4> Click <a href=\"%s\">here</a> to go to documents.\nTextbooks can be found in their accompanying directory (\"first author\'s last name\"_\"short title\".pdf).</font>\n" \
    'https://drive.google.com/open?id=0B04bPEjpYXgPcUZoMFpva29IbmM'\
    >> header

# concatenate with the library and clean up
cat header tmp > tmp2 #textbook_library.html

./file2comment.py tmp2 tmp3
./newfiles.py textbook_library.html tmp3 diffs2
./addlinks2.py tmp3 diffs2 textbook_library.html

rm tmp_html tmp tmp2 tmp3 $1 header diffs
