#!/bin/bash
################################################
# Function : system completion template  
# Desc     : 用于测试自动补全的脚本模板                              
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
echo "$(gettext "system completion template")"

function _usage_() {
    cat << EOF
Usage:
    nox poker ace [--count <count>] [--reverse]

Description:
    Print poker numbers.

Option:
    --help|-h:                                          -- using help
    --count|-c:                                         -- the number of times the times

EOF
}

function _func_() {
    # install dep
    echo "Testing"
}

function _exec_() {
    local debug=0
    local reverse=false

    local ARGS=`getopt -o hxrc: --long help,debug,reverse,count: -n 'Error' -- "$@"`
    if [ $? != 0 ]; then
        error "Invalid option..." >&2;
        exit 1;
    fi
    # rearrange the order of parameters
    eval set -- "$ARGS"
    # after being processed by getopt, the specific options are dealt with below.
    while true ; do
        case "$1" in
            -h|--help)
                _usage_
                exit 1
                ;;
            -x|--debug)
                debug=1
                shift
                ;;
            --)
                shift
                break
                ;;
            *)
                error "Internal Error!"
                exit 1
                ;;
        esac
    done

    if [[ $debug == 1 ]]; then
        set -x
    fi

    # start
    _func_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
_exec_ $*