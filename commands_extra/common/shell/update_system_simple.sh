#!/usr/bin/env bash
################################################
# Function : Update system mirrors shell 2
# Desc     : 用于简化版更新系统源的脚本2                              
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Update system mirrors shell 2")"  

#
# Copyright (C) 2017 - 2018 Oldking <oooldking@gmail.com>
#
# URL: https://www.oldking.net/697.html
#

# sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'

getAbout() {
	echo ""
	echo " ========================================================= "
	echo " \                 SuperUpdate.sh  Script                / "
	echo " \            Choose a faster mirror for Linux           / "
	echo " \                   Created by Oldking                  / "
	echo " ========================================================= "
	echo ""
	echo " Intro: https://www.oldking.net/697.html"
	echo " Copyright (C) 2018 Oldking oooldking@gmail.com"
	echo -e " Version: ${GREEN}1.0.3${PLAIN} (2 Nov 2018)"
	echo " Usage: wget -qO- git.io/superupdate.sh | bash"
	echo ""
}

getHelp(){
	echo " $( bash superupdate.sh )"
	echo " - set sources from cdn-fastly "
	echo " $( bash superupdate.sh cn ) "
	echo " - set sources from USTC "
	echo " $( bash superupdate.sh 163 ) "
	echo " - set sources from 163.com "
	echo " $( bash superupdate.sh aliyun ) "
	echo " - set sources from aliyun.com "
	echo " $( bash superupdate.sh aws ) "
	echo " - set sources from cdn-aws "
	echo " $( bash superupdate.sh restore ) "
	echo " - restore sources from backup file "
}

updateInit(){
	[[ $EUID -ne 0 ]] && echo -e " ${RED}Error:${PLAIN} This script must be run as root!" && exit 1

	if [ -f /etc/redhat-release ]; then
	    release="centos"
	elif cat /etc/issue | grep -Eqi "debian"; then
	    release="debian"
	elif cat /etc/issue | grep -Eqi "ubuntu"; then
	    release="ubuntu"
	elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
	    release="centos"
	elif cat /proc/version | grep -Eqi "debian"; then
	    release="debian"
	elif cat /proc/version | grep -Eqi "ubuntu"; then
	    release="ubuntu"
	elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
	    release="centos"
	fi

	if [ $release == "debian" ]; then
		debianVersion=$(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)
	elif [ $release == "ubuntu" ]; then
		ubuntuVersion=$(awk -F'[= "]' '/VERSION_ID/{print $3}' /etc/os-release)
	elif [ $release == "centos" ]; then
		os_release=$(grep "CentOS" /etc/redhat-release 2>/dev/null)
		if echo "$os_release"|grep "release 5" >/dev/null 2>&1
		then
			centosVersion=5
		elif echo "$os_release"|grep "release 6" >/dev/null 2>&1
		then
			centosVersion=6
		elif echo "$os_release"|grep "release 7" >/dev/null 2>&1
		then
			centosVersion=7
		else
			centosVersion=""
		fi
	else
		echo -e " ${RED}Error:${PLAIN} This script can not be run in your system now!" && exit 1
	fi
}

setUbuntu(){
	if [[ -f /etc/apt/sources.list.bak ]]; then
		echo -e " ${GREEN}sources.list.bak exists${PLAIN}"
	else
		mv /etc/apt/sources.list{,.bak}
	fi

	[ -f /etc/apt/sources.list ] && rm /etc/apt/sources.list

	echo "deb http://archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb http://archive.ubuntu.com/ubuntu/ xenial-security main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse" >>/etc/apt/sources.list
	echo "deb http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse" >>/etc/apt/sources.list

	[ "$ubuntuVersion" == '14.04' ] && sed -i 's/xenial/trusty/'g /etc/apt/sources.list
	[ "$ubuntuVersion" == '16.06' ] && echo -n ""
	[ "$ubuntuVersion" == '18.04' ] && sed -i 's/xenial/bionic/'g /etc/apt/sources.list
	[ "$ubuntuVersion" == '20.04' ] && sed -i 's/xenial/focal/'g /etc/apt/sources.list
	[ "$ubuntuVersion" == '21.04' ] && sed -i 's/xenial/hirsute/'g /etc/apt/sources.list
	[ "$ubuntuVersion" == '22.04' ] && sed -i 's/xenial/jammy/'g /etc/apt/sources.list
}

setAWS(){
	sed -i 's/archive.ubuntu.com/cdn-aws.deb.debian.org/'g /etc/apt/sources.list
}

setCn(){
	sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/'g /etc/apt/sources.list
}

set163(){
	sed -i 's/archive.ubuntu.com/mirrors.163.com/'g /etc/apt/sources.list
}

setAliyun(){
	sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/'g /etc/apt/sources.list
}

restore(){
	if [ -f /etc/apt/sources.list.bak ]; then
		rm /etc/apt/sources.list
		mv /etc/apt/sources.list.bak /etc/apt/sources.list
	elif [ -f /etc/yum.repos.d/CentOS-Base.repo.bak ]; then
		rm /etc/yum.repos.d/CentOS-Base.repo
		mv /etc/yum.repos.d/CentOS-Base.repo.bak /etc/yum.repos.d/CentOS-Base.repo
	fi
}

setSources(){
	getAbout
	updateInit
	echo "请问你需要变更系统源吗? 不需要的话，直接回车即可"
	echo "ubuntu官方源请输入 - ubu"
	echo "清华大学源请输入 - ustc"
	echo "中国科学技术大学源请输入 - ustc"
	echo "阿里云源请输入 - 163"
	echo "163源请输入 - aliyun"
	echo "aws源请输入 - aws"
	echo "恢复到上一次 - restore"
	CHOICE_A=$(echo -e "\n Please input source ：")
	read -p "${CHOICE_A}" para			
	case $para in
		'ubu'|'-ubu'|'--ubu' )
			setUbuntu;;
		'ustc'|'-ustc'|'--ustc' )
			setUbuntu;setCn;;
		'163'|'-163'|'--163' )
			setUbuntu;set163;;
		'aliyun'|'-aliyun'|'--aliyun' )
			setUbuntu;setAliyun;;
		'aws'|'-aws'|'--aws' )
			setUbuntu;setAWS;;			
		'restore'|'-restore'|'--restore' )
			restore;;
		*);;
	esac
	apt-get update
}

para=$1
setSources
echo -e "${GREEN}Done${PLAIN}"
