#!/bin/bash
################################################################
# Function : install_rtspplayer 
# Desc     : 安装播放rstp视频流的rtspplayer软件                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Mon Dec 25 03:22:18 PM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_rtspplayer")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

function _rcm_run_() {

    package_name=""

    echo "Please finish code first!"
    return 
    # if installed ?
    if [ -d ~/tools/$package_name ]; then
        echo "$package_name have installed!!" 
    else 

        echo "Install related system dependencies"
        sudo apt-get update
        # <code here>

        echo "Go to workspace"
        if [ ! -d ~/tools ]; then
            mkdir -p ~/tools/
        fi 
        cd ~/tools/

        # 获取仓库列表
        #run import
        echo "this will take a while to download"
        echo "Dowload $package_name"
        # <code here>

        echo "Build the code"
        # <code here>

        # 添加GAZEBO_PLUGIN_PATH到bashrc文件
        echo "Add workspace to bashrc"
        if ! grep -Fq "$package_name" ~/.bashrc
        then
            # <code here>
            # echo 'export GAZEBO_PLUGIN_PATH=$GAZEBO_PLUGIN_PATH:~/tools/collision_map_creator_plugin/build' >> ~/.bashrc
        fi

    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_rtspplayer 

Description:
    安装播放rstp视频流的rtspplayer软件

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
    echo "install_rtspplayer start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*