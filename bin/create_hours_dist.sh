#!/bin/bash
  
#Parameter 1 is the directory that contains subdirectories that may contain a failed_login_data.txt file
HOUR_DIR=$1

# 1. grab all of the hours from entries in failed_login_data.txt
# 2. count the number of occurences of each hour
# 3. put it in data.addRow(['hour', occurences]);
ALL_SUBDIRS_FILES=`ls -d $HOUR_DIR/*/failed_login_data.txt`
cat $ALL_SUBDIRS_FILES | awk '{print $3;}' | sort | uniq --count | awk '{print "data.addRow([\x27"$2"\x27, "$1"]);";}' > hour_data.js

#Using the javascript we just generated, wrap it in html and produce the hours_dist.html 
bin/wrap_contents.sh hour_data.js html_components/hours_dist $HOUR_DIR/hours_dist.html

# Remove the temp file
rm hour_data.js

