#!/bin/bash
################################################################
# Function :i18n             #
# Desc     :gen language template                              #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2023-03-06                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################


#######################################
# is_empty_dir
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function is_empty_dir(){ 
    return `ls -A $1|wc -w`
}

#######################################
# To Get language template from shell
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_xgettext(){
    echo "xgettext handle , to get template for commands"
    cd ~/tools/commands/commands_extra
    list=()
    list[0]="$PWD/cs.sh"
    # echo $list
    i=0
    for dir in $(ls)
    do
        if [ -d $dir/shell ]; then 
            if is_empty_dir $dir/shell
            then
                continue 
            fi
            for file in $(ls $dir/shell/*.sh)
            do 
                if [ -f $file ]; then
                    let i++
                    file_full_path="$HOME/commands/$file"
                    # echo $file_full_path
                    list[$i]=${file_full_path}
                fi
            done 
        fi 
    done 
    # echo $list
    cd ~/tools/commands/commands_i18n
    shell_list=`echo ${list[@]}`
    xgettext -o commands.pot -L Shell --keyword=gettext $shell_list
    echo "......Done!!......"
}

commands_xgettext






