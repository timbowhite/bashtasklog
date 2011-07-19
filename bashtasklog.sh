<<HEAD

Name:           bashtasklog.sh
Company:        Zulius
Author:         Timbo White 
                (OOP implementation derived from
                code by Pim van Riezen)
Version:        0.0.1
Website:        http://www.zulius.com
Description:    Bash function library for displaying formatted 
                messages to the console and log files.  
                The output imitates the display format of 
                Linux boot messages. 
Copyright:      2009 Zulius
License:        GPL v2 (http://www.gnu.org/licenses/gpl-2.0.html)

HEAD

# ---------------------------------------------------------------------------
# OO support functions
# Kludged by Pim van Riezen <pi@madscience.nl>
# ---------------------------------------------------------------------------
DEFCLASS=""
CLASS=""
THIS=0

class() {
  DEFCLASS="$1"
  eval CLASS_${DEFCLASS}_VARS=""
  eval CLASS_${DEFCLASS}_FUNCTIONS=""
}

static() {
  return 0
}

func() {
  local varname="CLASS_${DEFCLASS}_FUNCTIONS"
  eval "$varname=\"\${$varname}$1 \""
}

var() {
  local varname="CLASS_${DEFCLASS}_VARS"
  eval $varname="\"\${$varname}$1 \""
}

loadvar() {
  eval "varlist=\"\$CLASS_${CLASS}_VARS\""
  for var in $varlist; do
    eval "$var=\"\$INSTANCE_${THIS}_$var\""
  done
}

loadfunc() {
  eval "funclist=\"\$CLASS_${CLASS}_FUNCTIONS\""
  for func in $funclist; do
    eval "${func}() { ${CLASS}::${func} \"\$@\"; return \$?; }"
  done
}

savevar() {
  eval "varlist=\"\$CLASS_${CLASS}_VARS\""
  for var in $varlist; do
    eval "INSTANCE_${THIS}_$var=\"\$$var\""
  done
}

typeof() {
  eval echo \$TYPEOF_$1
}

new() {
  local class="$1"
  local cvar="$2"
  shift
  shift
  local id=$(uuidgen | tr A-F a-f | sed -e "s/-//g")
  eval TYPEOF_${id}=$class
  eval $cvar=$id
  local funclist
  eval "funclist=\"\$CLASS_${class}_FUNCTIONS\""
  for func in $funclist; do
    eval "${cvar}.${func}() { local t=\$THIS; THIS=$id; local c=\$CLASS; CLASS=$class; loadvar; loadfunc; ${class}::${func} \"\$@\"; rt=\$?; savevar; CLASS=\$c; THIS=\$t; return $rt; }"
  done
  eval "${cvar}.${class} \"\$@\" || true"
}

# bashtasklog class definition
class bashtasklog
  func bashtasklog
  func print
  func printTask
  func printOk
  func printFail
  func printWarn
  func printInfo
  func setWidth
  func setQuiet
  func setTimestamp
  func setLogfile
  func printStatus
  var timestamp
  var logfile
  var quiet
  var width

<<BTL
NAME
        bashtasklog constructor 

SYNOPSIS
        new bashtasklog your_instance_var_here [OPTIONS]

OPTIONS:
        -t      flag to automatically prepend all task messages with 14 a digit timestamp
        -l      specify a log file to write to
        -q      quiet mode flag. Do not output to stdout, only write to log file if supplied
        -w      width of padded message column. Defaults to 80 characters.

EXAMPLE:
        1)  Instantiate a bashtasklog object that will append a timestamp
            to each message, have a message column 50 chars in width,
            and will write to log file /tmp/foo.log: 

            new bashtasklog logger -t -w 50 -l "/tmp/foo.log"

BTL
bashtasklog::bashtasklog() {
  # get options
  OPTARG=""
  OPTIND=1
  while getopts ":tql:w:" OPT; do
    case $OPT in
      t) setTimestamp 1 ;;
      q) setQuiet 1 ;;
      l) setLogfile $OPTARG ;;
      w) setWidth $OPTARG ;;
      :)
    esac
  done

  # get remaining arguments
  shift $(($OPTIND - 1))
  OPTIND=1

  # defaults 
  if [ -z "$width" ]; then setWidth 80; fi
}

# sets the width of the task column
bashtasklog::setWidth() { width="%-${1}s"; } 

# sets timestamp flag (1 = on, anything else = off)
bashtasklog::setTimestamp() {
  if [ ! -z $1 ] && [ $1 == "1" ]; then
    timestamp="1";
  else
    timestamp="";
  fi
}

# sets quiet mode flag (1 = on, anything else = off)
bashtasklog::setQuiet() { 
  if [ ! -z $1 ] && [ $1 == "1" ]; then
    quiet="1";
  else
    quiet="";
  fi
}

# sets the logfile path
bashtasklog::setLogfile() { logfile="$1"; }

bashtasklog::printStatus() {
  local COLOR_RESET="\x1b[39;49;00m"
  local STATUS=''
  local COLOR=''

  case $1 in
      1) STATUS="[  OK  ]"; COLOR="\x1b[33;32m";;
      2) STATUS="[ FAIL ]"; COLOR="\x1b[31;31m";;
      3) STATUS="[ WARN ]"; COLOR="\x1b[33;33m";;
      4) STATUS="[ INFO ]"; COLOR="\x1b[36;01m";;
      *) STATUS="[ $1 ]"; COLOR="";;
  esac

  # quiet mode, print only to log file
  if [ ! -z "$quiet" ] && [ ! -z "$logfile" ]; then
    echo -e "$STATUS" >> "$logfile"

    # supplementary message
    if [ ! -z "$2" ]; then
      echo -e "\n$2\n" >> "$logfile"
    fi
    return 0
  fi

  # non-quiet mode with log file
  if [ -z "$quiet" ] && [ ! -z "$logfile" ]; then
    echo -e "${COLOR}${STATUS}${COLOR_RESET}"
    echo -e "${STATUS}" >> "$logfile"

    # supplementary message
    if [ ! -z "$2" ]; then
      echo -e "\n${COLOR}${2}${COLOR_RESET}\n"
      echo -e "\n$2\n" >> "$logfile"
    fi

    return 0
  fi

  # non-quiet mode, no log file
  echo -e "${COLOR}${STATUS}${COLOR_RESET}"

  # supplementary message
  if [ ! -z "$2" ]; then
    echo -e "\n${COLOR}${2}${COLOR_RESET}\n"
  fi
  return 0

}

# Echo's plain string to console and/or logfile.
# No padding or timestamp.
bashtasklog::print() {
  # quiet mode, print only to log file
  if [ ! -z "$quiet" ] && [ ! -z "$logfile" ]; then
    echo -e "$1" >> "$logfile"
    return 0
  fi

  # non-quiet mode with log file
  if [ -z "$quiet" ] && [ ! -z "$logfile" ]; then
    echo -e "$1" | tee -a "$logfile"
    return 0
  fi

  # no log file
  echo -e "$1"
}

<<BTL
NAME
        bashtasklog.printTask

SYNOPSIS
        instance_var.printTask [MESSAGE]

DESCRIPTION
        Prints a message to the console and/or task log.

EXAMPLE:
        1)  Print a message:

            logger.printTask "foo bar baz" 

BTL
bashtasklog::printTask() {
  local TIMESTAMP=''

  if [ ! -z "$quiet" ]; then
    TIMESTAMP=$(date +"%Y%m%d%H%M%S  ");
  fi

  # quiet mode, print only to log file
  if [ ! -z "$quiet" ] && [ ! -z "$logfile" ]; then
    printf "$width" "${TIMESTAMP}${1}" >> "$logfile"
    return 0
  fi

  # non-quiet mode with log file
  if [ -z "$quiet" ] && [ ! -z "$logfile" ]; then 
    printf "$width" "${TIMESTAMP}${1}" | tee -a "$logfile"
    return 0
  fi
  
  # no log file
  printf "$width" "${TIMESTAMP}${1}"

  return 0
}

<<BTL
NAME
        bashtasklog.printOk

SYNOPSIS
        instance_var.printOk [MESSAGE]

DESCRIPTION
        Prints a green "OK" in square brackets. If optional MESSAGE is 
        passed, it is printed on the next line in green text. 
BTL
bashtasklog::printOk() {
  printStatus "1" "$1"
  return 0
}

<<BTL
NAME
        bashtasklog.printFail

SYNOPSIS
        instance_var.printFail [MESSAGE]

DESCRIPTION
        Prints a red "FAIL" in square brackets. If optional MESSAGE is
        passed, it is printed on the next line in red text.
BTL
bashtasklog::printFail() {
  printStatus "2" "$1" 
  return 0  
}

<<BTL
NAME
        bashtasklog.printWarn

SYNOPSIS
        instance_var.printWarn [MESSAGE]

DESCRIPTION
        Prints a orange "WARN" in square brackets. If optional MESSAGE is
        passed, it is printed on the next line in orange text.
BTL
bashtasklog::printWarn() {
  printStatus "3" "$1"
  return 0
}

<<BTL
NAME
        bashtasklog.printInfo

SYNOPSIS
        instance_var.printInfo [MESSAGE]

DESCRIPTION
        Prints a blue "INFO" in square brackets. If optional MESSAGE is
        passed, it is printed on the next line in blue text.
BTL
bashtasklog::printInfo() {
  printStatus "4" "$1"
  return 0
}
