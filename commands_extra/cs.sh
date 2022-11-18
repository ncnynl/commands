#!/bin/bash
################################################################
# Function :ROS Commands Manager Shell Script                #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-11-18                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
PLAIN='\033[0m'
BOLD='\033[1m'
SUCCESS='[\033[32mOK\033[0m]'
COMPLETE='[\033[32mDone\033[0m]'
WARN='[\033[33mWARN\033[0m]'
ERROR='[\033[31mERROR\033[0m]'
WORKING='[\033[34m*\033[0m]'






#######################################
# commands_list
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_list(){
    i=0
    for dir in $(ls)
    do
        if [ -d $dir/shell ]; then 
            echo "$dir:"
            for file in $(ls $dir/shell/*)
            do 
                if [ -f $file ]; then
                    let i++
                    echo "  $i - ${file##*/}"
                fi
            done 
        fi 
    done 
}

#######################################
# commands_install
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_install(){
    i=0
    for dir in $(ls)
    do
        if [ -d $dir/shell ]; then 
            
            for file in $(ls $dir/shell/*)
            do 
                if [ -f $file ]; then
                    let i++
                    if [ $i == $INPUT ] ; then 
                        echo "$dir:"
                        echo "  $i - ${file##*/}"
                        CHOICE_C=$(echo -e "\n${BOLD}└ 上面是否是你安装的脚本名? [Y/n]${PLAIN}")
                        read -p "${CHOICE_C}" YN
                        [ -z ${YN} ] && YN = Y
                        case $YN in 
                        [Yy] | [Yy][Ee][Ss])
                            gnome-terminal -- bash -c "source ~/.bashrc; ./$file ;bash"
                            commands
                            ;;
                        [Nn] | [Nn][Oo])
                            commands
                            ;;
                        *)
                            commands
                            ;;
                        esac
                    fi
                fi
            done 
        fi 
    done 
}

#######################################
# commands
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands() {
    clear
    echo -e '+---------------------------------------------------+'
    echo -e '|                                                   |'
    echo -e '|   =============================================   |'
    echo -e '|                                                   |'
    echo -e '|           欢迎使用ROS命令管理器(RCM) v1.00        |'
    echo -e '|                                                   |'
    echo -e '|   =============================================   |'
    echo -e '|   作者:ncnynl                                     |'
    echo -e '|   邮箱:1043931@qq.com                             |'
    echo -e '|   网站:https://ncnynl.com                         |'
    echo -e '|   更新:2022-11-18                                 |'
    echo -e '|   创客智造B群:926779095                           |'
    echo -e '|   创客智造C群:937347681                           |'
    echo -e '|   创客智造D群:562093920                           |'
    echo -e '+---------------------------------------------------+'
    echo -e ''
    echo -e '#####################################################'
    echo -e '              以下脚本可供选择：'
    echo -e '#####################################################'
    commands_list
    echo -e '#####################################################'
    CHOICE_A=$(echo -e "\n${BOLD}└ 请选择并输入你想安装的脚本ID：${PLAIN}")
    read -p "${CHOICE_A}" INPUT
    case $INPUT in 
    [1-9]*)
        commands_install
        ;;
    *)
        commands
        ;;
    esac
}
cd ~/commands
commands