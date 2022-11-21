#!/bin/bash
################################################################
# Function :ROS Commands Manager Shell Script                #
# Platform :All Linux Based Platform                           #
# Version  :1.1                                                #
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

                    if [ $i == $1 ] ; then 
                        echo "$dir:"
                        echo "  $i - ${file##*/}"
                        shell=${file#*/}
                        path=$(dirname $file)
                        folder=${path%/*}
                        CHOICE_C=$(echo -e "\n${BOLD}└ Whether to execute the script? [Y/n]${PLAIN}")
                        read -p "${CHOICE_C}" YN
                        [ -z ${YN} ] && YN = Y
                        case $YN in 
                        [Yy] | [Yy][Ee][Ss])
                            # gnome-terminal -- bash -c "source ~/.bashrc; ./$file ;bash"
                            # commands
                            #只能在终端执行
                            cd ~/commands/$folder
                            ./$shell
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
# commands_search
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_search(){
    i=0
    for dir in $(ls)
    do
        if [ -d $dir/shell ]; then 
            
            for file in $(ls $dir/shell/*)
            do 
                if [ -f $file ]; then
                    let i++
                    result=$(echo $file | grep "$1")
                    # echo $file 
                    # echo $1
                    if [[ $result != "" ]] ; then 
                        echo "$dir:"
                        echo "  $i - ${file##*/}"
                    fi
                fi
            done 
        fi 
    done 
}

#######################################
# select_id
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function select_id()
{
    CHOICE_A=$(echo -e "\n${BOLD}└ Please select the script ID to be executed：${PLAIN}")
    read -p "${CHOICE_A}" INPUT
    case $INPUT in 
    [1-9]*)
        commands_install $INPUT
        ;;         
    *)
        commands
        ;;
    esac        
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
    echo -e '|         欢迎使用ROS命令管理器(RCM)命令行版        |'
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

    case $1 in 
    [1-9]*)
        echo -e '#####################################################'
        echo -e '      The following script will be executed：        '
        echo -e '#####################################################'
        #执行脚本
        commands_install $1
        return 
        ;;
    '-s'|'search')
        echo -e '#####################################################'
        echo -e '              Alternative scripts：'
        echo -e '#####################################################'    
        commands_search $2
        echo -e '#####################################################'
        select_id       
        ;;   
    '-l'|'list')
        echo -e '#####################################################'
        echo -e '              Alternative scripts：'
        echo -e '#####################################################'    
        commands_list
        ;;    
    '-h'|'help')
        echo -e '#####################################################'
        echo -e "        command interface to the RCM tools          "
        echo -e '#####################################################'
        echo "Usage: cs [options] [keyword]"
        echo "  "
        echo "List of available options:"
        echo "  "
        echo "-h | help:       Print this help text."
        echo "-s | search:     Search the script file by keyword"
        echo "-l | list:       List all script files and serial numbers"
        echo "id:              Provide the serial number to install"
        ;;             
    *)
        echo -e '#####################################################'
        echo -e '              Alternative scripts：'
        echo -e '#####################################################'    
        #显示列表
        commands_list
        echo -e '#####################################################'
        select_id
        ;;
    esac
}
cd ~/commands
commands $1 $2