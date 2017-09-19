#!/bin/bash

Path=$(find . -name "$1" -print)

cd "$Path"

cat username_dist.html hours_dist.html country_dist.html > report.txt

mv report.txt ..

cd ..

wrap_contents.sh report.txt html_components/summary_plots failed_login_summary.html

rm report.txt
