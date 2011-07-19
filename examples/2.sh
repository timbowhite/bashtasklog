#!/bin/bash

# get dir this script is in
CWD=`dirname $0`

# source the library file
. "${CWD}/../bashtasklog.sh"

# step 2 - use printTask to display the task message
printTask "Attempting to touch /foo/bar"

# step 3 - execute the command,
# redirect command stderr to stdout,
# capture output to variable OUTPUT
OUTPUT=$(touch /foo/bar 2>&1)

# step 4 - examine the command's result code
if [ ! "$?" == 0 ]; then
  printFail "$OUTPUT"
  exit 1
fi
printOk
