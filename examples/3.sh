#!/bin/bash

# get dir this script is in
CWD=`dirname $0`

# source the library file
. "${CWD}/../bashtasklog.sh"

# set up log file path variable
LOG_FILE="/tmp/foobar.log"

printTask -t -w 50 -l "$LOG_FILE" "Process running"
sleep 1s    # your code here
printOk -l "$LOG_FILE"

printTask -t -w 50 -l "$LOG_FILE" "Implementing and executing"
sleep 1s
printOk -l "$LOG_FILE"

printTask -t -w 50 -l "$LOG_FILE" "Doing stuff"
sleep 1s
printOk -l "$LOG_FILE"

printTask -t -w 50 -l "$LOG_FILE" "Gittin 'er done"
sleep 1s
printFail -l "$LOG_FILE" "Max hillbilly tolerance level reached"
