#!/bin/bash

Path=$(find . -name "$1" -print)

cd "$Path"

for subfolder in */ ; do

         cd "$subfolder"

         sort -k 3 failed_login_data.txt | awk '{print $3}' > result.txt

         cat result.txt >> ../hoursResult.txt

         rm result.txt

         cd ..

done;

sort  hoursResult.txt |uniq -c | awk '{print "data.addRow([""\x27"$2"\x27"",",$1"]);"}' > Hoursresult.txt

rm hoursResult.txt

mv Hoursresult.txt ..

cd ..

wrap_contents.sh Hoursresult.txt html_components/hours_dist $Path/hours_dist.html

rm Hoursresult.txt

