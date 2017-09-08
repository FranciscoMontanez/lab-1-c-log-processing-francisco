#!/bin/bash
cd $1
ls ./var/log | cat ./var/log/* | grep -E "Failed" | awk '{print $1, $2, $3, $9, $11, $13}' | sed -E 's/:[0-9]+:[0-9]+//g' | sed -E 's/invalid //g' | awk '{for(i=6;i<=6;i++)$i="";$1=$1;$2=$2;$3=$3;$4=$4;$5=$5}1'  > failed_login_data.txt
