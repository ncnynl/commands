#!/bin/bash
################################################################
# Function :ROS Commands Manager Desktop Version Remote Install#
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-10-20                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################


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


    #cd
    cd ~/tools/commands

    #set perm
    sudo chmod +x install.sh

    #to install
    ./install.sh


    echo -e "Remote Install Finished"
}

#update 
sudo apt-get update 

#install dep
sudo apt-get install -y git gnome-terminal python3-pip python3-pyqt5 


#install commands
online_install


