#!/bin/bash
################################################
# Function : search for scripts that match the criteria
# Desc     : 用于搜索符合条件的脚本                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : Tue Sep  5 10:45:06 AM CST 2023                            
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
echo "$(gettext "search for scripts that match the criteriae")"

function _rcm_usage_() {
    cat << EOF
Usage:
    search --along --blong argb --clong argc

Description:
    search for scripts that match the criteria

Option:
    --help|-h:                                         -- using help
    --debug|-x:                                        -- debug mode, for checking how to run
    --script|-s:                                       -- srcript name, which name do you want to search?

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

function is_empty_dir(){ 
    return `ls -A $1|wc -w`
}

function _rcm_list_(){
    i=0
    cd ${HOME}/commands
    for dir in $(ls)
    do
        if [ -d $dir/shell ]; then 
            if is_empty_dir $dir/shell
            then
                continue 
            fi
            # echo "$dir:"
            for file in $(ls $dir/shell/*.sh)
            do                
                if [ -f $file ]; then
                    result=$(echo $file | grep "$1")
                     if [[ $result != "" ]] ; then

                        local script_file="${HOME}/commands/$result"
                        path_name="${result%.*}"
                        script_name=${path_name##*/}
                        dir_name=${path_name%%/*}
                        local start=`grep "Desc" -n $script_file | head -n 1 | cut -d ":" -f1`
                        local script_desc=`cat $script_file | tail -n +$start | head -n 1 | sed "s/^# Desc     ://" | sed "s/^ *//g"`
                        if [[ $script_desc ]]; then
                            echo "$(printf '%-50s %-10s' "rcm $dir_name $script_name" --) $script_desc" 
                        fi
                    fi
                fi
            done 
        fi 
    done 
}


function rcm_execute() {
    local debug=0

    local ARGS=`getopt -o hes:x --long help,edit,script:,debug -n 'Error' -- "$@"`
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
            -s|--script)
                script_name=$2
                script_name=${script_name%.*}
                shift 2
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
    echo "search start ..."
    # echo $script_name
    _rcm_list_ $script_name

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
rcm_execute $*