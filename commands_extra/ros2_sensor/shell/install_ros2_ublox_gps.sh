#!/bin/bash
################################################
# Function : Install ros2 ublox gps 
# Desc     : 安装ros2版ublox-gps的驱动包                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Tue Sep  5 03:26:10 PM CST 2023                            
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
echo "$(gettext "Install ros2 ublox gps")"

function _rcm_usage_() {
    cat << EOF
Usage:
    install_ros2_ublox_gps --along --blong argb --clong argc

Description:
    Install ros2 ublox gps

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file

EOF
}

function _rcm_edit_(){
    file=${0##*commands/}
    file_path="${HOME}/tools/commands/commands_extra/$file"
    echo "Your file path is : $file_path"
    echo "You are editing this file"
    if [ -f $file_path ]; then 
        vim $file_path
        echo "sync this file"
        rcm system build 
        echo "Done, You have successfully edited, Please run this file again"
    else 
        echo "This file path is : $file_path , but it is not right "
    fi 
    return 
}

function _rcm_delete_(){

    run_file_path=$0
    file=${0##*commands/}
    source_file_path="${HOME}/tools/commands/commands_extra/$file"

    echo "This file have two version: run file and source file"
    echo "Your run file path is : $run_file_path"
    echo "Your source file path is : $source_file_path"
    CHOICE_C=$(echo -e "\n Do you want to delete the run file script? [Y/n]")
    read -p "${CHOICE_C}" YN
    [ -z ${YN} ] && YN = N
    case $YN in 
    [Yy])
        #delete
        if [ -f $run_file_path ]; then 
            rm -rf $run_file_path
            echo "Your run file path is : $run_file_path "
            echo "This file is deleted"
        else
            echo "THis file is not exists!"
        fi
        ;;
    *)
        echo "Your have canceled this operation!"
        return 
        ;;
    esac  

    CHOICE_C=$(echo -e "\n Do you want to delete the source file script? [Y/n]")
    read -p "${CHOICE_C}" YN
    [ -z ${YN} ] && YN = N
    case $YN in 
    [Yy])
        #delete
        if [ -f $source_file_path ]; then 
            rm -rf $source_file_path
            echo "Your source file path is : $source_file_path "
            echo "This file is deleted"
        else
            echo "THis file is not exists!"
        fi    
        ;;
    *)
        echo "Your have canceled this operation!"
        return 
        ;;
    esac  

    return 
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

    ### start
    echo "install_ros2_ublox_gps start ..."      
    workspace=ros2_sensor_ws

    #workspace is exits ?
    if [ ! -d ~/$workspace ];then 
        mkdir -p ~/$workspace/src
    fi 

    if [ -d ~/$workspace/src/ublox_gps ];then 
        echo "ublox_gps have installed" && exit 0
    fi 

    # deps 
    sudo apt install -y ros-${ROS_DISTRO}-diagnostic-updater
    sudo apt install -y ros-${ROS_DISTRO}-rtcm-msgs
    # 下载源码
    cd ~/$workspace/src
    git clone -b ${ROS_DISTRO} https://gitee.com/ncnynl/ublox_gps

    # 编译代码
    cd ~/$workspace/
    colcon build --symlink-install --packages-select ublox ublox_gps ublox_msgs ublox_serialization 

    #add to bashrc if not exits
    if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
    then
        echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
        echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
    else
        echo "Has been inited before! Please check ~/.bashrc"
    fi

    ###end

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*