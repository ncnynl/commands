#!/bin/bash
################################################################
# Function :ROS Commands Manager Install Script                #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################


amd64_1804_version="1.0.9"
aarch64_1804_version="1.0.9"

amd64_2004_version="1.1.4"
aarch64_2004_version="1.1.4"

amd64_2204_version="1.1.4"
aarch64_2204_version="1.1.4"


#######################################
# Install Deps
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   ubuntu
# Outputs:
#    echo to stdout
#######################################
function install_deps()
{
    sudo apt-get update | sudo apt-get install -y gnome-terminal python3-pip python3-pyqt5 
}



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
    package=""
    if [ $1 == "18.04" ]; then
        if  [ $2 == "amd64" ]; then 
            package="commands_v${amd64_1804_version}_ubuntu${1}_amd64"
        elif [ $2 == "aarch64" ]; then 
            package="commands_v${aarch64_1804_version}_ubuntu${1}_aarch64"
            echo -e "This script can not be run in your system now!" && exit 1
        fi
    elif [ $1 == "20.04" ]; then
        if  [ $2 == "amd64" ]; then 
            package="commands_v${amd64_2004_version}_ubuntu${1}_amd64"
        elif [ $2 == "aarch64" ]; then 
            package="commands_v${aarch64_2004_version}_ubuntu${1}_aarch64"
            # install_deps
        fi
    elif [ $1 == "22.04" ]; then
        if  [ $2 == "amd64" ]; then 
            package="commands_v${amd64_2204_version}_ubuntu${1}_amd64"
        elif [ $2 == "aarch64" ]; then 
            package="commands_v${aarch64_2204_version}_ubuntu${1}_aarch64"
            # install_deps
        fi        
    else
        echo -e "This script can not be run in your system now!" && exit 1
    fi

    echo $package
}

package=$(get_package_version $version $cpu_release)
if [[ ! $package ]] ; then
    echo -e "This script can not be run in your system now!" && exit 1
else
    echo -e "Start to install package $package to your system now!!!"
fi

#######################################
# Get  RCM Package  version
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
function get_rcm_package(){
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
    elif [ $1 == "22.04" ]; then
        if  [ $2 == "amd64" ]; then 
            package="rcm_ubuntu22.04_amd64"
        elif [ $2 == "aarch64" ]; then 
            package="rcm_ubuntu22.04_aarch64"
            echo  "1" && exit 1
            # install_deps
        fi        
    else
        echo  "1" && exit 1
    fi

    echo $package
}

rcm_package=$(get_rcm_package $version $cpu_release)

#######################################
# Install  Package
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function install_package(){
    if [ ! -d /usr/local/commands/ ]; then
        sudo mkdir -p /usr/local/commands/
    fi 

    sudo cp ~/tools/$2/$1 /usr/local/commands/commands
    sudo cp commands.png /usr/local/commands/commands.png
    sudo chown -R $USER:$USER /usr/local/commands/
    #rm 
    if [ -f /usr/bin/commands ]; then
        sudo rm /usr/bin/commands
    fi 

    sudo ln -s /usr/local/commands/commands /usr/bin/commands

    echo 0
}
re=$(install_package $package $rcm_package)
if [[ $re == 0 ]] ; then
    echo -e "Install package succesfully!"
else
    echo -e "Install package failed"
fi


#######################################
# Install Pakcage Extra
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function install_package_extra(){
    if [ ! -d ~/commands ]; then
        sudo mkdir ~/commands
        sudo chown -R $USER:$USER ~/commands
    fi

    rsync -a ~/tools/commands/commands_extra/* ~/commands/
    sudo chown -R $USER:$USER ~/commands/

    echo 0
}
re=$(install_package_extra)
if [[ $re == 0 ]] ; then
    echo -e "Install package extra succesfully!"
else
    echo -e "Install package extra failed"
fi

# copy commands.desktop to $USER/.local/share/applications
# can not run , *.desktop launch by root. will not load ~/.bashrc
# sudo cp commands.desktop $HOME/.local/share/applications/commands.desktop

echo -e "Install Finished"


