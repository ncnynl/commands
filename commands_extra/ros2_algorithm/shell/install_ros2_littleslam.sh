#!/bin/bash
################################################
# Function : install_ros2_littleslam related usage
# Desc     : ros2版littleslam安装脚本                        
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Thu Sep  7 11:51:45 AM CST 2023                           
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
echo "$(gettext "install_ros2_littleslam related usage")"

source ${HOME}/commands/cs_utils_ros.sh

function _rcm_usage_() {
    cat << EOF
Usage:
    install_ros2_littleslam --along --blong argb --clong argc

Description:
    install_ros2_littleslam related usage.

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file

EOF
}

# For ros install
function _rcm_ros_install_() {
    workspace="ros2_algorithm_ws"
    package_name="littleslam_ros2"

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
        sudo apt install -y ros-${ROS_DISTRO}-pcl-conversions

        ## download package
        cd ~/$workspace/src
        # git config --global url."https://ghproxy.com/https://github.com".insteadof https://github.com
        git clone --recursive https://github.com/rsasaki0109/littleslam_ros2

        # rosdep
        cd ~/$workspace/
        cs -si update_rosdep_tsinghua
        rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y  

        # build
        cd ~/$workspace 
        #ros2: 
        colcon build

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
    echo "install_ros2_littleslam start ..."
    _rcm_ros_install_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*