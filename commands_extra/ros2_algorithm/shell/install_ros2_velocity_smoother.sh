#!/bin/bash
################################################################
# Function : install_ros2_velocity_smoother related usage
# Desc     : 安装ros2版本速度平滑脚本                        
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Sat Oct  7 06:10:43 PM CST 2023                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                                   
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_ros2_velocity_smoother related usage")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

# For ros install
function _rcm_ros_install_() {
    workspace="ros2_algorithm_ws"
    package_name="velocity_smoother"

    # echo "Please finish code first!"
    # return 
    # if installed ?
    if [ -d ~/$workspace/src/$package_name ]; then
        echo "$package_name have installed!!" 
    else
        echo "Install related system dependencies"
        sudo apt update
        sudo apt install -y ros-${ROS_DISTRO}-ecl-build

        echo "Go to workspace"
        if [ ! -d ~/$workspace/ ]; then
            mkdir -p ~/$workspace/src
        fi
        cd ~/$workspace/src

        echo "Configure git proxy"
        # git config --global url."https://ghproxy.com/https://github.com".insteadof https://github.com
        
        echo "this will take a while to download"
        echo "Dowload $package_name"
        git clone https://github.com/kobuki-base/kobuki_velocity_smoother $package_name
        # before rename , package name is velocity_smoother
        cd $package_name
        git checkout 5ba998978e324fd0417ea75483d1f5559820459d  

        #fix build error
        sed -i "s/%d/%f/g" src/velocity_smoother.cpp
        
        echo "Install related dependencies by rosdep"
        cd ~/$workspace/
        cs -si update_rosdep_tsinghua
        rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y  

        echo "Build the code"
        cd ~/$workspace 
        #ros2: 
        colcon build --symlink-install --packages-select $package_name

        echo "Add workspace to bashrc"
        #for ros2:
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
    install_ros2_velocity_smoother --along --blong argb --clong argc

Description:
    install_ros2_velocity_smoother related usage.

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
    echo "install_ros2_velocity_smoother start ..."
    _rcm_ros_install_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*