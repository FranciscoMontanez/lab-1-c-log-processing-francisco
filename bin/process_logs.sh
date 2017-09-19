#!/bin/bash

originalPath=$(pwd)

mkdir temp

for f in $@ ; do

        NAME=$(basename $f)

        FILENAME=$(echo $NAME | sed 's/_secure.tgz//g')

        mkdir temp/"$FILENAME"

        cd temp

        cd "$FILENAME"

        tar -xf ../../log_files/$NAME

        cd ..

        cd ..

        process_client_logs.sh $FILENAME

done;

create_username_dist.sh temp 

create_hours_dist.sh temp

create_country_dist.sh temp

assemble_report.sh temp

rm -r temp
