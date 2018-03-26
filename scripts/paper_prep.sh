#!/usr/local/bin/fish
# using bash doesn't work because jenv is set up with fish, currently

####
# simple code to take an html library created with JabRef and 
# prepare it for use with jekyll, with inserted url for paper library
# found in my google drive
# mjv 3/16/18
####

jenv shell oracle64-1.8.0.162
java -jar /Applications/JabRef.app/Contents/java/app/JabRef-4.1.jar -i ../../Paper_Library.bib -o tmp_html,html_table_w_filelinks -n
printf "Preparing library %s" tmp_html

# remove the doctype line from the html library
tail -n +2 tmp_html > tmp

# create new header in the jekyll style
printf "%s\nlayout:none\npermalink: /paper_library.html\n%s\n" '---' '---' > header

# reinstert doctype line and url for the paper library
printf "<!DOCTYPE HTML>\n" >> header
printf "<font size="3", color=#7742f4> Click <a href=\"%s\">here</a> to go to documents.\nDocuments are sorted by year/bibtexkey.</font>\n" \
    'https://drive.google.com/drive/folders/0B04bPEjpYXgPOENycDlySnQ2Y2M?usp=sharing'\
    >> header

# concatenate with the library and clean up
cat header tmp > tmp2

./file2comment.py tmp2 tmp3
./newfiles.py paper_library.html tmp3 diffs
./addlinks.py tmp3 diffs paper_library.html

rm tmp_html tmp tmp2 tmp3 $1 header diffs
