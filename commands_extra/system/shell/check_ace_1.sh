#!/bin/bash
################################################
# Function : Check Bash Completion   
# Desc     : 用于检测自动补全功能是否完整                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-09-03                    
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                          
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Check ace shell")"

# Usage of ace.sh
function _rcm_usage_() {
    cat << EOF
Usage:
    nox poker ace [--count <count>] [--reverse]

Description:
    Print poker numbers.

Option:
    --help|-h:                                          -- using help
    --debug|-x:                                         -- debug mode
    --reverse|-r:                                       -- whether to print in reverse order, or print in normal order without this option
    --count|-c:                                         -- the number of times to print, if there is no option, it will be printed once

EOF
}

##########################################################################################################################
#
# English note
# getopt command format description:
#   -o: means define short option
#       Example explanation: `ab:c::` defines three option types.
#           a There is no colon after a, which means that the defined a option is a switch type (true/false), and no additional parameters are required. Using the -a option means true.
#           b Followed by a colon, it means that the defined b option requires additional parameters, such as: `-b 30`
#           c Followed by a double colon, it means that the defined c option has an optional parameter, and the optional parameter must be close to the option, such as: `-carg` instead of `-c arg`
#   -long: means define long options
#       Example explanation: `a-long,b-long:,c-long::`. The meaning is basically the same as above.
#   "$@": a list representing the arguments, not including the command itself
#   -n: indicates information when an error occurs
#   --: A list representing the arguments themselves, not including the command itself
#       How to create a directory with -f
#       `mkdir -f` will fail because -f will be parsed as an option by mkdir
#       `mkdir -- -f` will execute successfully, -f will not be considered as an option
#
##########################################################################################################################
function rcm_execute() {
    rcm system check_ace --count 10
    
    # local debug=0
    # local reverse=false
    # local count=1

    # local ARGS=`getopt -o hxrc: --long help,debug,reverse,count: -n 'Error' -- "$@"`
    # if [ $? != 0 ]; then
    #     error "Invalid option..." >&2;
    #     exit 1;
    # fi
    # # rearrange the order of parameters
    # eval set -- "$ARGS"
    # # after being processed by getopt, the specific options are dealt with below.
    # while true ; do
    #     case "$1" in
    #         -h|--help)
    #             _rcm_usage_
    #             exit 1
    #             ;;
    #         -x|--debug)
    #             debug=1
    #             shift
    #             ;;
    #         -r|--reverse)
    #             reverse=true
    #             shift
    #             ;;
    #         -c|--count)
    #             count=$2
    #             shift 2
    #             ;;
    #         --)
    #             shift
    #             break
    #             ;;
    #         *)
    #             error "Internal Error!"
    #             exit 1
    #             ;;
    #     esac
    # done

    # if [[ $debug == 1 ]]; then
    #     set -x
    # fi

    # # start
    # rcm system check_ace

    # if [[ $debug == 1 ]]; then
    #     set +x
    # fi
}

# Execute current script
rcm_execute $*
