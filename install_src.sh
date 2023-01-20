#!/bin/bash
################################################################
# Function :Install commands desktop version source            #
# Platform :All Linux Based Platform                           #
# Version  :1.0                                                #
# Date     :2022-10-20                                         #
# Author   :ncnynl                                             #
# Contact  :1043931@qq.com                                     #
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   #
# URL: https://ncnynl.com                                      #
################################################################

# Fix error while loading shared libraries: libQt5Core.so.5
# https://github.com/dnschneid/crouton/wiki/Fix-error-while-loading-shared-libraries:-libQt5Core.so.5
# https://superuser.com/questions/1347723/arch-on-wsl-libqt5core-so-5-not-found-despite-being-installed
# whereis libQt5Core.so.5
# sudo strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5

#######################################
# build src
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   ubuntu
# Outputs:
#    echo to stdout
#######################################
function build_src()
{

    echo -e "Build venv for commands!"
    cd ~/tools/commands/
    # source venv/bin/activate
    cd commands_src
    #install python3 deps
    echo -e "Install python3 deps for commands"
    pip3 install -r requiments.txt 
    #build 
    export PATH=${HOME}/.local/bin:$PATH
    ./build.sh 
    #if succes?
    if [ -f ~/tools/commands/commands_src/dist/commands ]; then
        echo -e "Build src success!"
    fi     
    
}
build_src

#######################################
# Install  Package
# Globals: 
#   None
# Arguments:
#   None
# Return:
#   None
# Outputs:
#    echo to stdout
#######################################
function install_package(){
    if [ ! -d /usr/local/commands/ ]; then
        sudo mkdir -p /usr/local/commands/
    fi 
    if [ -f ~/tools/commands/commands_src/dist/commands ]; then
        sudo cp ~/tools/commands/commands_src/dist/commands /usr/local/commands/commands
    else
        echo -e "~/tools/commands/commands_src/dist/commands file is not found!"
        return 0
    fi 

    sudo cp ~/tools/commands/commands.png /usr/local/commands/commands.png
    sudo chown -R $USER:$USER /usr/local/commands/
    #rm 
    if [ -f /usr/bin/commands ]; then
        sudo rm /usr/bin/commands
    fi 

    sudo ln -s /usr/local/commands/commands /usr/bin/commands

    echo 0
}
re=$(install_package)
if [[ $re == 0 ]] ; then
    echo -e "Install package succesfully!"
else
    echo -e "Install package failed"
fi


