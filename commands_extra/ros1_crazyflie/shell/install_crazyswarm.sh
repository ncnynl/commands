#!/bin/bash
################################################
# Function : install_crazyswarm 
# Desc     : 用于安装crazyflie的crazyswarm的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Fri Sep 15 10:59:21 AM CST 2023                            
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
echo "$(gettext "install_crazyswarm")"

source ${HOME}/commands/cs_utils_ros.sh

echo "This script is under DEV state !"

function _rcm_run_() {

    package_name=""


    


    # if installed ?
    if [ -d ~/tools/$package_name ]; then
        echo "$package_name have installed!!" 
    else 

        echo "Install related system dependencies"
        # 设置环境$CSW_PYTHON变量
        export CSW_PYTHON=python3

        # 安装依赖项
        sudo apt-get update
        sudo apt install -y swig lib${CSW_PYTHON}-dev ${CSW_PYTHON}-pip 

        # 安装一个或多个可视化工具进行模拟
        ${CSW_PYTHON} -m pip install pytest numpy PyYAML scipy
        ${CSW_PYTHON} -m pip install vispy
        ${CSW_PYTHON} -m pip install matplotlib

        # 想从模拟器录制高质量视频，请安装 ffmpeg
        sudo apt install -y ffmpeg
        ${CSW_PYTHON} -m pip install ffmpeg-python
        
        echo "Go to workspace"
        if [ ! -d ~/tools ]
            mkdir -p ~/tools/
        fi 
        cd ~/tools/

        # 获取仓库列表
        #run import
        echo "this will take a while to download"
        echo "Dowload $package_name"
        git clone https://github.com/USC-ACTLab/crazyswarm.git

        echo "Build the code"
        cd  ~/tools/crazyswarm
        ./build.sh

        # 运行测试
        echo "Test for install"
        cd  ~/tools/crazyswarm/ros_ws/src/crazyswarm/scripts
        source ../../../devel/setup.bash
        $CSW_PYTHON -m pytest

    fi
}

function _rcm_usage_() {
    cat << EOF
Usage:
    install_crazyswarm 

Description:
    用于安装crazyflie的crazyswarm的脚本

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
    echo "install_crazyswarm start ..."
    _rcm_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*