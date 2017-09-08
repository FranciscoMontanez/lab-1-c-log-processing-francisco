#!/bin/bash
path=$(pwd)
cd $1
for subfolder in */ ; do
         cd "$subfolder"
         sort -k 4  failed_login_data.txt | awk '{print $4}' > result.txt        
         cat result.txt >> ../userNameResult.txt
         rm result.txt
         cd ..
done;
sort  userNameResult.txt |uniq -c | awk '{print "data.addRow([""\x27"$2"\x27"",",$1"]);"}' > usernameResult.txt
rm userNameResult.txt
mv usernameResult.txt ..
cd ..
wrap_contents.sh usernameResult.txt html_components/username_dist $path/username_dist.html
rm usernameResult.txt


