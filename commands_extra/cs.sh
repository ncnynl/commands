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

source $HOME/commands/cs_utils.sh
source $HOME/commands/cs_variables.sh


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
                # result=$(echo $file | grep "^load_")
                # if [[ $result != "" ]] ; then
                #     continue
                # fi                
                if [ -f $file ]; then
                    file_full_path="$HOME/commands/$file"
                    desc=""
                    func=""
                    website=""
                    while_read_desc $file_full_path
                    let i++
                    echo "  ID:$i - ${file##*/}"
                    echo "  ------------------------------------------$(gettext "${func}")"
                    if [ $website ]; then
                    echo "  ------------------------------------------${website}"
                    fi 
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
                # result=$(echo $file | grep "^load_")
                # if [[ $result != "" ]] ; then
                #     continue
                # fi             
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
                        if [ $website ]; then
                        echo "  ------------------------------------------${website}"
                        fi
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
                            shell_path=~/commands/$folder
                            full_name="$shell_path/$shell"
                            proxy_handle_before_install $full_name
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
                # result=$(echo $file | grep "^load_")
                # if [[ $result != "" ]] ; then
                #     continue
                # fi 
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
                            shell_path=~/commands/$folder
                            full_name="$shell_path/$shell"
                            proxy_handle_before_install $full_name
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
# proxy_handle_before_install
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function proxy_handle_before_install()
{
    # echo "0:$0" 
    # echo "1:$1"  
    # echo "2:$2" 
    # echo "3:$3" 
    # echo "4:$4" 

    #通过判断脚本是否github.com网址，自动适配系统代理，前缀代理，从而增加下载成功率
    #判断是否包含github
    if [ $(check_file_with_github $1) == 1 ]; then 
        echo "The script contains github.com required processing"
        echo "Check if you can access github.com "
        if [ $(check_github) == 1 ]; then 
            echo "you can access github.com, continue "
        else
            echo "you can not access github.com, add proxy prefix"
            rcm -p
            if [ $(check_github) == 1 ]; then 
                echo "use git proxy now"
            else
                echo "if still can not access github.com, you can use other proxy, please check the above proxy list"
                echo "rcm -p proxy_website (such as: rcm -p http://ghp.ci)"
                echo ""
                echo "if you have v2rayN proxy or other local proxy, you can use as : "
                echo "rcm -shp ip port (such as: rcm -shp 192.168.0.16 10809)"
                echo ""
                echo "when system proxy set, you can check if usefull"
                echo "rcm -s check_github"
                echo ""
            fi
        fi
    fi
}

#######################################
# commands_search_source
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_search_source(){
    i=j=0
    dir="ros_easy"
    shell_list=()
    for file in $(ls ./$dir/shell/load_*.sh)
    do 
        if [ -f $file ]; then
            let i++
            result=$(echo $file | grep "$1")
            # echo $file 
            # echo $1
            if [[ $result != "" ]] ; then
                file_full_path="$HOME/commands/$file"
                shell=${file#*/}
                # echo $shell
                desc=""
                func=""
                website=""
                while_read_desc $file_full_path
                let j++
                jid="$i"
                shell_list[$i]="$HOME/commands/$shell"
                echo "$dir:"
                echo "  ID:$i - ${file##*/}"
                echo "  ------------------------------------------$(gettext "${func}")"
            fi
        fi
    done
    # echo ${shell_list[@]}
    if [ $j == 1 ]; then 
        CHOICE_C=$(echo -e "\n${BOLD}└ $(gettext "Whether to source the file")? [Y/n]${PLAIN}")
        read -p "${CHOICE_C}" YN
        [ -z ${YN} ] && YN = Y
        case $YN in 
        [Yy] | [Yy][Ee][Ss])
            file_name=${shell_list[$jid]}
            # echo $file_name
            if [ -f $file_name ]; then 
                echo "Source The File: $file_name"
                source $file_name
            fi
            ;;
        *)
            commands -ss
            ;;
        esac  
    else 
        CHOICE_A=$(echo -e "\n${BOLD}└ $(gettext "Please select the script ID to source ")：${PLAIN}")
        read -p "${CHOICE_A}" INPUT
        if [ "" != $INPUT ]; then 
            file_name=${shell_list[$INPUT]}
            # echo $file_name
            if [ -f $file_name ]; then 
                echo "Source The File: $file_name"
                source $file_name
            fi
        else
            commands -ss 
        fi 
    fi

    #if add or del from bashrc
    if [ $2 ];then 
        file_string=${file_name##*/}
        if [ $2 == "-del" ]; then 
            
            if  grep -Fq "$file_string" ~/.bashrc
            then
                file_string=${file_name##*/}
                sed -i -e "/$file_string/d" ~/.bashrc
                echo "Deleted successfully!"
            else
                echo "Don't has been added before! Please check ~/.bashrc"
            fi
        fi 

        if [ $2 == '-add' ]; then 
            if ! grep -Fq "$file_string" ~/.bashrc
            then
                # echo $file_name
                echo ". $file_name" >> ~/.bashrc
                echo "Added successfully! writed to ~/.bashrc"
            else
                echo "Has been Added before! Please check ~/.bashrc"
            fi
        fi 
    fi
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
    if [ ! $2 ];then 
        echo "Shell name can not be null"
        exit 0
    fi 
    # echo $1
    # echo $2
    # echo $3
    # echo $4
    # return 
    i=j=0
    #fix bug for -si in script
    for dir in $(ls)
    do
    # echo $dir
        if [ -d $dir/shell ]; then 
            if is_empty_dir $dir/shell
            then
                continue 
            fi            
            for file in $(ls $dir/shell/*.sh)
            do 
                if [ -f $file ]; then
                    let i++
                    result=$(echo $file | grep "$2")
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
    # echo $j
    if [ $j == 1 ]; then 
        cd ~/commands/$folder
        filename=${shell#*/}
        shell_path=~/commands/$folder
        full_name="$shell_path/$shell"
        proxy_handle_before_install $full_name
        if [[ "${SUDO_LIST[@]}" =~ "${filename}" ]]; then
            sudo ./$shell $*
        else 
            ./$shell $*
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
                # result=$(echo $file | grep "^load_")
                # # echo $result
                # if [[ $result != "" ]] ; then
                #     continue
                # fi             
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
# commands_domain_id  
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_domain_id(){
    echo "Add ROS_DOMAIN_ID $1 to bashrc if not exits"
    if ! grep -Fq "export ROS_DOMAIN_ID=" ~/.bashrc
    then
        echo "export ROS_DOMAIN_ID=$1" >> ~/.bashrc
    else
        sed -i "s/ROS_DOMAIN_ID=.*/ROS_DOMAIN_ID=$1/"g ~/.bashrc
    fi 

    echo "ROS_DOMAIN_ID $1 have added successfully! please source ~/.bashrc"
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
# commands_ubuntu_platform
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function commands_ubuntu_platform()
{
    # x86_64(amd) | aarch64(arm)
    VERSION_LIST=$1
    echo "Support System Version To : $VERSION_LIST"
    current_cpu=$(uname -m)
    if [ $current_cpu == "x86_64" ]; then
        cpu_release="amd"
    elif [ $current_cpu == "aarch64" ]; then
        cpu_release="arm"
    fi

    if [ $ROS_DISTRO != "" ];then    
        echo "Current Version Is: ${cpu_release}"
        if [[ "${VERSION_LIST[@]}" =~ "${cpu_release}" ]];then
            echo "You have the right version for ubuntu ${cpu_release}"
        else
            echo "You don't have the right verion for ubuntu ${cpu_release}"
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
# proxy_add_prefix
# 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    
#######################################
function proxy_add_prefix()
{
    echo $1
    echo $2

    echo "Proxy List:"
    echo ""
    echo "https://mirror.ghproxy.com"
    echo "https://cf.ghproxy.cc"
    echo "https://gh-proxy.com"
    echo "https://gh.ddlc.top"
    echo "https://gh.api.99988866.xyz"
    echo "https://ghp.ci"
    echo ""
    echo "UASGE: rcm -p https://gh-proxy.com"
    echo ""

    echo "Setting default proxy gh-proxy.com"
    if [ $2 ]; then 
        default=$2
    else
        default="https://gh-proxy.com"
    fi
    default_proxy="$default/https://github.com"
    #backup
    cp ~/.gitconfig ~/.gitconfig.bk
    git config --global url.$default_proxy.insteadof https://github.com
    echo "haved setted github's proxy as $default_proxy, please check ~/.gitconfig/"
    cat ~/.gitconfig     
}  

#######################################
# proxy_del_prefix
# 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    
#######################################
function proxy_del_prefix()
{
    echo "unset default proxy"
    default_proxy="gh-proxy.com"
    if [ $2 ]; then 
        default_proxy=$(echo "$2" | sed -e 's~http[s]\?://~~g')
    fi
    #backup
    echo $default_proxy
    cp ~/.gitconfig ~/.gitconfig.bk
    sed -i "/$default_proxy/d" ~/.gitconfig
    sed -i '/insteadof/d' ~/.gitconfig
    echo "github.com proxy is unsetted!!, please check ~/.gitconfig/"
    cat ~/.gitconfig
}

#######################################
# proxy_add_global
# 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    
#######################################
function proxy_add_global()
{
    echo "USAGE: rcm -hp 192.168.0.12 8080"
    echo ""

    if [ ! $2 ]; then 
        echo "IP cat not be null "
        exit 0
    fi 

    if [ ! $3 ]; then 
        echo "port cat not be null "
        exit 0
    fi 

    git config --global http.proxy http://${2}:${3}
    git config --global https.proxy https://${2}:${3}
    cat ~/.gitconfig

}

#######################################
# proxy_del_global
# 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    
#######################################
function proxy_del_global()
{
    echo "USAGE: rcm -nhp"
    echo ""

    git config --global --unset http.proxy
    git config --global --unset https.proxy
    cat ~/.gitconfig
}

#######################################
# proxy_add_system
# 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    
#######################################
function proxy_add_system()
{
    echo "USAGE: rcm -sp 192.168.0.12 8080"

    echo "" 

    if [ ! $2 ]; then 
        echo "IP cat not be null "
        exit 0
    fi 

    if [ ! $3 ]; then 
        echo "port cat not be null "
        exit 0
    fi 

    # 检查是否已经存在代理设置，若不存在则添加
    HTTP_PROXY="http://$2:$3"
    if ! grep -q "export http_proxy=" ~/.bashrc; then
        echo "export http_proxy=\"$HTTP_PROXY\"" >> ~/.bashrc
        echo "export https_proxy=\"$HTTP_PROXY\"" >> ~/.bashrc
        echo "代理已添加到 .bashrc"
    else
        echo "代理已存在于 .bashrc 中"
    fi
}

#######################################
# proxy_del_system
# 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    
#######################################
function proxy_del_system()
{
    echo "USAGE: rcm -nsp"
    echo ""

    # 删除代理行
    sed -i '/^export http_proxy=/d' ~/.bashrc
    sed -i '/^export https_proxy=/d' ~/.bashrc

    echo "代理已从 .bashrc 中删除"
}

#######################################
# download_code
# 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    
#######################################
function download_code()
{
    #default use gh-proxy.com
    if [ $2 ]; then 
        echo "Download code"

        echo "USAGE: rcm -d https://github.com/ncnynl/test "
        echo "USAGE: rcm -d https://github.com/ncnynl/test master"

        echo ""

        echo "URL:$2"
        echo "VER:$4"

        echo ""

        #URL
        result=$(echo $2 | grep "github.com")
        if [[ "$result" != "" ]]; then
            if [ $(check_github) == 1 ]; then 
                echo "you can access github.com, continue "
            else
                echo "you can not access github.com, add proxy prefix"
                rcm -p
                echo "use git proxy now"
                echo "if still can not access github.com, you can use other proxy, please check the above proxy list"
            fi
        else
            url=$2
        fi
        
        #position
        if [ $3 ]; then
            floder=$3
            if [ ! -d $3 ]; then 
                echo "$3 is not folder, replace by default folder ~/tools"
                floder=~/tools
            fi
        else
            floder=~/tools
        fi 
        cd $floder

        #version
        if [ $4 ]; then 
            ver="-b $4"
            echo "code version is $ver"
        else
            ver=""
        fi

        echo "Ready to download  git clone $ver $url"
        git clone $ver $url 
        echo "File is download to $floder "
    else
        echo "You need provide URL for git clone"
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
    '-si'|'search_install')
        commands_si $*
        # echo -e '#####################################################'
        # select_id       
        ;;   
    '-p'|'proxy')
        proxy_add_prefix $*
        ;;  
    '-np'|'noproxy')
        proxy_del_prefix $*
        ;;  
    '-hp'|'git_https_proxy')
        proxy_add_global $*
        ;;
    '-nhp'|'no_git_https_proxy')
        proxy_del_global $*
        ;;
    '-sp'|'system_https_proxy')
        proxy_add_system $*
        ;;
    '-nsp'|'no_system_https_proxy')
        proxy_del_system $*
        ;;                     
    '-d'|'download')
        download_code $*
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
    '-up'|'ubuntu_platform')
        commands_ubuntu_platform $2
        return $?
        ;;          
    '-ss'|'search_source')
        echo -e '#####################################################'
        echo -e "########$(gettext "Select load file to source") "
        echo -e '#####################################################'   
        commands_search_source $2 $3
        ;;      
    '-id'|'domain_id')
        echo -e '#####################################################'
        echo -e "########$(gettext "Set Domain ID") "
        echo -e '#####################################################'   
        commands_domain_id $2 
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
        echo "  "
        echo "-s | search:     $(gettext "Search the script file by keyword, USAGE: rcm -s script_name_keyword | rcm -s check_gitee")"
        echo "  "
        echo "-si | search_install:     $(gettext "Search the script file and install rightnow, USAGE: rcm -si script_full_name | rcm -si check_python_version")"
        echo "  "
        echo "-ss | search_source:   $(gettext "Source config file, USAGE: rcm -ss ros2 -add | -del' , -add add to ~/.bashrc, -del delete from ~/.bashrc")"        
        echo "  "
        echo "-id | domain_id:   $(gettext "Set doamin id, USAGE: rcm -id num | rcm -id 2")"        
        echo "  "            
        echo "-l | list:       $(gettext "List all script files and serial numbers,USAGE: rcm -list")"
        echo "  "
        echo "-L | language:   $(gettext "Select language with en cn tw cz de es fr hu it jp kr pl br ru")"
        echo "  "
        echo "-i | install:    $(gettext "Install apt packages")"
        echo "  "
        echo "-r | remove:     $(gettext "Remove apt packages") "
        echo "  "
        echo "-e | edit:       $(gettext "Edit script through vim") "
        echo "  "
        echo "-c | check:      $(gettext "Check script through cat") "
        echo "  "
        echo "-b | build:      $(gettext "Build install script through template")"   
        echo "  "                     
        echo "-u | upgrade:    $(gettext "Upgrade RCM, USAGE: rcm -u")"
        echo "  "
        echo "-v | version:    $(gettext "Show RCM version,USAGE: rcm -v ") "
        echo "  "
        echo "-p | proxy:       $(gettext "Set prefix proxy for github, USAGE: rcm -p https://gh-proxy.com") "
        echo "  "
        echo "-np | noproxy:    $(gettext "Unset prefix proxy for github, USAGE: rcm -np ") "
        echo "  "
        echo "-hp | https_proxy:   $(gettext "Set git proxy , USAGE: rcm -hp {IP} {PORT} | rcm -hp 192.168.0.16 10811") "
        echo "  "
        echo "-nhp | no_https_proxy:  $(gettext "Unset git proxy, USAGE: rcm -nhp") "    
        echo "  "    
        echo "-sp | system_https_proxy:   $(gettext "Set system proxy, USAGE: rcm -sp {IP} {PORT} | rcm -sp 192.168.0.16 10811") "
        echo "  "
        echo "-nsp | system_no_https_proxy:  $(gettext "Unset system proxy, USAGE: rcm -nsp ") "   
        echo "  " 
        echo "-d | download:    $(gettext "Download github , gitee repo code cs -d URL Position version, USAGE: rcm -d https://github.com/ncnynl/test") "
        echo "  "
        echo "id:              $(gettext "Provide the serial number to install, USAGE: rcm id | rcm 2 ")"
        ;;             
    *)
        # 采用自动补全功能，实现推荐触发运行脚本
        # ./$shell $2
        # echo "0:$0"
        # echo "1:$1" 
        # echo "2:$2" 
        # echo "3:$3"
        # echo "4:$4"
        # echo "5:$5"
        # execute shell
        if [ $# -ge 2 ]; then 
            local script_file="$CS_ROOT/$1/shell/$2.sh"
            
            if [ -f $script_file ]; then 
                proxy_handle_before_install $script_file
                if [[ "${SUDO_LIST[@]}" =~ "${2}.sh" ]]; then
                    sudo "$CS_ROOT/$1/shell/$2.sh" $*
                else 
                    "$CS_ROOT/$1/shell/$2.sh" $*
                fi
            else 
                echo "Path is not exits : $script_file"
            fi
        else
            echo "This command need three Params. But you only have $# !! "
            # commands -l
        fi 
        ;;
    esac
}

source ${HOME}/.bashrc
cd $CS_ROOT 
commands $*