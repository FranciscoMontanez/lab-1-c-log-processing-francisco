#!/bin/bash

Path=$(find . -name "$1" -print)

cd "$Path"

for subfolder in */ ; do

         cd "$subfolder"

         sort -k 5  failed_login_data.txt | awk '{print $5}'  > result.txt

         join -1 1 result.txt ../../etc/country_IP_map.txt > ipResult.txt        

         cat ipResult.txt >> ../IPResult.txt

         rm result.txt

         rm ipResult.txt

         cd ..

done;

sort -k 2 IPResult.txt | awk '{print $2}' | uniq -c | awk '{print "data.addRow([""\x27"$2"\x27"",",$1"]);"}' > countryResult.txt

rm IPResult.txt

mv countryResult.txt ..

cd ..

wrap_contents.sh countryResult.txt html_components/country_dist $Path/country_dist.html

rm countryResult.txt
