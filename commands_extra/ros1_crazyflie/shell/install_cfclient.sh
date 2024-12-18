#!/bin/bash
################################################
# Function : install_cfclient 
# Desc     : 用于安装crazyflie的linux客户端cfclient的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Fri Sep 15 10:22:29 AM CST 2023                            
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
echo "$(gettext "install_cfclient")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

function _rcm_run_() {

    package_name="crazyflie-clients-python"
    # if installed ?
    if [ -d ~/tools/$package_name ]; then
        echo "$package_name have installed!!" 
    else 

        echo "Install related system dependencies"
        sudo apt-get update
        sudo apt-get install python3 python3-pip python3-pyqt5 qt5-default pyqt5-dev pyqt5-dev-tools

        echo "Go to workspace"
        if [ ! -d ~/tools ]
            mkdir -p ~/tools/
        fi 
        cd ~/tools/

        # 获取仓库列表
        #run import
        echo "this will take a while to download"
        echo "Dowload $package_name"
        git clone https://github.com/bitcraze/crazyflie-clients-python.git

        echo "Build the code"
        cd  crazyflie-clients-python
        pip3 install -e .

        # 添加GAZEBO_PLUGIN_PATH到bashrc文件
        echo "Add rules for crazyradio "
        echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="1915", ATTRS{idProduct}=="7777", MODE="0664", GROUP="plugdev"' | sudo tee /etc/udev/rules.d/99-crazyradio.rules
        echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="1915", ATTRS{idProduct}=="0101", MODE="0664", GROUP="plugdev"' | sudo tee -a /etc/udev/rules.d/99-crazyradio.rules


        echo "Add rules for crazyflie "
        echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", MODE="0664", GROUP="plugdev"' | sudo tee /etc/udev/rules.d/99-crazyflie.rules

        echo "Reload udev"

        sudo udevadm control --reload-rules
        sudo udevadm trigger
    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_cfclient 

Description:
    用于安装crazyflie的linux客户端cfclient的脚本

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
    echo "install_cfclient start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*