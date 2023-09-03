#!/bin/bash
################################################################
# Function :Bash completion for ROS Commands Manager           #
# Platform :All Linux Based Platform                          #
# Version  :1.0                                                #
# Date     :2023-09-03                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

#######################################
# Install Bash completion
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################


function install_bash_completion(){
    echo "Add commands_completion.bash to bashrc if not exits"
    if ! grep -Fq "commands_completion.bash" ~/.bashrc
    then
        echo "source ~/tools/commands/commands_completion/commands_completion.bash" >> ~/.bashrc
        echo "commands_completion.bash have installed successfully! writed to ~/.bashrc"
    else
        echo "Has been inited before! Please check and source ~/.bashrc"
    fi        
}

install_bash_completion

echo -e "Install Bash Completion Finished"


