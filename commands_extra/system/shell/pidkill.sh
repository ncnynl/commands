#!/bin/bash
################################################################
# Function : pidkill 
# Desc     : 用于关闭指定的进程的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Sat Oct 28 01:56:37 PM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "pidkill")"

source ${HOME}/commands/cs_utils_ros.sh

_pid_kill_(){   
    PIDCOUNT=`ps -ef | grep $1 | grep -v "grep" | grep -v $0 | grep -v "pidkill"  | awk '{print $2}' | wc -l`;  
    echo "Found process num: ${PIDCOUNT} "
    if [ ${PIDCOUNT} -gt 0 ] ; then  
        echo "There are ${PIDCOUNT} process contains name[$1]" 
        echo "Program is:"
        ps -ef | grep $1 | grep -v "grep" | grep -v "pidkill" 
        
        PID=`ps -ef | grep $1 | grep -v "grep" | grep -v "pidkill" | awk '{print $2}'` ;
        echo "$1 's PID is: $PID"
        kill -9  ${PID};
        echo "$1 's PID has killed!";
    elif [ ${PIDCOUNT} -le 0 ] ; then 
        echo "No such process[$1]!"  
    fi  
} 

function _rcm_usage_() {
    cat << EOF
Usage:
    pidkill 

Description:
    用于关闭指定的进程的脚本

Option:
    --help|-h:                                         -- using help
    --name|-n:                                         -- name of pid to kill 

EOF
}

function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o hn: --long help,name: -n 'Error' -- "$@"`
    if [ $? != 0 ]; then
        echo "Invalid option..." >&2;
        exit 1;
    fi
    # rearrange the order of parameters
    eval set -- "$ARGS"
    # after being processed by getopt, the specific options are dealt with below.
    while true ; do
        case "$1" in
            -h|--help)
                _rcm_usage_
                exit 1
                ;;
            -n|--name)
                name=$2
                shift 2
                ;;                 
            --)
                shift
                break
                ;;
            *)
                echo "Internal Error!"
                exit 1
                ;;
        esac
    done

    if [[ $debug == 1 ]]; then
        set -x
    fi

    # start
    echo "pidkill start ..."
    _pid_kill_ $name

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*