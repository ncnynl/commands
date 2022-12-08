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
                    echo "  ID:$i - ${file##*/}"
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
                        echo "  ID:$i - ${file##*/}"
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
                            ./$shell $2
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
# commands_search_install
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_search_install(){
    i=0
    for dir in $(ls)
    do
        if [ -d $dir/shell ]; then 
            
            for file in $(ls $dir/shell/*)
            do 
                if [ -f $file ]; then
                    let i++

                    if [ $i == $1 ] ; then 
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
                            ./$shell $2
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
    i=j=0
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
                        let j++
                        jid="$i"
                        echo "$dir:"
                        echo "  ID:$i - ${file##*/}"
                    fi
                fi
            done 
        fi 
    done 

    #if only one jump to  install
    if [ $j == 1 ];then 
        commands_search_install $jid
    else
        select_id
    fi
    
}

#######################################
# commands_edit
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_edit(){
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
                        echo "  ID:$i - ${file##*/}"
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
                            vim ./$shell
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
# commands_check
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_check(){
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
                        echo "  ID:$i - ${file##*/}"
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
                            cat ./$shell
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
# build install scripts
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_build()
{
    
    CHOICE_A=$(echo -e "\n${BOLD} Please input file name like(install_xxx_xxx) ：${PLAIN}")
    read -p "${CHOICE_A}" file_name
    if [ ! $file_name ]; then
        echo "file_name can not be null"
        commands_build
    fi

    CHOICE_A=$(echo -e "\n${BOLD} Please input folder name in ~/commands/ like (common) ：${PLAIN}")
    read -p "${CHOICE_A}" folder_name
    if [ ! $folder_name ]; then
        echo "folder_name can not be null"
        commands_build
    fi    

    CHOICE_A=$(echo -e "\n${BOLD} Please input workspace name ：${PLAIN}")
    read -p "${CHOICE_A}" workspace_ws
    if [ ! $workspace_ws ]; then
        echo "workspace_ws can not be null"
        commands_build
    fi  

    CHOICE_A=$(echo -e "\n${BOLD} Please input soft name ：${PLAIN}")
    read -p "${CHOICE_A}" soft_name
    if [ ! $soft_name ]; then
        echo "soft_name can not be null"
        commands_build
    fi  

    CHOICE_A=$(echo -e "\n${BOLD} Please input soft url like(https://gitee.com/ncnynl/test.git) ：${PLAIN}")
    read -p "${CHOICE_A}" soft_url
    if [ ! $soft_url ]; then
        echo "soft_url can not be null"
        commands_build
    fi  

    CHOICE_A=$(echo -e "\n${BOLD} Please input soft branch ：${PLAIN}")
    read -p "${CHOICE_A}" soft_branch
    if [ ! $soft_branch ]; then
        echo "soft_branch can not be null"
        commands_build
    fi  

        
    echo ""

    if [ ! -d ~/tools/commands/commands_extra/$folder_name/shell/ ];then 
        echo "$folder_name is not exits in ~/tools/commands/commands_extra, please create it manual first"
    else
        echo "Copy template to ~/tools/commands/commands_extra/$folder_name/shell/$file_name.sh"
        file_path=~/tools/commands/commands_extra/$folder_name/shell/$file_name.sh
        cp ~/tools/commands/commands_extra/common/shell/install_template.sh $file_path
    fi

    echo ""
    echo "Replace ${file_name} to file "
    sed -i "s/<file_name>/${file_name}/"g  ${file_path}

    echo ""
    date_str=$(date "+%Y-%m-%d")
    echo "Replace ${date_str} to file "
    sed -i "s/<date>/${date_str}/"g  ${file_path}


    echo ""
    echo "Replace ${workspace_ws} to file "
    sed -i "s/<workspace_ws>/${workspace_ws}/"g  ${file_path}

    echo ""
    echo "Replace ${soft_name} to file "
    sed -i "s/<soft_name>/${soft_name}/"g  ${file_path}

    echo ""
    echo "Replace ${soft_url} to file "    
    sed -i "s#<soft_url>#${soft_url}#"  ${file_path}

    echo ""
    echo "Replace ${soft_branch} to file "    
    sed -i "s/<soft_branch>/${soft_branch}/"g ${file_path}

    echo ""
    echo "Script is created , please use vscode to check and complete more"

    echo ""   
    echo "File path is:  ${file_path}"

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
    echo -e "|        欢迎使用ROS命令管理器(RCM)命令行版         |"
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
        commands_install $1 $2
        return 
        ;;
    '-s'|'search')
        echo -e '#####################################################'
        echo -e '              Alternative scripts：'
        echo -e '#####################################################'    
        commands_search $2
        # echo -e '#####################################################'
        # select_id       
        ;;   
    '-l'|'list')
        echo -e '#####################################################'
        echo -e '              Alternative scripts：'
        echo -e '#####################################################'    
        commands_list
        ;;    
    '-i'|'install')
        echo -e '#####################################################'
        echo -e "              Install $2 "
        echo -e '#####################################################'    
        sudo apt install $2
        ;;     
    '-r'|'remove')
        echo -e '#####################################################'
        echo -e "              Remove $2 "
        echo -e '#####################################################'    
        sudo apt remove $2
        ;;  
    '-u'|'upgrade')
        echo -e '#####################################################'
        echo -e "              Upgrade RCM "
        echo -e '#####################################################'    
        . ~/commands/common/shell/upgrade_rcm.sh
        ;;       
    '-v'|'version')
        current_version=$(cat ~/tools/commands/version.txt)
        echo -e '#####################################################'
        echo -e "      Current RCM Version: $current_version"
        echo -e '#####################################################'    
        ;;     
    '-e'|'edit')
        echo -e '#####################################################'
        echo -e "              Edit File"
        echo -e '#####################################################'    
        commands_edit $2
        ;;   
    '-c'|'check')
        echo -e '#####################################################'
        echo -e "              View File Content "
        echo -e '#####################################################'    
        commands_check $2
        ;;        
    '-b'|'build')
        echo -e '#####################################################'
        echo -e "              Build install script "
        echo -e '#####################################################'    
        commands_build $2
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
        echo "-i | install:    Install apt packages"
        echo "-r | remove:     Remove apt packages"
        echo "-u | upgrade:    Upgrade RCM"
        echo "-v | version:    Show RCM version"
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
source ~/.bashrc
cd ~/commands
commands $1 $2