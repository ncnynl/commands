#!/bin/bash
################################################################
# Function :ROS Commands Install desktop file                  #
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
function install_desktop(){

    # copy commands.desktop to $USER/.local/share/applications
    # can not run , *.desktop launch by root. will not load ~/.bashrc
    cd ~/tools/commands 
    if [ ! -d $HOME/.local/share/applications ]; then 
        mkdir -p $HOME/.local/share/applications/
    fi
    cp commands.desktop $HOME/.local/share/applications/commands.desktop

    echo 0
}
re=$(install_desktop)
if [[ $re == 0 ]] ; then
    echo -e "Install Desktop succesfully!"
else
    echo -e "Install Desktop failed"
fi

# copy commands.desktop to $USER/.local/share/applications
# can not run , *.desktop launch by root. will not load ~/.bashrc
# sudo cp commands.desktop $HOME/.local/share/applications/commands.desktop

echo -e "Install Desktop Finished"


