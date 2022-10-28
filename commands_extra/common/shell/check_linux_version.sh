#!/bin/bash
################################################
# Function : Check Python Version                            
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-24 15:17:32                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################


#######################################
# Get System Version
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   ubuntu
# Outputs:
#    echo to stdout
#######################################
function get_system(){
    release=""
    if cat /etc/issue | grep -Eqi "ubuntu"; then
        release="ubuntu"
    elif cat /proc/version | grep  -Eqi  "ubuntu"; then
        release="ubuntu"
    fi

    echo $release
}


release=$(get_system)
# echo $release

if [[ ! $release ]] ; then
    echo -e "This script can not be run in your system now!" && exit 1
fi

#######################################
# Get System Version
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   ubuntu
# Outputs:
#    echo to stdout
#######################################
function get_system_version(){
    version=""
    if [ $1 == "ubuntu" ]; then
        version=$(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)
    fi
    echo $version
}

version=$(get_system_version $release)
# echo $version
if [[ ! $version ]]; then
    echo -e "This script can not be run in your system now!" && exit 1
fi


#######################################
# Get CPU Version
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   amd64     - x86_64  for pc
#   aarch64   - aarch64 for rpi
# Outputs:
#    echo to stdout
#######################################

function get_cpu_version(){
    cpu_release=""
    cpu=$(uname -a | awk -F " " '{print $(NF-1)}')
    if [ $cpu == "x86_64" ]; then
        cpu_release="amd64"
    elif [ $cpu == "aarch64" ]; then
        cpu_release="aarch64"
    fi
    echo $cpu_release
}

cpu_release=$(get_cpu_version)
# echo $cpu_release

if [[ ! $cpu_release ]] ; then
    echo -e "This script can not be run in your system now!" && exit 1
fi