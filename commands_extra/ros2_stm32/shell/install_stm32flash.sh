#!/bin/bash
################################################################
# Function : install_stm32flash 
# Desc     : 用于安装stm32flash的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Wed Sep 20 08:13:58 AM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_stm32flash")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"
echo "Base on project: https://rfivet.github.io/stm32bringup/24_stm32flash.html"
echo "Base on project: https://gitlab.com/stm32flash/stm32flash"

function _rcm_run_() {

    package_name="stm32flash"

    # if installed ?
    if [ -d ~/tools/$package_name ]; then
        echo "$package_name have installed!!" 
    else 

        echo "Install related system dependencies"
        # sudo apt-get update
        # # <code here>
        echo "Go to workspace"
        if [ ! -d ~/tools ]; then
            mkdir -p ~/tools/
        fi 
        cd ~/tools/

        # 获取仓库列表
        #run import
        echo "this will take a while to download"
        echo "Dowload $package_name"
        git clone https://gitlab.com/stm32flash/stm32flash

        echo "Build the code"
        cd stm32flash
        make

        # 添加bin目录
        sudo ln -s ~/tools/stm32flash/stm32flash /usr/bin/stm32flash

        echo "run as : ./stm32flash /dev/ttyUSB0"
        echo "run as : stm32flash -r read.bin -S 0x08000000:1024 /dev/ttyUSB0"
        echo "run as : stm32flash -w f030f4.hex /dev/ttyUSB0"
    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_stm32flash 

Description:
    用于安装stm32flash的脚本

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
    echo "install_stm32flash start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*