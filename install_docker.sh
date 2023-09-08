#!/bin/bash
################################################################
# Function :ROS Commands Manager Docker version                #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################


#docker version 
#
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
~/tools/commands/install_docker_extra.sh

#install i18n
# ~/tools/commands/install_i18n.sh

#install bash completion
# ~/tools/commands/install_completion.sh


echo -e "All Install Finished"