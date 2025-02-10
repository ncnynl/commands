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

source ${HOME}/commands/cs_variables.sh

# ros var 
ROS1LIST=('kinetic' 'melodic' 'noetic')
ROS2LIST=('foxy' 'galactic' 'humble' 'iron' 'rolling' 'jazzy')


function have_tested(){
  echo -e "${BLUE} This pachage have tested in $1 ${RESET}"
}

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
function check_ros() {
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
  if [[ "${ROS1LIST[@]}" =~ "$1" ]];then
    echo 1
  elif [[ "${ROS2LIST[@]}" =~ "$1" ]];then
    echo 2
  else
    echo 0
  fi
}

# edit script
function _rcm_edit_(){
    file=${0##*commands/}
    file_path="${HOME}/tools/commands/commands_extra/$file"
    echo "Your file path is : $file_path"
    echo "You are editing this file"
    if [ -f $file_path ]; then 
        vim $file_path
        echo "sync this file"
        rcm system build 
        echo "Done, You have successfully edited, Please run this file again"
    else 
        echo "This file path is : $file_path , but it is not right "
    fi 
    return 
}

# delete script
function _rcm_delete_(){

    run_file_path=$0
    file=${0##*commands/}
    source_file_path="${HOME}/tools/commands/commands_extra/$file"

    echo "This file have two version: run file and source file"
    echo "Your run file path is : $run_file_path"
    echo "Your source file path is : $source_file_path"
    CHOICE_C=$(echo -e "\n Do you want to delete the run file script? [Y/n]")
    read -p "${CHOICE_C}" YN
    [ -z ${YN} ] && YN = N
    case $YN in 
    [Yy])
        #delete
        if [ -f $run_file_path ]; then 
            rm -rf $run_file_path
            echo "Your run file path is : $run_file_path "
            echo "This file is deleted"
        else
            echo "THis file is not exists!"
        fi
        ;;
    *)
        echo "Your have canceled this operation!"
        return 
        ;;
    esac  

    CHOICE_C=$(echo -e "\n Do you want to delete the source file script? [Y/n]")
    read -p "${CHOICE_C}" YN
    [ -z ${YN} ] && YN = N
    case $YN in 
    [Yy])
        #delete
        if [ -f $source_file_path ]; then 
            rm -rf $source_file_path
            echo "Your source file path is : $source_file_path "
            echo "This file is deleted"
        else
            echo "THis file is not exists!"
        fi    
        ;;
    *)
        echo "Your have canceled this operation!"
        return 
        ;;
    esac  

    return 
}