#!/bin/bash

Path=$(find . -name "$1" -print)

cd "$Path"

#Using for loop to obtain data from failed_login_data.txt in each subdirectory
#and printing hoursResult using awk
for subfolder in */ ; do
         cd "$subfolder"
         sort -k 3 failed_login_data.txt | awk '{print $3}' > result.txt
         cat result.txt >> ../hoursResult.txt
         rm result.txt
         cd ..
done;

#Sorts the data on hoursResult.txt onto Hoursresult.txt
sort hoursResult.txt |uniq -c | awk '{print "data.addRow([""\x27"$2"\x27"",",$1"]);"}' > Hoursresult.txt

#Removing unsorted temp file
rm hoursResult.txt

#Moving sorted temp file to directory
mv Hoursresult.txt ..
cd ..

#Wrapping contents of Hoursresult.txt to create html file
./wrap_contents.sh Hoursresult.txt html_components/hours_dist $Path/hours_dist.html

rm Hoursresult.txt
