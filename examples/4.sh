#!/bin/bash

# get dir this script is in
CWD=`dirname $0`

# source the library file
. "${CWD}/../bashtasklog.sh"

new bashtasklog logger

logger.printTask "Making eye contact with girl across the bar"
sleep 1s    # simulate command execution
logger.printOk

logger.printTask "Got smile from girl"
sleep 1s
logger.printOk

logger.printTask "Faking cell phone call to look important"
sleep 1s
logger.printOk

logger.printTask "Consuming 6th beer; courage resources allocated"
sleep 1s
logger.printInfo

logger.printTask "Consuming 3 whiskey shots; courage buffer overflow"
sleep 1s
logger.printWarn

logger.printTask "Stumbling over to girl while room is spinning"
sleep 1s
logger.printWarn

logger.printTask "Regurgitating half-digested dinner into girl's lap"
sleep 1s
logger.printFail "Panic - girl's angry boyfriend approaching"
