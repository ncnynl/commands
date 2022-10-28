#!/bin/bash
################################################################
# Function :ROS Commands Manager Remote Install Script Docker  #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################



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
# exit 1

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
if [[ ! $cpu_release ]] ; then
    echo -e "This script can not be run in your system now!" && exit 1
fi

#######################################
# Install shell version 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   ubuntu
# Outputs:
#    echo to stdout
#######################################
function online_shell_install()
{
    #build folder
    if [[ ! -d ~/tools ]]; then 
        echo "#build ~/tools"
        mkdir ~/tools/
    fi

    #cd
    cd ~/tools/

    #git clone main repo
    if [[ -d ~/tools/commands ]]; then
        echo "#git pull"
        cd ~/tools/commands 
        git pull
    else
        echo "#git clone"
        git clone https://gitee.com/ncnynl/commands
    fi

    echo -e "Remote shell Install Finished"
}


#######################################
# Get  Package  version
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
function get_package_version(){
    package="1"
    if [ $1 == "18.04" ]; then
        if  [ $2 == "amd64" ]; then 
            package="rcm_ubuntu18.04_amd64"
            echo  "1" && exit 1
        elif [ $2 == "aarch64" ]; then 
            package="rcm_ubuntu18.04_aarch64"
            echo  "1" && exit 1
        fi
    elif [ $1 == "20.04" ]; then
        if  [ $2 == "amd64" ]; then 
            package="rcm_ubuntu20.04_amd64"
        elif [ $2 == "aarch64" ]; then 
            package="rcm_ubuntu20.04_aarch64"
            # install_deps
        fi
    else
        echo  "1" && exit 1
    fi

    echo $package
}

package=$(get_package_version $version $cpu_release)
if [[ $package == "1" ]] ; then
    echo -e " You only use shell version nor GUI version !" 
    online_shell_install
    cd ~/tools/commands/commands_extra/
    echo -e "Go to ~/tools/commands/commands_extra/" && exit 1
else
    echo -e "Start to install package $package to your system now!!!"
fi

#######################################
# Install 
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   ubuntu
# Outputs:
#    echo to stdout
#######################################
function online_install()
{
    #build folder
    if [[ ! -d ~/tools ]]; then 
        echo "#build ~/tools"
        mkdir ~/tools/
    fi

    #cd
    cd ~/tools/

    #git clone main repo
    if [[ -d ~/tools/commands ]]; then
        echo "#git pull"
        cd ~/tools/commands 
        git pull
    else
        echo "#git clone"
        git clone https://gitee.com/ncnynl/commands
    fi

    #git clone sub repo
    
    if [[ -d ~/tools/${package} ]]; then    
        echo "#git pull"    
        cd ~/tools/${package}
        git pull        
    else
        echo "#git clone"    
        git clone https://gitee.com/ncnynl/${package}
    fi

    #cp file to main repo 
    cd ~/tools/
    cp ${package}/commands_v* commands/

    #cd
    cd commands

    #set perm
    chmod +x install_docker.sh

    #to install
    ./install_docker.sh


    echo -e "Remote Install Finished"
}

#update 
#  apt-get update 

#install dep
#  apt-get install -y git gnome-terminal python3-pip python3-pyqt5 

#install commands
online_install


