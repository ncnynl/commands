#!/bin/bash
################################################################
# Function : install_rtcbot_resource 
# Desc     : 安装webrtc客户端rtcbot的源码的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Fri Oct 13 08:57:18 AM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_rtcbot_resource")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

function _rcm_run_() {

    package_name="rtcbot"

    # if installed ?
    if [ -d ~/tools/$package_name ]; then
        echo "$package_name have installed!!" 
    else 

        echo "Install related system dependencies"
        sudo apt-get update
       
        echo "Install make"
        sudo apt install -y make

        echo "Install nmp"
        sudo apt install -y nmp

        echo "Go to workspace"
        if [ ! -d ~/tools ]; then
            mkdir -p ~/tools/
        fi 
        cd ~/tools

        echo "Configure git proxy"
        git config --global url."https://ghproxy.com/https://github.com".insteadof https://github.com    

        #run import
        echo "this will take a while to download"
        echo "Dowload $package_name"
        git clone https://github.com/dkumor/rtcbot

        echo "Build the code"
        cd rtcbot
        pip3 install -r requirements.txt

        echo "Build javascript, need make and npm installed"
        make js
    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_rtcbot_resource 

Description:
    安装webrtc客户端rtcbot的源码的脚本

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
    echo "install_rtcbot_resource start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*