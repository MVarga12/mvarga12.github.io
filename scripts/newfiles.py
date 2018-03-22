#!/usr/local/bin/python
import sys

filename = sys.argv[1]
lines = [line.split() for line in open(filename,"r")]
new_files = []

for i in range(0, len(lines)):
    if len(lines[i]) >= 3:
        if lines[i][2] == "class=\"entry\">":
            new_files.append(lines[i][1].split('='))

with open(sys.argv[2],"w") as out:
    for i in range(0, len(new_files)):
        out.write("%s\n" % new_files[i][1][1:len(new_files[i][1])-1])
