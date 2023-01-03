#!/bin/bash
################################################################
# Function :ROS Commands Manager Shell Script                  #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-10-20                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

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
    #rm 
    if [ -L /usr/bin/cs ]; then
        sudo rm /usr/bin/cs
    fi 

    #add commands shell
    if [ ! -f /usr/bin/cs ] ; then
        sudo ln -s ~/commands/cs.sh /usr/bin/cs
    fi 

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

echo -e "Install package extra Finished"


