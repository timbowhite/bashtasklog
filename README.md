bashtasklog
===========

A utility logging class for bash implemented in an OO interface.  It prints nicely formatted messages to the console and/or logfile.  The format is  similar to Linux boot messages. 

It's intended to be used to create task/progress logs for bash scripts.


Screenshots
===========
![ss1](http://www.zulius.com/img/blog/bash-beauty/bash-beauty-ss1.jpg)

![ss2](http://www.zulius.com/img/blog/bash-beauty/bash-beauty-ss2.jpg)

![ss3](http://www.zulius.com/img/blog/bash-beauty/bash-beauty-ss3.jpg)


Usage
=====

## bashtasklog constructor ##
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

## printTask ##
    NAME
            bashtasklog.printTask

    SYNOPSIS
            instance_var.printTask [MESSAGE]

    DESCRIPTION
            Prints a message to the console and/or task log.

    EXAMPLE:
            1)  Print a message:

                logger.printTask "foo bar baz"

## printOk ##
    NAME
            bashtasklog.printOk

    SYNOPSIS
            instance_var.printOk [MESSAGE]

    DESCRIPTION
            Prints a green "OK" in square brackets. If optional MESSAGE is
            passed, it is printed on the next line in green text.

## printFail ##
    NAME
            bashtasklog.printFail

    SYNOPSIS
            instance_var.printFail [MESSAGE]

    DESCRIPTION
            Prints a red "FAIL" in square brackets. If optional MESSAGE is
            passed, it is printed on the next line in red text.

## printWarn ##
    NAME
            bashtasklog.printWarn

    SYNOPSIS
            instance_var.printWarn [MESSAGE]

    DESCRIPTION
            Prints a orange "WARN" in square brackets. If optional MESSAGE is
            passed, it is printed on the next line in orange text.

## printInfo ##
    NAME
            bashtasklog.printInfo

    SYNOPSIS
            instance_var.printInfo [MESSAGE]

    DESCRIPTION
            Prints a blue "INFO" in square brackets. If optional MESSAGE is
            passed, it is printed on the next line in blue text.


Example
========
    # source the library file
    . bashtasklog.sh
    
    # instantiate a bashtasklog object
    new bashtasklog logger -t -w 50 -l "/tmp/foo.log"

    # print some messages
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



Contributing
============

Want to add something sweet? Here's what to do:

1. Fork this repository
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Send a pull request
5. Booyah. Done. 


Author
======

Timbo White of Zulius[Zulius](http://www.zulius.com).

Follow on the twittinator: [_zulius_](http://twitter.com/_zulius_) 


License - GPL2
==============

Copyright (c) 2011 Zulius 

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
