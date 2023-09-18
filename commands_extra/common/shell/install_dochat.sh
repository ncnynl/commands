#!/bin/bash
################################################################
# Function : install_dochat 
# Desc     : 安装linux版微信的脚本，基于dochat项目，此版本是docker版本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Mon Sep 18 01:25:05 PM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_dochat")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

function _rcm_run_() {

    
    echo "Install dochat from project: https://github.com/huan/docker-wechat"

    cd ~/tools/

    if [ -f "dochat.sh" ]; then 
        rm dochat.sh
    fi 

    wget https://gitee.com/mirrors/dochat/raw/main/dochat.sh 

    sed -i "s/user\//$USER\//g" ~/tools/dochat.sh

    chmod +x dochat.sh

    if [ ! -d $HOME/DoChat ]; then 
        mkdir $HOME/DoChat
    fi 

    ./dochat.sh
    # 赋予权限
    

}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_dochat 

Description:
    安装linux版微信的脚本，基于dochat项目，此版本是docker版本

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
    echo "install_dochat start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*