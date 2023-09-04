#!/bin/bash
################################################################
# Function :Desktop Shell                                      #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-11-01                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

#source bashrc
. $HOME/.bashrc

#source ros
if [ $ROS_DISTRO ];then
    source /opt/ros/$ROS_DISTRO/setup.bash
fi

#launch commands
# /usr/local/commands/commands
/usr/local/commands/rcm-gui
