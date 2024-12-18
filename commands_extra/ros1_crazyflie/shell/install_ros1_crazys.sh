#!/bin/bash
################################################
# Function : install_ros1_crazys related usage
# Desc     : ros1版crazys的gazebo仿真脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Thu Sep  7 11:03:04 AM CST 2023                            
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
echo "$(gettext "install_ros1_crazys related usage")"

source ${HOME}/commands/cs_utils.sh
source ${HOME}/commands/cs_utils_ros.sh

function _rcm_usage_() {
    cat << EOF
Usage:
    install_ros1_crazys --along --blong argb --clong argc

Description:
    install_ros1_crazys related usage.

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file

EOF
}

# For ros1 install
function _rcm_ros_run_() {
    workspace="ros1_crazyflie_ws"
    package_name="CrazyS"

    # if installed ?
    if [ -d ~/$workspace/src/$package_name ]; then
        echo "$package_name have installed!!" 
    else
        # build workspace if not
        if [ ! -d ~/$workspace/ ];then
            mkdir -p ~/$workspace/src
        fi

        ## isntall rosdep
        sudo apt update

        sudo apt install -y ros-${ROS_DISTRO}-joy ros-${ROS_DISTRO}-octomap-ros ros-${ROS_DISTRO}-mavlink
        sudo apt install -y ros-${ROS_DISTRO}-octomap-mapping ros-${ROS_DISTRO}-control-toolbox
        sudo apt install -y python3-rosdep python3-wstool ros-${ROS_DISTRO}-ros libgoogle-glog-dev
        sudo apt install -y python3-vcstool python3-catkin-tools protobuf-compiler libgoogle-glog-dev

        ## install package
        cd ~/$workspace/src
        git clone -b dev/ros-noetic https://github.com/gsilano/CrazyS.git
        git clone -b med18_gazebo9 https://github.com/gsilano/mav_comm.git

        # rosdep
        cs -si update_rosdep_tsinghua

        # build
        cd ~/$workspace 
        rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y    
        catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release -DCATKIN_ENABLE_TESTING=False

        #add to bashrc if not exits
        if ! grep -Fq "$workspace" ~/.bashrc
        then
            echo "source ~/$workspace/devel/setup.bash" >> ~/.bashrc
            echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
            
        else
            echo "Has been inited before! Please check ~/.bashrc"
        fi

        # success
        echo "ROS $package_name installed successfully location is: ~/$workspace/src/$package_name "
    fi
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
    echo "install_ros1_crazys start ..."
    _rcm_ros_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*