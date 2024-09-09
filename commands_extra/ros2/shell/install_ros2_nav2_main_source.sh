#!/bin/bash
################################################################
# Function : install_ros2_nav2_main_source related usage
# Desc     : 源码安装nav2最新版本导航包的脚本                        
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-09-07                        
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                                   
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_ros2_nav2_main_source related usage")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

exit 0

# For ros install
function _rcm_ros_install_() {
    workspace="ros2_nav2_main_ws"
    package_name="navigation2"

    # if installed ?
    if [ -d ~/$workspace/src/$package_name ]; then
        echo "$package_name have installed!!" 
    else
        #deps
        # https://github.com/ros-navigation/navigation2/blob/main/tools/underlay.repos
        
        echo "Install related system dependencies"
        sudo apt update
        sudo apt install ros-${ROS_DISTRO}-bondcpp
        sudo apt install ros-${ROS_DISTRO}-test-msgs
        sudo apt install ros-${ROS_DISTRO}-behaviortree-cpp-v3
        sudo apt install ros-${ROS_DISTRO}-diagnostic-updater
        sudo apt install ros-${ROS_DISTRO}-tf2-sensor-msgs
        sudo apt install ros-${ROS_DISTRO}-ompl

        echo "Go to workspace"
        if [ ! -d ~/$workspace/ ]; then
            mkdir -p ~/$workspace/src
        fi
        cd ~/$workspace/src

        echo "Configure git proxy"
        
        echo "this will take a while to download"
        echo "Dowload $package_name"

        git clone -b main  https://github.com/ros-planning/navigation2
        git clone -b ros2 https://github.com/ros/bond_core
        git clone https://github.com/ros-navigation/navigation2_dynamic

        echo "Install related dependencies by rosdep"
        cd ~/$workspace/
        cs -si update_rosdep_tsinghua
        rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y  

        echo "Build the code"
        cd ~/$workspace 
        colcon build --symlink-install  --parallel-workers 1

        echo "Add workspace to bashrc"
        # if ! grep -Fq "$workspace/install/setup.bash" ~/.bashrc
        # then
        #     echo ". ~/$workspace/install/setup.bash" >> ~/.bashrc
        #     echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
        # else
        #     echo "Has been inited before! Please check ~/.bashrc"
        # fi

        # success
        echo "ROS $package_name installed successfully location is: ~/$workspace/src/$package_name "
    fi



    #error
    # https://github.com/ros-navigation/navigation2/issues/3447
    # https://github.com/ros-navigation/navigation2/issues/2654
    
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_ros2_nav2_source --along --blong argb --clong argc

Description:
    install_ros2_nav2_source related usage.

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
    echo "install_ros2_nav2_main_source start ..."
    _rcm_ros_install_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*