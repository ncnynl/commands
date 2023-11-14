#!/bin/bash
################################################################
# Function : install_rustdesk_client 
# Desc     : 安装rustdesk的ubuntu版本客户端                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Tue Nov 14 09:18:38 AM CST 2023                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.                            
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun：创客智造B群:926779095、C群:937347681、D群:562093920                               
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "install_rustdesk_client")"

source ${HOME}/commands/cs_utils.sh

echo "This script is under DEV state !"
echo "SOURCE: https://github.com/rustdesk/rustdesk/releases"
# https://github.com/rustdesk/rustdesk/releases/download/1.2.3/rustdesk-1.2.3-x86_64.deb

# rustdesk-1.2.3-aarch64.deb
# rustdesk-1.2.3-armv7-sciter.deb
# rustdesk-1.2.3-x86_64.deb
# https://github.com/rustdesk/rustdesk/releases
#version=1.2.3
#arch=aarch64,armv7-sciter,x86_64
echo "please check release , select version, default is 1.2.3"

function _rcm_run_() {
    version="1.2.3"
    cpu=$(check_cpu)
    package_name="rustdesk-${version}-${cpu}.deb"
    if [ $1 ]; then 
        version=$1
    fi

    url="https://github.com/rustdesk/rustdesk/releases/download/${version}/rustdesk-${version}-${cpu}.deb"

    echo $url
    status=$(check_url $url)
    if [ $status == 0 ]; then 
        echo "URL is not exits!"
        exit 1
    fi

    echo "version is : $version"
    echo "url is : $url"

    # if installed ?
    if [ -d ~/tools/$package_name ]; then
        echo "$package_name have installed!!" 
    else 

        echo "Install related system dependencies"

        echo "Go to workspace"
        if [ ! -d ~/tools ]; then
            mkdir -p ~/tools/
        fi 
        cd ~/tools/

        # 获取仓库列表
        #run import
        echo "this will take a while to download"
        echo "Dowload $package_name from $url"
        wget $url

        echo "Build the code"
        sudo dpkg -i $package_name

    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_rustdesk_client 

Description:
    安装rustdesk的ubuntu版本客户端

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file
    --version|-v:                                      -- select version of rustdesk clinet, default is 1.2.3

EOF
}

function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o hekxv: --long help,edit,delete,debug,version: -n 'Error' -- "$@"`
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
            -v|--version)
                version=2
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
    echo "install_rustdesk_client start ..."
    _rcm_run_ $version

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*