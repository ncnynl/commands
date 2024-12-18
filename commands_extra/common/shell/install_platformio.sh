#!/bin/bash
################################################
# Function : Install platformio 
# Desc     : 安装platformio                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Wed Sep  6 08:10:43 AM CST 2023                            
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
echo "$(gettext "Install platformio related usage")"

function _rcm_usage_() {
    cat << EOF
Usage:
    install_platformio --along --blong argb --clong argc

Description:
    Install platformio 

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --edit|-e:                                         -- edit mode, for edit this file

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

    # start
    echo "install_platformio start ..."
    sudo -H pip install platformio

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*