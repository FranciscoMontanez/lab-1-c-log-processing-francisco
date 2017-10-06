#!/bin/bash


WORK_DIR=$1

cd $WORK_DIR
rm failed_login_data.txt 2>/dev/null

# 1. Read each line and filter for lines that contain "Failed password" 
#       There are two types of lines that contain "Failed password"
#       One for users that exist and one for users that don't exist.
#       The number of tokens (columns) in each of these lines is different.
#       We can differentiate which of these lines it is by the prescence of "invalid user"
# 2. Print out the relevant information for each user, taking into account whether
#       they were an invalid user.

for file in var/log/*
do
    awk '/Failed password/ {
        if (/invalid user/) {
                print $1, $2, substr($3, 0, 2), $11, $13;
        } else {
                print $1, $2, substr($3, 0, 2), $9, $11;
        }
    }' $file  >> failed_login_data.txt
done

