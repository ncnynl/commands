#!/bin/sh
################################################################
# Function :ROS Commands Manager Shell Utils Script                
# Platform :All Linux Based Platform                           
# Version  :1.1                                                
# Date     :2023-09-03                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################

# Examples 
#
# working "1-Current path is under $currentPath"
# error "2-Current path is under $currentPath"
# success "3-Current path is under $currentPath"
# warning "4-Current path is under $currentPath"
# underline "5-Current path is under $currentPath"
# bold "6-Current path is under $currentPath"

# echo ${SUCCESS}
# echo ${COMPLETE}
# echo ${WARN}
# echo ${ERROR}
# echo ${WORKING}
# echo ${BOLD}

source $HOME/commands/cs_variables.sh

# Print error into stdout
function error() {
    echo ${RED}"ERROR: $@"${RESET} >&2
}

# Print success into stdout
function success() {
    echo ${GREEN}"SUCCESS: $@"${RESET} >&2
}

# Print warning
function warning() {
    echo ${YELLOW}"WARNING: $@"${RESET} >&2
}

# Print underline content
function underline() {
    echo ${UNDER}"$@"${RESET} >&2
}

# Print bold content
function bold() {
  echo ${BOLD}"$@"${RESET} >&2
}

# Print working
function working() {
  echo ${BLUE}"WORKING: $@"${RESET} >&2
}

# Print note
function hint() {
  echo ${UNDER}${BOLD}${PURPLE}"HINT: $@"${RESET} >&2
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
# check url if exists
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    1 or 0
#######################################
function check_url()
{
   filestatus=$(curl -s -m 5 -IL $1|grep 200)
   if [ ${#filestatus} != 0 ]; then 
    echo 1
   else 
    echo 0
   fi
}

#######################################
# check cpu 
# 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    x86_64, aarch64, armv7l
#######################################
function check_cpu()
{
    echo $(uname -m)
}

#######################################
# check system 
# 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    18.04,20.04,22.04,23.04,24.04
#######################################
function check_system()
{
    echo $(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)
}

#######################################
# check soft if installed 
# 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    1 or 0
#######################################
function check_installed()
{
    is_exits=$(which is $1)
    if [ ${#is_exits} != 0 ]; then 
        echo 1
    else
        echo 0
    fi
}

#######################################
# kill pid 
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
function kill_by_name()
{   
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

#######################################
# check github  
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
function check_github()
{   
    export http_proxy=""
    export https_proxy=""

    # GitHub URL
    GITHUB_URL="https://github.com"
    # 连接超时时间（秒）
    CONNECT_TIMEOUT=5
    # 最大请求时间（秒）
    MAX_TIME=10    
    if [ "$(curl -s --connect-timeout "$CONNECT_TIMEOUT" --max-time "$MAX_TIME" -o /dev/null -w "%{http_code}" --http2 "$GITHUB_URL")" == "200" ]; then
        echo 1
    else
        echo 0
    fi
}

#######################################
# check_github_with_prefix_proxy 
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
function check_github_with_prefix_proxy()
{   
    export http_proxy=""
    export https_proxy=""

    echo "Proxy List:"
    echo "https://mirror.ghproxy.com"
    echo "https://cf.ghproxy.cc"
    echo "https://gh-proxy.com"
    echo "https://gh.ddlc.top"
    echo "https://gh.api.99988866.xyz"
    echo "https://ghp.ci"

    cd ~
    git clone $1/https://github.com/ncnynl/test  rcm_check_github

    if [ -d ~/rcm_check_github ]; then
        echo 1
        rm -rf  ~/rcm_check_github
    else
        echo 0
    fi
} 

#######################################
# check_file_with_github
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
function check_file_with_github()
{
        # GitHub URL
    GITHUB_URL="github.com"
    # 检查脚本内容是否包含 GitHub 地址
    if grep -q "$GITHUB_URL" "$1"; then
        echo 1  
    else
        echo 0 
    fi
}
