#!/bin/bash

Path=$(find . -name "$1" -print)

cd "$Path"

#Using for loop to obtain data from failed_login_data.txt in each subdirectory
#and printing countrynames using awk
for subfolder in */ ; do
         cd "$subfolder"
         sort -k 5  failed_login_data.txt | awk '{print $5}'  > result.txt
         join -1 1 result.txt ../../etc/country_IP_map.txt > ipResult.txt        
         cat ipResult.txt >> ../IPResult.txt
         rm result.txt
         rm ipResult.txt
         cd ..
done;

#Sorts the data on ipResult.txt onto IPResult.txt
sort -k 2 IPResult.txt | awk '{print $2}' | uniq -c | awk '{print "data.addRow([""\x27"$2"\x27"",",$1"]);"}' > countryResult.txt

#Removing unsorted temp file
rm IPResult.txt

#Moving sorted temp file to directory
mv countryResult.txt ..
cd ..

#Wrapping contents of countryResult.txt to create html file
./wrap_contents.sh countryResult.txt html_components/country_dist $Path/country_dist.html

rm countryResult.txt
