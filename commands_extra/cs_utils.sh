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
    echo `ls -A $1|wc -w`
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