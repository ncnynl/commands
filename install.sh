#!/bin/bash
################################################################
# Function :ROS Commands Manager Desktop Version               #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-10-20                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

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
    sudo apt update 
    sudo apt install -y gnome-terminal python3-pip python3-pyqt5 
}
echo -e "Install system deps!"
install_deps

#python3 resource
function config_python3_source()
{
    echo -e "Check pip.conf if exits, if not add !"
    if [ ! -f ~/.pip/pip.conf ]; then
        mkdir ~/.pip 
        touch ~/.pip/pip.conf
        echo "[global]" >> ~/.pip/pip.conf
        echo "index-url=http://pypi.douban.com/simple" >> ~/.pip/pip.conf
        echo "[install]" >> ~/.pip/pip.conf
        echo "trusted-host=pypi.douban.com" >> ~/.pip/pip.conf    
    fi      
}
config_python3_source

#python3 resource
# function config_venv()
# {
#     echo -e "Check venv if exits, if not add !"
#     if [ ! -d ~/tools/commands/venv ]; then
#         virtualenv -p python3 venv
#     fi
# }
# config_venv

#install commands_src
# ~/tools/commands/install_src.sh
~/tools/commands/install_gui.sh

#install commands_extra
~/tools/commands/install_extra.sh

#install i18n
~/tools/commands/install_i18n.sh

#install desktop
~/tools/commands/install_desktop.sh

#install bash completion
~/tools/commands/install_completion.sh

echo -e "All Install Finished"


