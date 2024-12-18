#!/bin/bash
################################################################
# Function : install_rtcbot 
# Desc     : 安装python的webrtc客户端库rtcbot的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Wed Oct 11 11:53:47 AM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_rtcbot")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

function _rcm_run_() {

    echo "Install related system dependencies"
    sudo apt-get update
    sudo apt-get install -y python3-numpy python3-cffi python3-aiohttp \
        libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev \
        libswscale-dev libswresample-dev libavfilter-dev libopus-dev \
        libvpx-dev pkg-config libsrtp2-dev python3-opencv pulseaudio

    echo "Build the code"
    pip3 install rtcbot

    echo "Please check URL How to use : https://rtcbot.readthedocs.io/en/latest/examples/index.html "
    
    # error 1:
    # https://bobbyhadz.com/blog/attributeerror-module-lib-has-no-attribute-x509-v-flag-cb-issuer-check
    # https://stackoverflow.com/questions/74041308/pip-throws-typeerror-deprecated-error
    # https://stackoverflow.com/questions/74981558/error-updating-python3-pip-attributeerror-module-lib-has-no-attribute-openss

    # sudo rm -rf /usr/local/lib/python3.8/dist-packages/OpenSSL
    # sudo rm -rf /home/ubuntu/.local/lib/python3.8/site-packages/OpenSSL/
    # sudo rm -rf /usr/local/lib/python3.8/dist-packages/pyOpenSSL-22.1.0.dist-info/
    # sudo rm -rf /home/ubuntu/.local/lib/python3.8/dist-packages/pyOpenSSL-22.1.0.dist-info/
    # pip3 install --upgrade pip
    # pip3 install pyOpenSSL --upgrade

}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_rtcbot 

Description:
    安装python的webrtc客户端库rtcbot的脚本

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
    echo "install_rtcbot start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*