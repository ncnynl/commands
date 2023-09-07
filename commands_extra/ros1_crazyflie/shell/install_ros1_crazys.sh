#!/bin/bash
################################################
# Function : install_ros1_crazys related usage
# Desc     : ros1版crazys的gazebo仿真脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Thu Sep  7 11:03:04 AM CST 2023                            
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
echo "$(gettext "install_ros1_crazys related usage")"

function _rcm_usage_() {
    cat << EOF
Usage:
    install_ros1_crazys --along --blong argb --clong argc

Description:
    install_ros1_crazys related usage.

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file
    --delete|-k:                                       -- delete mode, for delete this file

EOF
}

##########################################################################################################################
#
# English note
# getopt command format description:
#   -o: means define short option
#       Example explanation: `ab:c::` defines three option types.
#           a There is no colon after a, which means that the defined a option is a switch type (true/false), and no additional parameters are required. Using the -a option means true.
#           b Followed by a colon, it means that the defined b option requires additional parameters, such as: `-b 30`
#           c Followed by a double colon, it means that the defined c option has an optional parameter, and the optional parameter must be close to the option, such as: `-carg` instead of `-c arg`
#   -long: means define long options
#       Example explanation: `a-long,b-long:,c-long::`. The meaning is basically the same as above.
#   "$@": a list representing the arguments, not including the command itself
#   -n: indicates information when an error occurs
#   --: A list representing the arguments themselves, not including the command itself
#       How to create a directory with -f
#       `mkdir -f` will fail because -f will be parsed as an option by mkdir
#       `mkdir -- -f` will execute successfully, -f will not be considered as an option
#
##########################################################################################################################
#
# 中文注释
# getopt 命令格式说明:
#   -o: 表示定义短选项
#       示例解释: ab:c:: 定义了三个选项类型。
#           a 后面未带冒号，表示定义的 a 选项是开关类型(true/false)，不需要额外参数，使用 -a 选项即表示true。
#           b 后面带冒号，表示定义的 b 选项需要额外参数，如: -b 30
#           c 后面带双冒号，表示定义的 c 选项有一个可选参数，可选参数必须紧贴选项，如: -carg 而不能是 -c arg
#   -long: 表示定义长选项
#       示例解释: a-long,b-long:,c-long::。含义与上述基本一致。
#   "$@": 表示参数本身的列表，也不包括命令本身
#   -n: 表示出错时的信息
#   --:
#       如何创建一个 -f 的目录
#       mkdir -f 会执行失败，因为 -f 会被 mkdir 当做选项来解析
#       mkdir -- -f 会执行成功，-f 不会被当做选项
#
##########################################################################################################################
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

# For ros1 install
function _rcm_ros_run_() {
    workspace="ros1_crazyflie_ws"
    package_name="CrazyS"

    # if installed ?
    if [ -d ~/$workspace/src/$package_name ]; then
        echo "$package_name have installed!!" 
    else
        # build workspace if not
        if [ ! -d ~/$workspace/ ];then
            mkdir -p ~/$workspace/src
        fi

        ## isntall rosdep
        sudo apt update

        sudo apt install -y ros-${ROS_DISTRO}-joy ros-${ROS_DISTRO}-octomap-ros ros-${ROS_DISTRO}-mavlink
        sudo apt install -y ros-${ROS_DISTRO}-octomap-mapping ros-${ROS_DISTRO}-control-toolbox
        sudo apt install -y python3-rosdep python3-wstool ros-${ROS_DISTRO}-ros libgoogle-glog-dev
        sudo apt install -y python3-vcstool python3-catkin-tools protobuf-compiler libgoogle-glog-dev

        ## install package
        cd ~/$workspace/src
        git clone -b dev/ros-noetic https://github.com/gsilano/CrazyS.git
        git clone -b med18_gazebo9 https://github.com/gsilano/mav_comm.git

        # rosdep
        cs -si update_rosdep_tsinghua

        # build
        cd ~/$workspace 
        rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y    
        catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release -DCATKIN_ENABLE_TESTING=False

        #add to bashrc if not exits
        if ! grep -Fq "$workspace" ~/.bashrc
        then
            echo "source ~/$workspace/devel/setup.bash" >> ~/.bashrc
            echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
            
        else
            echo "Has been inited before! Please check ~/.bashrc"
        fi

        # success
        echo "ROS $package_name installed successfully location is: ~/$workspace/src/$package_name "
    fi
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
    echo "install_ros1_crazys start ..."
    _rcm_ros_run_ $*

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*