#!/bin/bash
################################################################
# Function : install_mocute_joy related usage
# Desc     : 安装mocute单手手柄驱动的脚本                        
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Thu Nov 23 01:55:50 PM CST 2023                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                                   
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_mocute_joy related usage")"

source ${HOME}/commands/cs_utils_ros.sh

# For ros install
function _rcm_ros_install_() {
    workspace="ros2_common_ws"
    package_name="teleop_twist_joy"

    # if installed ?
    if [ -d ~/$workspace/src/$package_name ]; then
        echo "$package_name have installed!!" 
    else
        echo "Install related system dependencies"
        sudo apt update

        echo "Go to workspace"
        if [ ! -d ~/$workspace/ ]; then
            mkdir -p ~/$workspace/src
        fi
        cd ~/$workspace/src

        echo "Configure git proxy"
        
        echo "this will take a while to download"
        echo "Dowload $package_name"
        git clone -b galactic https://gitee.com/ncnynl/teleop_twist_joy

        echo "Install related dependencies by rosdep"
        cd ~/$workspace/
        cs -si update_rosdep_tsinghua
        rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y  


        echo "Build the code"
        cd ~/$workspace 
        colcon build --symlink-install --packages-select $package_name

        echo "Add workspace to bashrc"
        if ! grep -Fq "$workspace/install/setup.bash" ~/.bashrc
        then
            echo ". ~/$workspace/install/setup.bash" >> ~/.bashrc
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
    install_mocute_joy --along --blong argb --clong argc

Description:
    install_mocute_joy related usage.

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
    echo "install_mocute_joy start ..."
    _rcm_ros_install_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*