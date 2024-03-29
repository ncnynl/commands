#!/bin/bash
################################################################
# Function : install_micro_ros_agent 
# Desc     : 安装micro-ros-agent的源码版本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Mon Sep 18 09:18:33 PM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_micro_ros_agent")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

function _rcm_run_() {

    workspace="ros2_micro_ros_ws"
    package_name="micro_ros_setup"

    # if installed ?
    if [ -d ~/$workspace/src/$package_name ]; then
        echo "You have installed $package_name, you can continue to install micro-ros-agent " 

        cd ~/$workspace
        echo "create_agent_ws"
        source install/local_setup.bash
        ros2 run micro_ros_setup create_agent_ws.sh

        echo "build_agent.sh"
        source install/local_setup.bash
        ros2 run micro_ros_setup build_agent.sh

        echo "has Installed!"
        echo "run as :"  
        echo "ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/ttyUSB0 "
    else
        echo "Pleae execute install_micro_ros first: rcm ros2_stm32 install_micro_ros"
    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_micro_ros_agent 

Description:
    安装micro-ros-agent的源码版本

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file

EOF
}

function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o hekx --long help,edit,delete,debug -n 'Error' -- "$@"`
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
            -e|--edit)
                _rcm_edit_ $*
                exit 1
                ;;    
            -k|--delete)
                _rcm_delete_ $*
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
                echo "Internal Error!"
                exit 1
                ;;
        esac
    done

    if [[ $debug == 1 ]]; then
        set -x
    fi

    # start
    echo "install_micro_ros_agent start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*