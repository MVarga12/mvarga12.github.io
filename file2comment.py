#!/usr/local/bin/python
#from __future__ import print_function
import sys

filename = sys.argv[1] #html file for processing
lines = [line.split() for line in open(filename, "r")]


saved_lines = []
for i in range(0, len(lines)):
    if len(lines[i]) >= 1:
        if lines[i][0] == "file" and lines[i+1][0] != "comment":
            saved_lines.append([i,i+1])
            lines.insert(i+1, ["comment","=",lines[i][2]])
            lines[i][2] = lines[i][2] + ","
            i+=3

for i in range(0, len(saved_lines)):
    beg = lines[saved_lines[i][1]][2].find("/") # cuts out '{:Textbooks/'
    end = lines[saved_lines[i][1]][2].find(":",2) # finds ':PDF'
    end = lines[saved_lines[i][1]][2].rfind("/",0,end) # reverse searches string for the first '/' before ':PDF' to cut out the filename

    # also need to insert the comment into the column next to the year
    tmp = lines
    tmp = tmp[saved_lines[i][1]-20:saved_lines[i][1]]
    for idx in range(len(tmp)-1, -1, -1):
        if len(tmp[idx]) >= 1:
            if tmp[idx][0] == "<td></td>":
                tmp[idx][0] = "<td>" + lines[saved_lines[i][1]][2][beg:end] + "/</td>" 
                break
    lines[saved_lines[i][1]][2] = "{" + lines[saved_lines[i][1]][2][beg:end] + '/'

with open(sys.argv[2], "w") as output:
    for line in lines:
        for elem in line:
            output.write(elem + ' ')
        output.write('\n')
