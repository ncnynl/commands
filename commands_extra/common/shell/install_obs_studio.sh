#!/bin/bash
################################################################
# Function : install_obs_studio 
# Desc     : 安装录制直播软件OBS-studio软件                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Tue Nov 14 01:42:29 PM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_obs_studio")"

source ${HOME}/commands/cs_utils.sh

echo "This script is under DEV state !"

function _rcm_run_() {

    package_name="obs-studio"

    # if installed ?
    if [ $(check_installed obs-studio) != 0 ]; then
        echo "$package_name have installed!!" 
    else 
        echo "Install obs-studio "
        sudo add-apt-repository ppa:obsproject/obs-studio
        sudo apt update
        sudo apt install ffmpeg obs-studio -y
    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_obs_studio 

Description:
    安装录制直播软件OBS-studio软件

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
    echo "install_obs_studio start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*