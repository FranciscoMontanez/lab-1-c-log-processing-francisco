#!/bin/bash
  
# each sub-dir has failed_login_data.txt
COUNTRY_DIR=$1

# 1. Get all the failed_login_data files 
# 2. Extract the IPs from the files and sort them and put them in country_ip_sorted.txt
# 3. We match IPs with country codes, then count the number of unique country codes,
#       then print them into javascript.
ALL_SUBDIRS_FILES=`ls -d $COUNTRY_DIR/*/failed_login_data.txt`
cat $ALL_SUBDIRS_FILES | awk '{print $5}' | sort > country_ip_sorted.txt
join country_ip_sorted.txt etc/country_IP_map.txt | awk '{print $2}' | sort | uniq --count | awk '{print "data.addRow([\x27"$2"\x27, "$1"]);";}' > country_data.js

bin/wrap_contents.sh country_data.js html_components/country_dist $COUNTRY_DIR/country_dist.html

# Remove the temp files
rm country_data.js
rm country_ip_sorted.txt
