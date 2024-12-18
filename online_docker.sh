#!/bin/bash
################################################################
# Function :ROS Commands Manager Docker Version Remote Install #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################
# this file move to commands_docker/rcmd.sh
#docker version
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


    #cd
    cd ~/tools/commands

    #set perm
    chmod +x install_docker.sh

    #to install
    ./install_docker.sh


    echo -e "Remote Install Finished"
}

#update 
apt-get update 

#install dep
apt-get install -y git rsync gettext

#install commands
online_install