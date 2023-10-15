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
        echo "index-url=https://pypi.tuna.tsinghua.edu.cn/simple" >> ~/.pip/pip.conf
        echo "[install]" >> ~/.pip/pip.conf
        echo "trusted-host=pypi.tuna.tsinghua.edu.cn" >> ~/.pip/pip.conf    
    fi      
}
config_python3_source

#install commands_extra
~/tools/commands/install_extra.sh

#install i18n
~/tools/commands/install_i18n.sh

#install bash completion
~/tools/commands/install_completion.sh


echo -e "All Install Finished"


