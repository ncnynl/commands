#!/bin/bash
################################################################
# Function :ROS Commands Manager Desktop Version              #
# Desc     :ROS命令管器桌面版                                    #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-10-20                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
alias GETTEXT='gettext "commands"'

function diskspace {
	clear
	df -k
}

function whoseon {
	clear
	who
}

function memusage {
	clear
	cat /proc/meminfo
}

function menu {
	clear
	echo
	echo -e "\t\t\tSys Admin Menu\n"
	echo -e "\t1. Display disk space"
	echo -e "\t2. Display logged on users"
	echo -e "\t3. Display memory usage"
	echo -e "\t0. Exit menu\n\n"
	echo -en "\t\tEnter an option: "
	read -n 1 option
}

while [ 1 ]
do
	menu
	case $option in
	0)
		break ;;
	1)
		diskspace ;;
	2)
		whoseon ;;
	3)
		memusage ;;
	*)
		clear
		echo "$(GETTEXT "Sorry, wrong selection")" ;;
	esac
	echo -en "\n\n\t\t\tHit any key to continue"
	read -n 1 line
done
clear
