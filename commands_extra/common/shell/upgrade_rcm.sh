#!/bin/bash
################################################
# Function : upgrade_rcm.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-22                       
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
        
#version compare
function version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }
function version_le() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" == "$1"; }
function version_lt() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" != "$1"; }
function version_ge() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"; }

PidFind(){   
    PIDCOUNT=`ps -ef | grep $1 | grep -v "grep" | grep -v $0 | grep -v "close_commands"  | awk '{print $2}' | wc -l`;  
    echo "Found process num: ${PIDCOUNT} "
    if [ ${PIDCOUNT} -gt 0 ] ; then  
        echo "There are ${PIDCOUNT} process contains name[$1]" 
        PID=`ps -ef | grep $1 | grep -v "grep" | grep -v "close_commands" | awk '{print $2}'` ;
        echo "$1 's PID is: $PID"
        kill -9  ${PID};
        echo "$1 's PID has killed!";
    elif [ ${PIDCOUNT} -le 0 ] ; then 
        echo "No such process[$1]!"  
    fi  
} 
#check version.txt

wget -O /tmp/version.txt https://gitee.com/ncnynl/commands/raw/master/version.txt

old_version=$(cat ~/tools/commands/version.txt)
new_version=$(cat /tmp/version.txt)

echo "Old Version is " $old_version
echo "New Version is " $new_version

if version_gt $new_version $old_version ; then 
    CHOICE_C=$(echo -e "\n${BOLD}└ Have a new version, go to upgrade? [Y/n]${PLAIN}")
    read -p "${CHOICE_C}" YN
    [ -z ${YN} ] && YN = Y
    case $YN in 
    [Yy] | [Yy][Ee][Ss])
        if [  -f /usr/bin/commands ]; then 
            echo "kill /usr/bin/commands ...."
            PidFind "/usr/bin/commands"
            echo "Desktop version is going to upgrade"
            cd /tmp/ ; rm online.sh ; wget https://gitee.com/ncnynl/commands/raw/master/online.sh ; sudo chmod +x ./online.sh; ./online.sh ; rm ./online.sh
        else
            echo "kill /usr/bin/cs ...."
            PidFind "/usr/bin/cs"
            echo "Shell version is going to upgrade"
            cd /tmp/ ; rm online_shell.sh ; wget https://gitee.com/ncnynl/commands/raw/master/online_shell.sh ; sudo chmod +x ./online_shell.sh; ./online_shell.sh ; rm ./online.sh
        fi
        ;;
    [Nn] | [Nn][Oo])
        exit 0 
        ;;
    *)
        exit 0 
        ;;    
    esac    
    echo "upgrade is done!"
else 
    echo "Don't need upgrade!"
fi