#!/bin/bash

# get dir this script is in
CWD=`dirname $0`

# source the library file
. "${CWD}/../bashtasklog.sh"

printTask "Attempting to make eye contact with girl across the bar"
sleep 1s    # simulate command execution
printOk

printTask "Receiving smile from girl"
sleep 1s
printOk

printTask "Faking cell phone call to look important"
sleep 1s
printOk

printTask "Consuming 6th beer; courage resources allocated"
sleep 1s
printInfo

printTask "Consuming 3 whiskey shots; courage buffer overflow"
sleep 1s
printWarn

printTask "Stumbling over to girl while room is spinning"
sleep 1s
printWarn

printTask "Regurgitating half-digested dinner into girl's lap"
sleep 1s
printFail "Panic - girl's bodybuilder boyfriend approaching"

