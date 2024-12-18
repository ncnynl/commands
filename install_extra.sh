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

    #give perm to  *.sh
    find ~/tools/commands/commands_extra/ -type f -iname '*.sh' | xargs chmod +x
    rsync -a ~/tools/commands/commands_extra/* ~/commands/
    sudo chown -R $USER:$USER ~/commands/
    
    #rm cs
    if [ -L /usr/bin/cs ]; then
        sudo rm /usr/bin/cs
    fi 
    #rm rcm
    if [ -L /usr/bin/rcm ]; then
        sudo rm /usr/bin/rcm
    fi 

    #fixed 2023-05-30
    if [ -f ~/tools/commands/commands_extra/common/package.json ];then 
        rm ~/tools/commands/commands_extra/common/package.json
        rm ~/tools/commands/commands_extra/common/package-lock.json
    fi 

    if [ -f ~/commands/common/package.json ];then 
        rm ~/commands/common/package.json
        rm ~/commands/common/package-lock.json
    fi 

    #add commands shell
    #if have same name cs of other software , use rcm
    if [ ! -f /usr/bin/rcm ] ; then
        sudo ln -s ~/commands/cs.sh /usr/bin/cs
        sudo ln -s ~/commands/cs.sh /usr/bin/rcm
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
# install rsync 
rsync_exits=$(which is rsync)
if [ ! $rsync_exits ]; then
    sudo apt install -y rsync 
fi 

echo -e "Install package extra Finished"


