#!/bin/bash
################################################################
# Function :Update ROS1 Source                                 #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

#set Key
sudo apt-get update && sudo apt-get install curl gnupg lsb-release
sudo curl -sSL https://gitee.com/ncnynl/rosdistro/raw/master/ros.asc -o /usr/share/keyrings/ros-archive-keyring.gpg

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'

function get_about() {
	echo ""
	echo " ========================================================= "
	echo " \              Update ROS1 Source                       / "
	echo " ========================================================= "
	echo ""
	echo " Intro: https://ncnynl.com"
	echo " Copyright (C) 2022 ncnynl 1043931@qq.com"
	echo -e " Version: ${GREEN}1.0.0${PLAIN} (2022-02-23)"
	echo ""
}

get_help(){
	echo "Script Usage:"
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros1_source.sh${PLAIN}"
	echo -e "${GREEN}###set sources from packages.ros.org####${PLAIN}"	
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros1_source.sh ustc${PLAIN}"
	echo -e "${GREEN}###set sources from mirrors.ustc.edu.cn####${PLAIN}"	
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros1_source.sh sjtu${PLAIN}"
	echo -e "${GREEN}###set sources from mirrors.sjtug.sjtu.edu.cn####${PLAIN}"	
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros1_source.sh aliyun${PLAIN}"
	echo -e "${GREEN}###set sources from mirrors.aliyun.com####${PLAIN}"	
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros1_source.sh tsinghua${PLAIN}"
	echo -e "${GREEN}###set sources from mirrors.tuna.tsinghua.edu.cn####${PLAIN}"	
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros1_source.sh bfsu${PLAIN}"
	echo -e "${GREEN}###set sources from mirrors.bfsu.edu.cn####${PLAIN}"	
	echo "-----------------------------"	
	echo -e "${SKYBLUE}sudo ./update_ros1_source.sh restore${PLAIN}"
	echo -e "${GREEN}###restore sources from backup file####${PLAIN}"	
}

update_init(){
	[[ $EUID -ne 0 ]] && echo -e " ${RED}Error:${PLAIN} This script must be run as root!" && exit 1

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


set_ubuntu(){
	if [[ -f /etc/apt/sources.list.d/ros-latest.list.bak ]]; then
		echo -e " ${GREEN}ros-latest.list.bak exists${PLAIN}"
	else
		mv /etc/apt/sources.list.d/ros-latest.list{,.bak}
	fi

	[ -f /etc/apt/sources.list.d/ros-latest.list ] && rm /etc/apt/sources.list.d/ros-latest.list

	echo "deb http://packages.ros.org/ros/ubuntu xenial main" >> /etc/apt/sources.list.d/ros-latest.list

	[ "$ubuntuVersion" == '14.04' ] && sed -i 's/xenial/trusty/'g /etc/apt/sources.list.d/ros-latest.list
	[ "$ubuntuVersion" == '16.06' ] && echo -n ""
	[ "$ubuntuVersion" == '18.04' ] && sed -i 's/xenial/bionic/'g /etc/apt/sources.list.d/ros-latest.list
	[ "$ubuntuVersion" == '20.04' ] && sed -i 's/xenial/focal/'g /etc/apt/sources.list.d/ros-latest.list
	[ "$ubuntuVersion" == '21.04' ] && sed -i 's/xenial/hirsute/'g /etc/apt/sources.list.d/ros-latest.list
	[ "$ubuntuVersion" == '22.04' ] && sed -i 's/xenial/jammy/'g /etc/apt/sources.list.d/ros-latest.list
}

set_bfsu(){
	echo -e "${GREEN}###set sources from mirrors.bfsu.edu.cn####${PLAIN}"	
	sed -i 's/packages.ros.org/mirrors.bfsu.edu.cn/'g /etc/apt/sources.list.d/ros-latest.list
}

set_ustc(){
	echo -e "${GREEN}###set sources from mirrors.ustc.edu.cn####${PLAIN}"
	sed -i 's/packages.ros.org/mirrors.ustc.edu.cn/'g /etc/apt/sources.list.d/ros-latest.list
}

set_sjtu(){
	echo -e "${GREEN}###set sources from mirrors.sjtug.sjtu.edu.cn####${PLAIN}"
	sed -i 's/packages.ros.org/mirrors.sjtug.sjtu.edu.cn/'g /etc/apt/sources.list.d/ros-latest.list
}

set_aliyun(){
	echo -e "${GREEN}###set sources from mirrors.aliyun.com####${PLAIN}"		
	sed -i 's/packages.ros.org/mirrors.aliyun.com/'g /etc/apt/sources.list.d/ros-latest.list
}

set_tsinghua(){
	echo -e "${GREEN}###set sources from mirrors.tuna.tsinghua.edu.cn####${PLAIN}"		
	sed -i 's/packages.ros.org/mirrors.tuna.tsinghua.edu.cn/'g /etc/apt/sources.list.d/ros-latest.list
}

restore(){
	if [ -f /etc/apt/sources.list.d/ros-latest.list.bak ]; then
		rm /etc/apt/sources.list.d/ros-latest.list
		mv /etc/apt/sources.list.d/ros-latest.list.bak /etc/apt/sources.list.d/ros-latest.list
	fi
	echo -e "${GREEN}###restore sources from backup file####${PLAIN}"
}

set_sources(){
	get_about
	update_init
	case "$release" in
		ubuntu)
			case $para in
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
				  getHelp;;					
			  * )
			   set_ubuntu;
			esac
			apt-get update;;
	esac
}

para=$1
set_sources
echo -e "${GREEN}Update ros1 source is Done${PLAIN}"
