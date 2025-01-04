#!/bin/bash
################################################################
# Function :ROS Commands Manager Shell variables Script                
# Platform :All Linux Based Platform                           
# Version  :1.1                                                
# Date     :2023-09-03                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://ncnynl.com                                      
################################################################

# Colors
RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
PURPLE=$(printf '\033[35m')

BOLD=$(printf '\033[1m')
UNDER=$(printf '\033[4m')

RESET=$(printf '\033[m')
PLAIN=$(printf '\033[0m')

# echo -e "${RED}=====红色可替换部分=====${RESET}"

SUCCESS=$(printf '[\033[32mOK\033[0m]')
COMPLETE=$(printf '[\033[32mDone\033[0m]')
WARN=$(printf '[\033[33mWARN\033[0m]')
ERROR=$(printf '[\033[31mERROR\033[0m]')
WORKING=$(printf '[\033[34mWORKING\033[0m]')

# echo $SUCCESS

# Var
export CS_ROOT="${HOME}/commands"      #用于应用
export CS_DEV="${HOME}/tools/commands/" #用于开发
export CS_DEV_SCRIPT="${HOME}/tools/commands/commands_extra" #用于开发的脚本目录

# need sudo
SUDO_LIST=(
update_system_mirrors.sh
update_system_simple.sh
update_ros1_source.sh
update_ros2_source.sh
update_docker_source.sh
update_swap.sh
update_hostname.sh
)

# fixed for docker 
if [ -z $TERM ]; then 
    export TERM=xterm
fi