#!/bin/bash
  
#Check that three arguments were passed (script expects 3 args)
if [ $# -ne 3 ]; then
        echo -e "\e[31mThis script requires 3 parameters\e[0m"
        echo "usage: wrap_contents.sh BODY WRAP_PATH DEST"
        exit 1
fi

#First parameter: Path to body
#Secnd parameter: Path to the path leading to the _header and _footer files
#Third parameter: Path of the file to output to

BODY_PATH="$1"

WRAP_PATH="$2"
HEADER_PATH="$2_header.html"
FOOTER_PATH="$2_footer.html"

DEST_PATH="$3"

#Concatenate all of the files and output them to the destination
cat $HEADER_PATH $BODY_PATH $FOOTER_PATH >$DEST_PATH

