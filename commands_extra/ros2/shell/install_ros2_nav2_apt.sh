#!/bin/bash
################################################################
# Function : install_ros2_nav2_apt related usage
# Desc     : APT安装nav2导航包的脚本                        
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Sat Dec  9 09:56:19 AM CST 2023                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                                   
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_ros2_nav2_apt related usage")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

# For ros install
function _rcm_ros_install_() {
    package_name="navigation2"

    # if installed ?
    if [ -d /opt/ros/${ROS_DISTRO}/share/nav2_bringup ]; then
        echo "$package_name have installed!!" 
    else
        echo "Install related system dependencies"
        sudo apt update
        #for nav2
        sudo apt install -y ros-${ROS_DISTRO}-navigation2
        sudo apt install -y ros-${ROS_DISTRO}-nav2-bringup
        sudo apt install -y ros-${ROS_DISTRO}-turtlebot3-gazebo

        # success
        echo "ROS $package_name installed successfully location is: /opt/ros/${ROS_DISTRO}/share/ "
    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_ros2_nav2_apt --along --blong argb --clong argc

Description:
    install_ros2_nav2_apt related usage.

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
    echo "install_ros2_nav2_apt start ..."
    _rcm_ros_install_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*