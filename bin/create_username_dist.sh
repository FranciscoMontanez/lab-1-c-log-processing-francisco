#!/bin/bash
  
# each sub-dir has failed_login_data.txt
USERNAME_DIR=$1

# 1. grab all the unique user names
# 2. count the number of occurences of each unique username
# 3. put it in data.addRow(['username', occurences]);
ALL_SUBDIRS_FILES=`ls -d $USERNAME_DIR/*/failed_login_data.txt`
cat $ALL_SUBDIRS_FILES | awk '{print $4;}' | sort | uniq --count | awk '{print "data.addRow([\x27"$2"\x27, "$1"]);";}' > username_data.js

bin/wrap_contents.sh username_data.js html_components/username_dist $USERNAME_DIR/username_dist.html
# Remove the temp file
rm username_data.js
