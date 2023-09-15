#!/bin/bash
################################################
# Function : install_crazyswarm2 related usage
# Desc     : 用于安装crazyswarm2的脚本                        
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Fri Sep 15 12:09:50 PM CST 2023                           
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
echo "$(gettext "install_crazyswarm2 related usage")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

# For ros install
function _rcm_ros_install_() {
    workspace="ros2_crazyflie_ws"
    package_name="crazyswarm2"

    # if installed ?
    if [ -d ~/$workspace/src/$package_name ]; then
        echo "$package_name have installed!!" 
    else
        echo "Install related system dependencies"
        sudo apt update
        # Install dependencies
        sudo apt-get install make gcc-arm-none-eabi

        echo "Go to workspace"
        if [ ! -d ~/$workspace/ ];then
            mkdir -p ~/$workspace/src
        fi
        cd ~/$workspace/

        echo "Configure git proxy"
        git config --global url."https://ghproxy.com/https://github.com".insteadof https://github.com
        
        echo "this will take a while to download"
        echo "Dowload $package_name"
        git clone --recursive https://github.com/bitcraze/crazyflie-firmware.git

        echo "Install related dependencies by rosdep"
        cd crazyflie-firmware
        git submodule init
        git submodule update

        echo "Build the code"
        make cf2_defconfig
        make -j 12

        # Build python bindings
        make bindings_python

        echo "Add workspace to bashrc"
        #for ros2:
        if ! grep -Fq "crazyflie-firmware/build" ~/.bashrc
        then
            echo "export PYTHONPATH=$$workspace/crazyflie-firmware/build:$PYTHONPATH" >> ~/.bashrc
            echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
        else
            echo "Has been inited before! Please check ~/.bashrc"
        fi

        # success
        echo "ROS $package_name installed successfully location is: ~/$workspace/src/$package_name "
    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_crazyswarm2 --along --blong argb --clong argc

Description:
    install_crazyswarm2 related usage.

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
    echo "install_crazyswarm2 start ..."
    # _rcm_ros_install_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*