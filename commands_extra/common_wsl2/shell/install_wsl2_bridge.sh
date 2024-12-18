#!/bin/bash
################################################
# Function : Install wsl2 bridge   
# Desc     : 用于生成WSL2系统桥接脚本，WSL2的IP配置脚本和取消桥接脚本的脚本
# Website  : https://www.ncnynl.com/archives/202301/5823.html                             
# Platform : WSL2 ubuntu                                
# Version  : 1.0                               
# Date     : 2022-01-10                             
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
echo "$(gettext "Install wsl2 bridge")"

function build_wsl_bridge(){

    echo "Build wsl-bridge ......"

    CHOICE_A=$(echo -e "Please input your windows username(Like: ROSEASY-WIN10) ：")
    read -p "${CHOICE_A}" win_username
    if [ ! $win_username ]; then
        echo "win_username can not be null"
        build_wsl_bridge
	if [ ! -d "/mnt/c/Users/$win_username" ]; then 
	    echo "win_username is not exits, Please try again"
	    build_wsl_bridge
	fi
    fi
    user_home="/mnt/c/Users/$win_username"
    echo "Your windows username is: $win_username"
    echo "Your username folder is: $user_home"

    CHOICE_B=$(echo -e "Please input your WSL gateway  (Like: 192.168.1.1)：")
    read -p "${CHOICE_B}" wsl_gateway
    if [ ! $wsl_gateway ]; then
        echo "wsl_gateway can not be null"
        build_wsl_bridge
    fi
    echo "Your WSL gateway is: $wsl_gateway"
    echo ""

    CHOICE_C=$(echo -e "Please input your WSL netmask  (Like: 192.168.1.255)：")
    read -p "${CHOICE_C}" wsl_netmask
    if [ ! $wsl_netmask ]; then
        echo "wsl_netmask can not be null"
        build_wsl_bridge
    fi
    echo "Your WSL netmask is: $wsl_netmask"
    echo ""

    CHOICE_D=$(echo -e "Please input your WSL IP (Like: 192.168.1.110)：")
    read -p "${CHOICE_D}" wsl_ip
    if [ ! $wsl_ip ]; then
        echo "wsl_ip can not be null"
	build_wsl_bridge	
    fi
    echo "Your WSL IP is: $wsl_ip"
    echo ""

    CHOICE_E=$(echo -e "Please input your windows netadapter name, Check with Get-NetAdapter from powershell (Like: Wifi/WLAN )：")
    read -p "${CHOICE_E}" win_netadapter
    if [ -z "${win_netadapter}" ]; then
        echo "win_netadapter can not be null"
        build_wsl_bridge
    fi
    echo "Your windows netadapter is: $win_netadapter"
    echo ""

    echo "Build set_eth0.sh......."
    echo ""

    folder_name="common_wsl2"
    file_name="set_eth0.sh"
    if [ ! -d ~/tools/commands/commands_extra/$folder_name/shell/ ];then
        echo "$folder_name is not exits in ~/tools/commands/commands_extra, please create it manual first"
	exit 0
    else
        file_path="$HOME/$file_name"
	echo "Copy template to $file_path"
        cp ~/tools/commands/commands_extra/$folder_name/shell/$file_name.tl $file_path
    fi

    echo "Replace variable to ~/$file_name "
    sed -i "s/<wsl_ip>/${wsl_ip}/"g  ${file_path}
    sed -i "s/<wsl_netmask>/${wsl_netmask}/"g  ${file_path}
    sed -i "s/<wsl_gateway>/${wsl_gateway}/"g  ${file_path}
    

    echo "Build wsl-bridge-on.ps1.........."
    wsl_on_name="wsl-bridge-on.ps1"
    echo "Copy template to ~/$wsl_on_name"
    wsl_on_path="$user_home/$wsl_on_name"
    cp ~/tools/commands/commands_extra/$folder_name/shell/$wsl_on_name.tl $wsl_on_path

    echo "Replace variable to ~/$wsl_on_name "
    sed -i "s/<adapter>/${win_netadapter}/"g  ${wsl_on_path}

    echo "Build wsl-bridge-off.ps1.........."
    wsl_off_name="wsl-bridge-off.ps1"
    echo "Copy template to ~/$wsl_off_name"
    wsl_off_path="$user_home/$wsl_off_name"
    cp ~/tools/commands/commands_extra/$folder_name/shell/$wsl_off_name.tl $wsl_off_path

}
build_wsl_bridge
