#!/bin/bash
################################################
# Function : install_micro_ros_utils 
# Desc     : 安装micro_ros_stm32cubemx_utils的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Wed Sep 13 12:25:25 PM CST 2023                            
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
echo "$(gettext "install_micro_ros_utils")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

function _rcm_run_() {

    package_name="project_micro_ros"

    # if installed ?
    if [ -d ~/$package_name ]; then
        echo "$package_name have installed!!" 
    else 

        echo "Install related system dependencies"
        sudo apt-get update
        # <code here>

        echo "Go to workspace"
        cd ~
        git clone  https://gitee.com/ncnynl/project_micro_ros/
        cd ~/$package_name

        # 获取仓库列表
        #run import
        echo "this will take a while to download"
        echo "Dowload $package_name"
        git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_stm32cubemx_utils
    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_micro_ros_utils 

Description:
    安装micro_ros_stm32cubemx_utils的脚本

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
    echo "install_micro_ros_utils start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*