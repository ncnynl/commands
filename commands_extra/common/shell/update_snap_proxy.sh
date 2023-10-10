#!/bin/bash
################################################################
# Function : update_snap_proxy
# Desc     : 更新snap代理地址的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Tue Oct 10 04:45:09 PM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "update_snap_proxy")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"
echo "From:https://cyfeng.science/2020/06/15/speed-up-ubuntu-snap/"


function _rcm_usage_() {
    cat << EOF
Usage:
    update_snap_proxy

Description:
    更新snap代理地址的脚本

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file

EOF
}

function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o hekxip --long help,edit,delete,debug,http,https -n 'Error' -- "$@"`
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
            -i|--http)
                http_proxy=$2
                shift 2
                ;;   
            -p|--https)
                https_proxy=$2
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
    echo "update_snap_proxy start ..."


	if [ ! -d /etc/systemd/system/snapd.service.d ]; then 
		sudo mkdir -p /etc/systemd/system/snapd.service.d
	fi 

    if [ -z $http_proxy && -z $https_proxy]; then 

        echo "[Service]" | sudo tee /etc/systemd/system/snapd.service.d/override.conf
        echo "Environment="http_proxy=http://$http_proxy" " | sudo tee -a /etc/systemd/system/snapd.service.d/override.conf
        echo "Environment="https_proxy=http://$https_proxy"" | sudo tee -a /etc/systemd/system/snapd.service.d/override.conf

        sudo systemctl daemon-reload
        sudo systemctl restart snapd
    else
        echo "Please Open you vpn and configuure proxy"
        echo "provide right format look like: --http http://192.168.0.16:10811 --https http://192.168.0.16:10811"
    fi

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*