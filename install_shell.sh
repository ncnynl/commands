#!/bin/bash
################################################################
# Function :ROS Commands Manager Shell Version                 #
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

#install commands_extra
~/tools/commands/install_extra.sh


echo -e "All Install Finished"


