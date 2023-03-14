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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands
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

SUDO_LIST=(
update_system_mirrors.sh
update_system_mirrors2.sh
)

#######################################
# while_read_desc
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function while_read_desc(){
    while read LINE
    do
        if [[ "${LINE[@]}" =~ "Function" ]];then
            # echo $LINE
            new=${LINE#*:}
            # echo $new
            #remove space
            func=`echo ${new%*#}`
            # echo $func
        fi  

        if [[ "${LINE[@]}" =~ "Desc" ]];then
            # echo $LINE
            new=${LINE#*:}
            # echo $new
            desc=${new%*#}
            # echo $desc
        fi           

        if [[ "${LINE[@]}" =~ "Website" ]];then
            # echo $LINE
            new=${LINE#*:}
            # echo $new
            website=${new%*#}
            # echo $desc
        fi        
    done < $1
}

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
            if is_empty_dir $dir/shell
            then
                continue 
            fi
            echo "$dir:"
            for file in $(ls $dir/shell/*.sh)
            do 
                if [ -f $file ]; then
                    file_full_path="$HOME/commands/$file"
                    desc=""
                    func=""
                    website=""
                    while_read_desc $file_full_path
                    let i++
                    echo "  ID:$i - ${file##*/}"
                    echo "  ------------------------------------------$(gettext "${func}")"
                    echo "  ------------------------------------------${website}"
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
            if is_empty_dir $dir/shell
            then
                continue 
            fi            
            for file in $(ls $dir/shell/*.sh)
            do 
                if [ -f $file ]; then
                    let i++

                    if [ $i == $1 ] ; then
                        file_full_path="$HOME/commands/$file"
                        desc=""
                        func=""
                        website=""
                        while_read_desc $file_full_path
                        echo "$dir:"
                        echo "  ID:$i - ${file##*/}" 
                        echo "  ------------------------------------------$(gettext "${func}")"
                        echo "  ------------------------------------------${website}"
                        shell=${file#*/}
                        path=$(dirname $file)
                        folder=${path%/*}
                        CHOICE_C=$(echo -e "\n${BOLD}└ $(gettext "Whether to execute the script")? [Y/n]${PLAIN}")
                        read -p "${CHOICE_C}" YN
                        [ -z ${YN} ] && YN = Y
                        case $YN in 
                        [Yy] | [Yy][Ee][Ss])
                            # gnome-terminal -- bash -c "source ~/.bashrc; ./$file ;bash"
                            # commands
                            #只能在终端执行
                            cd ~/commands/$folder
                            filename=${shell#*/}
                            if [[ "${SUDO_LIST[@]}" =~ "${filename}" ]];then
                                sudo ./$shell $2
                            else 
                                ./$shell $2
                            fi
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
            if is_empty_dir $dir/shell
            then
                continue 
            fi            
            for file in $(ls $dir/shell/*.sh)
            do 
                if [ -f $file ]; then
                    let i++

                    if [ $i == $1 ] ; then 
                        shell=${file#*/}
                        path=$(dirname $file)
                        folder=${path%/*}
                        CHOICE_C=$(echo -e "\n${BOLD}└ $(gettext "Whether to execute the script")? [Y/n]${PLAIN}")
                        read -p "${CHOICE_C}" YN
                        [ -z ${YN} ] && YN = Y
                        case $YN in 
                        [Yy] | [Yy][Ee][Ss])
                            # gnome-terminal -- bash -c "source ~/.bashrc; ./$file ;bash"
                            # commands
                            #只能在终端执行
                            cd ~/commands/$folder
                            filename=${shell#*/}
                            if [[ "${SUDO_LIST[@]}" =~ "${filename}" ]];then
                                sudo ./$shell $2
                            else 
                                ./$shell $2
                            fi
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
# commands_search_install rightnow without prompt
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_si(){
    if [ ! $1 ];then 
        echo "Shell name can not be null"
        exit 0
    fi 

    i=j=0
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
                    result=$(echo $file | grep "$1")
                    # echo $file 
                    # echo $1
                    if [[ $result != "" ]] ; then
                        let j++
                        shell=${file#*/}
                        path=$(dirname $file)
                        folder=${path%/*}
                    fi
                fi
            done 
        fi 
    done 

    #if only one jump to  install
    if [ $j == 1 ];then 
        cd ~/commands/$folder
        filename=${shell#*/}
        if [[ "${SUDO_LIST[@]}" =~ "${filename}" ]];then
            sudo ./$shell $2
        else 
            ./$shell $2
        fi
    else
        echo "Don't have shell with name ${filename}"
    fi
    
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
            if is_empty_dir $dir/shell
            then
                continue 
            fi            
            for file in $(ls $dir/shell/*.sh)
            do 
                if [ -f $file ]; then
                    let i++
                    result=$(echo $file | grep "$1")
                    # echo $file 
                    # echo $1
                    if [[ $result != "" ]] ; then
                        file_full_path="$HOME/commands/$file"
                        desc=""
                        func=""
                        website=""
                        while_read_desc $file_full_path
                        let j++
                        jid="$i"
                        echo "$dir:"
                        echo "  ID:$i - ${file##*/}"
                        echo "  ------------------------------------------$(gettext "${func}")"
                        echo "  ------------------------------------------${website}"
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
    case $1 in 
    [1-9]*)   
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

                        if [ $i == $1 ] ; then 
                            file_full_path="$HOME/commands/$file"
                            desc=""
                            func=""
                            website=""
                            while_read_desc $file_full_path
                            echo "$dir:"
                            echo "  ID:$i - ${file##*/}"
                            echo "  ------------------------------------------$(gettext "${func}")"
                            echo "  ------------------------------------------${website}"
                            shell=${file#*/}
                            path=$(dirname $file)
                            folder=${path%/*}
                            CHOICE_C=$(echo -e "\n${BOLD}└ $(gettext "Whether to execute the script")? [Y/n]${PLAIN}")
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
        ;;         
    *)
        echo "Please provide script ID"
        ;;
    esac      
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
    case $1 in 
    [1-9]*)
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

                        if [ $i == $1 ] ; then 
                            file_full_path="$HOME/commands/$file"
                            desc=""
                            func=""
                            website=""
                            while_read_desc $file_full_path                        
                            echo "$dir:"
                            echo "  ID:$i - ${file##*/}"
                            echo "  ------------------------------------------$(gettext "${func}")"
                            echo "  ------------------------------------------${website}"
                            shell=${file#*/}
                            path=$(dirname $file)
                            folder=${path%/*}
                            CHOICE_C=$(echo -e "\n${BOLD}└ $(gettext "Whether to execute the script")? [Y/n]${PLAIN}")
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
        ;;         
    *)
        echo "Please provide script ID"
        ;;
    esac     

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
    CHOICE_A=$(echo -e "\n${BOLD}└ $(gettext "Please select the script ID to be executed")：${PLAIN}")
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
    CHOICE_A=$(echo -e "\n${BOLD} Please input ROS Version , only input common, ros1 Or ros2  ：${PLAIN}")
    read -p "${CHOICE_A}" ros_version
    case $ros_version in 
    'common'|'ros1'|'ros2')
        echo "You choose to build $ros_version packages"
        ;;
    *)
        echo "ros_version can not be null and only value is ros1 Or ros2"
        commands_build    
        ;;
    esac 
    
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

    CHOICE_A=$(echo -e "\n${BOLD} Please input soft name like ：${PLAIN}")
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

    CHOICE_A=$(echo -e "\n${BOLD} Please input soft branch like (master) ：${PLAIN}")
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
        cp ~/tools/commands/commands_extra/$ros_version/shell/install_template.sh.tl $file_path
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
# commands_i18n  
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_i18n(){
    case $1 in 
    'cn') #简体中文
        SETLANG="zh_CN.UTF-8"
        ;;
    'tw') #繁体中文
        SETLANG="zh_TW.UTF-8"
        ;;
    'en') #英语
        SETLANG="en_US.UTF-8"
        ;;
    'cz')
        echo "Not Yet Support!"
        exit 0
        SETLANG="cs_CZ.UTF-8"
        ;;   
    'de')
        echo "Not Yet Support!"
        exit 0
        SETLANG="de_DE.UTF-8"
        ;;
    'es')
        echo "Not Yet Support!"
        exit 0    
        SETLANG="es_ES.UTF-8"
        ;;
    'fr')
        echo "Not Yet Support!"
        exit 0    
        SETLANG="fr_FR.UTF-8"
        ;;
    'hu')
        echo "Not Yet Support!"
        exit 0    
        SETLANG="hu_HU.UTF-8"
        ;;  
    'it')
        echo "Not Yet Support!"
        exit 0    
        SETLANG="it_IT.UTF-8"
        ;;
    'jp')
        echo "Not Yet Support!"
        exit 0    
        SETLANG="ja_JP.UTF-8"
        ;;
    'kr')
        echo "Not Yet Support!"
        exit 0    
        SETLANG="ko_KR.UTF-8"
        ;;
    'pl')
        echo "Not Yet Support!"
        exit 0    
        SETLANG="pl_PL.UTF-8"
        ;;         
    'br')
        echo "Not Yet Support!"
        exit 0    
        SETLANG="pt_BR.UTF-8"
        ;;  
    'ru')
        echo "Not Yet Support!"
        exit 0    
        SETLANG="ru_RU.UTF-8"
        ;;                                                
    *)
        SETLANG="en_US.UTF-8"
        ;;
    esac 

    echo "Add $SETLANG to bashrc if not exits"
    if ! grep -Fq "export LANG=" ~/.bashrc
    then
        echo "export LANG=$SETLANG" >> ~/.bashrc
        echo "export LC_ALL=$SETLANG" >> ~/.bashrc
    else
        sed -i "s/LANG=.*UTF-8/LANG=$SETLANG/"g ~/.bashrc
        sed -i "s/LC_ALL=.*UTF-8/LC_ALL=$SETLANG/"g ~/.bashrc
    fi 

    echo "$SETLANG have added successfully! please source ~/.bashrc"
}

#######################################
# commands_ros_version
# need to check ros version
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_ros_version()
{
    VERSION_LIST=$1
    echo "Support To : $VERSION_LIST"
    
    if [ $ROS_DISTRO != "" ];then    
        echo "Current Version Is: ${ROS_DISTRO}"
        if [[ "${VERSION_LIST[@]}" =~ "${ROS_DISTRO}" ]];then
            echo "You have the right version for ROS ${ROS_DISTRO}"
        else
            echo "You don't have the right verion for ROS ${ROS_DISTRO}"
            exit 1
        fi 
    else
        echo "You don't have installed the right verion for ROS or Don't have source ros folder yet!"
        exit 1
    fi 
    exit 0
}

#######################################
# commands_ubuntu_version
# need to check ros version
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_ubuntu_version()
{
    VERSION_LIST=$1
    echo "Support System Version To : $VERSION_LIST"
    current_version=$(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)
    if [ $ROS_DISTRO != "" ];then    
        echo "Current Version Is: ${current_version}"
        if [[ "${VERSION_LIST[@]}" =~ "${current_version}" ]];then
            echo "You have the right version for ubuntu ${current_version}"
        else
            echo "You don't have the right verion for ubuntu ${current_version}"
            exit 1
        fi 
    else
        echo "You don't have installed the right verion for ubuntu!"
        exit 1
    fi 
    exit 0
}


#######################################
# header 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function header(){
    if [  ! -n "$1" ] || [ $1 != "-si" ]; then 
        echo -e '+---------------------------------------------------+'
        echo -e '|                                                   |'
        echo -e '|   =============================================   |'
        echo -e '|                                                   |'
        echo -e "|         $(gettext "Welcome to ROS Commands Manager CLI")       |"
        echo -e '|                                                   |'
        echo -e '|   =============================================   |'
        echo -e "|   $(gettext "Author"):ncnynl                                   |"
        echo -e "|   $(gettext "Email"):1043931@qq.com                            |"
        echo -e "|   $(gettext "Website"):https://ncnynl.com                      |"
        echo -e "|   $(gettext "Date"):2022-11-18                                 |"
        echo -e "|   $(gettext "QQ Qun B"):926779095                              |"
        echo -e "|   $(gettext "QQ Qun C"):937347681                              |"
        echo -e "|   $(gettext "QQ Qun D"):562093920                              |"
        echo -e '+---------------------------------------------------+'
        echo -e ''
    fi
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
    header $1
    case $1 in 
    [1-9]*)
        echo -e '#####################################################'
        echo -e "########$(gettext "The following script will be executed")     "
        echo -e '#####################################################'
        #执行脚本
        commands_install $1 $2
        return 
        ;;
    '-s'|'search')
        echo -e '#####################################################'
        echo -e "########$(gettext "Alternative scripts") "
        echo -e '#####################################################'    
        commands_search $2
        # echo -e '#####################################################'
        # select_id       
        ;;   
    '-si'|'search-install')
        commands_si $2
        # echo -e '#####################################################'
        # select_id       
        ;;          
    '-l'|'list')
        echo -e '#####################################################'
        echo -e "########$(gettext "Alternative scripts")"
        echo -e '#####################################################'    
        commands_list
        ;;    
    '-i'|'install')
        echo -e '#####################################################'
        echo -e "########$(gettext "Install") $2 "
        echo -e '#####################################################'    
        sudo apt install $2
        ;;     
    '-r'|'remove')
        echo -e '#####################################################'
        echo -e "########$(gettext "Remove") $2 "
        echo -e '#####################################################'    
        sudo apt remove $2
        ;;  
    '-u'|'upgrade')
        echo -e '#####################################################'
        echo -e "########$(gettext "Upgrade RCM") "
        echo -e '#####################################################'    
        . ~/commands/common/shell/upgrade_rcm.sh
        ;;       
    '-v'|'version')
        current_version=$(cat ~/tools/commands/version.txt)
        echo -e '#####################################################'
        echo -e "########$(gettext "Current RCM Version"): $current_version"
        echo -e '#####################################################'    
        ;;     
    '-e'|'edit')
        echo -e '#####################################################'
        echo -e "########$(gettext "Edit File") "
        echo -e '#####################################################'    
        commands_edit $2
        ;;   
    '-c'|'check')
        echo -e '#####################################################'
        echo -e "########$(gettext "View File Content") "
        echo -e '#####################################################'    
        commands_check $2
        ;;        
    '-b'|'build')
        echo -e '#####################################################'
        echo -e "########$(gettext "Build install script") "
        echo -e '#####################################################'    
        commands_build $2
        ;;    
    '-L'|'language')
        echo -e '#####################################################'
        echo -e "########$(gettext "select language") "
        echo -e '#####################################################'    
        commands_i18n $2
        ;;   
    '-rv'|'ros_version')
        commands_ros_version $2
        return $?
        ;;   
    '-uv'|'ubuntu_version')
        commands_ubuntu_version $2
        return $?
        ;;                                                                
    '-h'|'help')
        echo -e '#####################################################'
        echo -e "########$(gettext "commands help to the RCM tools")  "
        echo -e '#####################################################'
        echo "$(gettext  "Usage"): cs [options] [keyword]"
        echo "  "
        echo "$(gettext "List of available options"):"
        echo "  "
        echo "-h | help:       $(gettext "Print this help text")."
        echo "-s | search:     $(gettext "Search the script file by keyword")"
        echo "-si | search-install:     $(gettext "Search the script file and install rightnow")"
        echo "-l | list:       $(gettext "List all script files and serial numbers")"
        echo "-L | language:   $(gettext "Select language with en cn tw cz de es fr hu it jp kr pl br ru")"
        echo "-i | install:    $(gettext "Install apt packages")"
        echo "-r | remove:     $(gettext "Remove apt packages") "
        echo "-e | edit:       $(gettext "Edit script through vim") "
        echo "-c | check:      $(gettext "Check script through cat") "
        echo "-b | build:      $(gettext "Build install script through template")"                        
        echo "-u | upgrade:    $(gettext "Upgrade RCM")"
        echo "-v | version:    $(gettext "Show RCM version") "
        echo "id:              $(gettext "Provide the serial number to install")"
        ;;             
    *)
        echo -e '#####################################################'
        echo -e "########$(gettext "Alternative scripts")"
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
