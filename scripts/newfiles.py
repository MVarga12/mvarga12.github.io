#!/usr/local/bin/python
import sys

filename = sys.argv[1]
filename2 = sys.argv[2]
file1 = [line.split() for line in open(filename,"r")]
file2 = [line.split() for line in open(filename2,"r")]
new_files1 = []
new_files2 = []

for i in range(0, len(file1)):
    if len(file1[i]) >= 3:
        if file1[i][2] == "class=\"entry\">":
            new_files1.append(file1[i][1].split('='))

for i in range(0, len(file2)):
    if len(file2[i]) >= 3:
        if file2[i][2] == "class=\"entry\">":
            new_files2.append(file2[i][1].split('='))

new1 = []
new2 = []
for elem in new_files1:
    new1.append(elem[1])
for elem in new_files2:
    new2.append(elem[1])
    
out = list(set(sorted(new1)).symmetric_difference(set(sorted(new2))))

with open(sys.argv[3],"w") as output:
    for i in range(0, len(out)):
        output.write("%s\n" % out[i][1:len(out[i])-1])
