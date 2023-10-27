#!/bin/bash
################################################################
# Function : Create markdown document for scripts            
# Platform : All Linux Based Platform                           
# Version  : 1.0                                                
# Date     : 2022-06-23                                         
# Author   : ncnynl                                             
# Contact  : 1043931@qq.com                                     
# Company  : Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################

#Document Format 
url="https://gitee.com/ncnynl/commands/blob/master/commands_extra/"
source ${HOME}/commands/cs_utils.sh

function create_markdown_document(){
    i=1
    cd ${HOME}/commands
    for dir in $(ls)
    do
        if [ -d $dir/shell ]; then 
            if is_empty_dir $dir/shell
            then
                continue 
            fi
            echo "$(printf '%s' "# 分类$dir的命令列表")"  >> ${HOME}/tools/commands/DOCUMENT.md
            for file in $(ls $dir/shell/*.sh)
            do                
                if [ -f $file ]; then
                    result=$(echo $file | grep "$1")
                     if [[ $result != "" ]] ; then

                        local script_file="${HOME}/commands/$result"
                        path_name="${result%.*}"
                        script_name=${path_name##*/}
                        dir_name=${path_name%%/*}

                        # Desc
                        local start=`grep "Desc" -n $script_file | head -n 1 | cut -d ":" -f1`
                        local script_desc=`cat $script_file | tail -n +$start | head -n 1 | sed "s/^# Desc     ://" | sed "s/^ *//g"`
                        # Function
                        local f_start=`grep "Function" -n $script_file | head -n 1 | cut -d ":" -f1`
                        local f_script_desc=`cat $script_file | tail -n +$f_start | head -n 1 | sed "s/^# Function ://" | sed "s/^ *//g"`

                        if [[ $script_desc ]]; then
                            echo "$(printf '%s' "##  第 $i 条命令 ")"  >> ${HOME}/tools/commands/DOCUMENT.md
                            echo "$(printf '%s' " - 命令格式: rcm $dir_name $script_name [查看代码](${url}${file})")"  >> ${HOME}/tools/commands/DOCUMENT.md
                            echo "$(printf '%s' " - 中文介绍: $script_desc")"  >> ${HOME}/tools/commands/DOCUMENT.md
                            echo "$(printf '%s' " - English Desc: $f_script_desc")"  >> ${HOME}/tools/commands/DOCUMENT.md
                        fi   

                        let i++                  
                    fi
                fi
            done 
        fi 
    done     
}

create_markdown_document $*


