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

# check if exits, if not mkdir it
function check_directory(){
  if [ ! -d ~/$1 ];then 
    mkdir -p ~/$1/src
  fi  
}

# check the package if installed
function check_package(){
  if [ -d ~/$1/src/$2 ];then 
    echo "$2 have installed" && exit 0
  fi 
}

# check ros if installed
fucntion check_ros() {
  local result=`ls -A "/opt/ros/" |wc -w`
  if [ $result == 0 ]; then 
    echo "You still not install ROS, Please install first "
    echo "If want to install ros2 , run:  rcm ros2 install_ros2_now "
    echo "If want to install ros1 , run:  rcm ros1 install_ros1_now "
    exit 1
  else
    echo 1
  fi
}

# check ros if source 
function check_ros_source() {
  if [ $ROS_DISTRO == "" ]; then 
    local result=check_ros
    if [ $result == 1 ]; then 
      echo "You have installed ros, but still not source it , please source first!"
      echo "You have installed ros version: " `ls -A "/opt/ros/"`
      echo "Input Commands: source /opt/ros/<ROS_DISTRO>/setup.bash"
    fi 
  fi
}

# ros version if installed 
function check_ros_version() {
  if [ -f /opt/ros/$1/setup.bash ]; then
    echo "You have installed ROS Version $1"
    exit
  fi
}


