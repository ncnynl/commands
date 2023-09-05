#!/bin/bash
################################################################
# Function : Update ROS2 Source                                 #
# Desc     : 用于更新ROS2源的脚本
# Platform :All Linux Basudo sed Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update ROS2 Source")"

#set Key
sudo apt-get update && sudo apt-get install curl gnupg lsb-release
sudo curl -sSL https://mirrors.tuna.tsinghua.edu.cn/rosdistro/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'

function get_about() {
	echo ""
	echo " ========================================================= "
	echo " \              Update ROS2 Source                       / "
	echo " ========================================================= "
	echo ""
	echo " Intro: https://ncnynl.com"
	echo " Copyright (C) 2022 ncnynl 1043931@qq.com"
	echo -e " Version: ${GREEN}1.0.0${PLAIN} (2022-02-23)"
	echo ""
}

function get_help(){
	echo "Script Usage:"
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros2_source.sh${PLAIN}"
	echo -e "${GREEN}###set sources from packages.ros.org####${PLAIN}"	
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros2_source.sh aliyun${PLAIN}"
	echo -e "${GREEN}###set sources from mirrors.aliyun.com####${PLAIN}"	
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros2_source.sh tsinghua${PLAIN}"
	echo -e "${GREEN}###set sources from mirrors.tuna.tsinghua.edu.cn####${PLAIN}"	
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros2_source.sh bfsu${PLAIN}"
	echo -e "${GREEN}###set sources from mirrors.bfsu.edu.cn####${PLAIN}"	
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros2_source.sh restore${PLAIN}"
	echo -e "${GREEN}###restore sources from backup file####${PLAIN}"	
}

function update_init(){
	# [[ $EUID -ne 0 ]] && echo -e " ${RED}Error:${PLAIN} This script must be run as root!" && exit 1

	if cat /etc/issue | grep -Eqi "ubuntu"; then
	  release="ubuntu"
	elif cat /proc/version | grep -Eqi "ubuntu"; then
	  release="ubuntu"
	fi

  if [ $release == "ubuntu" ]; then
		ubuntuVersion=$(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)
	else
		echo -e " ${RED}Error:${PLAIN} This script can not be run in your system now!" && exit 1
	fi
}


function set_ubuntu(){
	if [[ -f /etc/apt/sources.list.d/ros2-latest.list.bak ]]; then
		echo -e " ${GREEN}ros2-latest.list.bak exists${PLAIN}"
	else
		[ -f /etc/apt/sources.list.d/ros2-latest.list ] && sudo mv /etc/apt/sources.list.d/ros2-latest.list{,.bak}
	fi

	[ -f /etc/apt/sources.list.d/ros2-latest.list ] && sudo rm /etc/apt/sources.list.d/ros2-latest.list

	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu xenial main" | sudo tee  /etc/apt/sources.list.d/ros2-latest.list

	[ "$ubuntuVersion" == '14.04' ] && sudo sed -i 's/xenial/trusty/'g /etc/apt/sources.list.d/ros2-latest.list
	[ "$ubuntuVersion" == '16.06' ] && echo -n ""
	[ "$ubuntuVersion" == '18.04' ] && sudo sed -i 's/xenial/bionic/'g /etc/apt/sources.list.d/ros2-latest.list
	[ "$ubuntuVersion" == '20.04' ] && sudo sed -i 's/xenial/focal/'g /etc/apt/sources.list.d/ros2-latest.list
	[ "$ubuntuVersion" == '21.04' ] && sudo sed -i 's/xenial/hirsute/'g /etc/apt/sources.list.d/ros2-latest.list
	[ "$ubuntuVersion" == '22.04' ] && sudo sed -i 's/xenial/jammy/'g /etc/apt/sources.list.d/ros2-latest.list
}

function set_bfsu(){
	echo -e "${GREEN}###set sources from mirrors.bfsu.edu.cn####${PLAIN}"	
	sudo sed -i 's/packages.ros.org/mirrors.bfsu.edu.cn/'g /etc/apt/sources.list.d/ros2-latest.list
}

function set_ustc(){
	echo -e "${GREEN}###set sources from mirrors.ustc.edu.cn####${PLAIN}"
	sudo sed -i 's/packages.ros.org/mirrors.ustc.edu.cn/'g /etc/apt/sources.list.d/ros2-latest.list
}

function set_sjtu(){
	echo -e "${GREEN}###set sources from mirrors.sjtug.sjtu.edu.cn####${PLAIN}"
	sudo sed -i 's/packages.ros.org/mirrors.sjtug.sjtu.edu.cn/'g /etc/apt/sources.list.d/ros2-latest.list
}

function set_aliyun(){
	echo -e "${GREEN}###set sources from mirrors.aliyun.com####${PLAIN}"		
	sudo sed -i 's/packages.ros.org/mirrors.aliyun.com/'g /etc/apt/sources.list.d/ros2-latest.list
}

function set_tsinghua(){
	echo -e "${GREEN}###set sources from mirrors.tuna.tsinghua.edu.cn####${PLAIN}"		
	sudo sed -i 's/packages.ros.org/mirrors.tuna.tsinghua.edu.cn/'g /etc/apt/sources.list.d/ros2-latest.list
}

function restore(){
	if [ -f /etc/apt/sources.list.d/ros2-latest.list.bak ]; then
		sudo rm /etc/apt/sources.list.d/ros2-latest.list
		sudo mv /etc/apt/sources.list.d/ros2-latest.list.bak /etc/apt/sources.list.d/ros2-latest.list
	fi
	echo -e "${GREEN}###restore sources from backup file####${PLAIN}"
}

function set_sources(){
	get_about
	update_init

	# need choice
	echo "请问你需要变更ROS2源吗? 不需要的话，直接回车即可"
	echo "ROS官方源请输入 - ros"
	echo "清华大学源请输入 - tsinghua"
	echo "阿里云请输入 - aliyun"	
	echo "北京外国语大学请输入 - bfsu" 
	echo "中国科技大学源请输入 - ustc"
	echo "恢复到上一次 - restore"
	CHOICE_A=$(echo -e "\n Please input source ：")
	read -p "${CHOICE_A}" para	
	case "$release" in
		ubuntu)
			case $para in
			  'ros'|'-ros'|'--ros' )
				  set_ubuntu;;				
			  'ustc'|'-ustc'|'--ustc' )
				  set_ubuntu;set_ustc;;			
			  'bfsu'|'-bfsu'|'--bfsu' )
				  set_ubuntu;set_bfsu;;
			  'tsinghua'|'-tsinghua'|'--tsinghua' )
				  set_ubuntu;set_tsinghua;;
				'aliyun'|'-aliyun'|'--aliyun' )
					set_ubuntu;set_aliyun;;
				'sjtu'|'-sjtu'|'--sjtu' )
					set_ubuntu;set_sjtu;;
				'restore'|'-restore'|'--restore' )
					restore;;
				'h'|'-h'|'--h' )
				  get_help;;					
			  * );;
			esac
			sudo apt update;;
	esac
}

para=$1
set_sources
echo -e "${GREEN}Update ros2 source is Done${PLAIN}"
