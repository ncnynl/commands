#!/bin/bash
################################################################
# Function : launch_ailibot2_nav 
# Desc     : 启动ailibot2导航的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Sat Oct 14 12:04:33 PM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "launch_ailibot2_nav")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

function _rcm_usage_() {
    cat << EOF
Usage:
    launch_ailibot2_nav 

Description:
    启动ailibot2导航的脚本

Option:
    --help|-h:                                         -- using help
    --type|-t:                                         -- type mode, for checking how to run, type=[slam,localization] , if don't have type , use slam

EOF
}

function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o ht: --long help,type: -n 'Error' -- "$@"`
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
            -t|--type)
                type=$2
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
    echo "launch_ailibot2_nav start ..."
    case "$type" in
        'localization')
            echo "webrtc"
            # ros2 launch ailibot2_teleop teleop_webrtc.launch.py
            ;;
        *)
            echo "teleop!"
            # ros2 launch ailibot2_teleop teleop.launch.py
            ;;            
    esac

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*