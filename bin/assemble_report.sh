#!/bin/bash
  
DIST_DIR=$1

#Concatenate the files together into one dist html file
cat $DIST_DIR/{country_dist,hours_dist,username_dist}.html > concat_dist.html

#Create final summary html
bin/wrap_contents.sh concat_dist.html html_components/summary_plots $1/failed_login_summary.html

#Remove temporary file
rm concat_dist.html


