#!/bin/bash

# get dir this script is in
CWD=`dirname $0`

# source the library file
. "${CWD}/../bashtasklog.sh"

printTask "Executing arbitrary code"
sleep 2
printOk
