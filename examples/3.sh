#!/bin/bash

# get dir this script is in
CWD=`dirname $0`

# source the library file
. "${CWD}/../bashtasklog.sh"

# set up log file path variable
LOG_FILE="/tmp/foobar.log"

new bashtasklog logger -t -w 50 -l "$LOG_FILE"

logger.printTask "Process running"
sleep 1s    # your code here
logger.printOk 

logger.printTask "Implementing and executing"
sleep 1s
logger.printOk

logger.printTask "Doing stuff"
sleep 1s
logger.printOk

logger.printTask "Gittin 'er done"
sleep 1s
logger.printFail "Max hillbilly tolerance level reached" 
