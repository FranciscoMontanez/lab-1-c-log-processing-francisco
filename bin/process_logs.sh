#!/bin/bash
  

TEMP_DIR="/tmp/temp_dir"

#Silently create the temp directory
mkdir "$TEMP_DIR"  2>/dev/null


for TAR_FILE in $*;
do
    #Get the name of the file minus _secure.tgz
    #for instance zeus_secure.tgz
    #becomes      zeus
    TAR_NAME=`basename --suffix=_secure.tgz $TAR_FILE `

    #Extract the contents of each of the tar files
    #into new directories with the names determined above

    mkdir "$TEMP_DIR/$TAR_NAME"
    tar -xf "$TAR_FILE" --directory "$TEMP_DIR/$TAR_NAME";

    #Create failed_login_data.txt for each of the systems
    bin/process_client_logs.sh "$TEMP_DIR/$TAR_NAME"

done;

#Create javascript files with HTML headers/footers
bin/create_username_dist.sh "$TEMP_DIR"
bin/create_hours_dist.sh "$TEMP_DIR"
bin/create_country_dist.sh "$TEMP_DIR"

#Assemble javascript into html file
bin/assemble_report.sh "$TEMP_DIR"

#Move the resulting summary to the working directory
mv "$TEMP_DIR/failed_login_summary.html" .

#Clean up temporary files
rm -r "$TEMP_DIR"

