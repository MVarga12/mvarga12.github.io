#!/usr/local/bin/python
# adds links to new articles to the top of the page
import datetime
import sys

filename = sys.argv[1]
filename2 = sys.argv[2]
lines = [line.split() for line in open(filename,"r")]
new_files = [line.split() for line in open(filename2,"r")]

if len(new_files) == 0:
    link = ["<br> <font size=3, color=red> NEW (" + str(datetime.date.today()) + "):  No new textbooks. </font>"]
else:
    for i in range(0, len(lines)):
        if len(lines[i]) >= 3:
            if lines[i][2] == "class=\"entry\">":
                tmp = lines[i][1].split('=')
                for elem in new_files:
                    if tmp[1][1:len(tmp[1])-1] == elem[0]:
                        linkbeg = "<a name=\"" + tmp[1][1:len(tmp[1])-1] + "\">"
                        linkend = "</a>"
                        lines[i+1].insert(len(lines[i+1])-1, linkbeg)
                        lines[i+1].insert(len(lines[i+1])-1, linkend)
                        for k in range(i,i+50):
                            if lines[k][0] == "title":
                                elem.extend((linkbeg,linkend,lines[k][2:]))
                                break
                        elem.extend((linkbeg, linkend, " "))
    
    link = ["<br> <font size=3, color=red> NEW (" + str(datetime.date.today()) + "): </font> <font size=3>"]
    for elem in new_files:
        if new_files[i][3][0] != " ":
            elem[3][0]=elem[3][0][1:]
            elem[3][len(elem[3])-1]=elem[3][len(elem[3])-1][:-2]
            link.append("<a href=\"#" + elem[0] + "\">" + elem[0] + ", " + " ".join(elem[3]) + ')' + elem[2] + ',')
        else:
            link.append('(' + "<a href=\"" + new_files[i][0] + "\">" + new_files[i][0] + ", " + " ".join(new_files[i][3]) + ')' + new_files[i][2])

link.append("</font>")
lines.insert(7, link)

with open(sys.argv[3],"w") as out:
    for line in lines:
        for elem in line:
            out.write(elem + ' ')
        out.write('\n')
