#!/bin/bash
################################################################
# Function :ROS Commands Manager Uninstall Script                #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-06-23                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################


echo -e "Start to uninstall package $package to your system now!!!"


#######################################
# Rm Package
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   ubuntu
# Outputs:
#    echo to stdout
#######################################
function rm_package(){
    #delete desktop version
    if [ -f /usr/bin/commands ]; then
        sudo rm -f /usr/bin/commands
    fi 

    if [  -d /usr/local/commands/ ]; then
        sudo rm -rf /usr/local/commands/
    fi 

    #delete shell cs
    if [ -L /usr/bin/cs ]; then
        sudo rm -f /usr/bin/cs
    fi 

    #delete shell rcm
    if [ -L /usr/bin/rcm ]; then
        sudo rm -f /usr/bin/rcm
    fi

    #delete source folder
    if [ -d /tools/commands ]; then
        sudo rm -f /tools/commands
    fi

    echo 0
}

re=$(rm_package)
if [[ $re == 0 ]]; then
    echo -e "Delete files and folders Successfully!"
fi


#######################################
# Rm Package Extra
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   ubuntu
# Outputs:
#    echo to stdout
#######################################
#rm commands_extra
# if [  -d ~/commands ]; then
#   sudo rm -rf  ~/commands/
# fi

echo -e "Uninstall Finished"


