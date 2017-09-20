#!/bin/bash

path=$(pwd)

cd $1

#Using for loop to obtain data from failed_login_data.txt in each subdirectory
#and printing userNames using awk
for subfolder in */ ; do
         cd "$subfolder"
         sort -k 4  failed_login_data.txt | awk '{print $4}' > result.txt        
         cat result.txt >> ../userNameResult.txt
         rm result.txt
         cd ..
done;

#Sorts the data on userNameResult.txt onto usernameResult.txt
sort userNameResult.txt |uniq -c | awk '{print "data.addRow([""\x27"$2"\x27"",",$1"]);"}' > usernameResult.txt

#Removing unsorted temp file
rm userNameResult.txt

#Moving sorted temp file to directory
mv usernameResult.txt ..
cd ..

#Wrapping contents of usernameResult.txt to create html file
./wrap_contents.sh usernameResult.txt html_components/username_dist/username_dist.html

rm usernameResult.txt
