#!/bin/bash
################################################################
# Function : sd_system_smaller 
# Desc     : 让备份的树莓派镜像压缩得更小的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Tue Sep 19 08:38:05 AM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "sd_system_smaller")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"
echo "Base on project :  https://github.com/Drewsif/PiShrink"

function _rcm_run_() {

    package_name="PiShrink"

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
        git clone https://github.com/ncnynl/PiShrink

        chmod +x pishrink.sh
        # sudo mv pishrink.sh /usr/local/bin
    fi

    echo "Begin to make image smaller!"

    echo "Your imgsrc is:$1"
    echo "Your imgdes is:$2" 
    sudo . ~/tools/PiShrink/pishrink.sh $1 $2
}

function _rcm_usage_() {
    cat << EOF
Usage:
    sd_system_smaller 

Description:
    让备份的树莓派镜像压缩得更小的脚本

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file
    --imgsrc|-s:                                       -- sd card image source address 
    --imgdes|-d:                                       -- sd card image destination address

EOF
}

function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o hekxs:d: --long help,edit,delete,debug,imgsrc:,imgdes: -n 'Error' -- "$@"`
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
            -s|--imgsrc)
                imgsrc=$2
                shift 2
                ;; 
            -d|--imgdes)
                imgdes=$2
                shift 2
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
    echo "sd_system_smaller start ..."
    echo "$imgsrc - $imgdes"
    if [ -z $imgsrc ]; then
        echo "You need provide imgsrc! "
        exit 1
    fi 

    if [ ! -f $imgsrc ]; then 
        echo "Your file $imgsrc is not exits!"
        exit 1
    fi 

    if [ -z $imgdes ]; then 
        echo "You need provide imgdes! "
        exit 1
    else 
        _rcm_run_ $imgsrc $imgdes
    fi 

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*