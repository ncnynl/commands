#!/bin/bash
################################################################
# Function :ROS Commands Manager Install Script                #
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
    sudo apt-get update | sudo apt-get install -y gnome-terminal python3-pip python3-pyqt5 
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
function config_venv()
{
    echo -e "Check venv if exits, if not add !"
    if [ ! -d ~/tools/commands/venv ]; then
        virtualenv -p python3 venv
    fi
}
# config_venv

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

cd ~/tools/commands
./install_extra.sh

# copy commands.desktop to $USER/.local/share/applications
# can not run , *.desktop launch by root. will not load ~/.bashrc
cp commands.desktop $HOME/.local/share/applications/commands.desktop

echo -e "Install Finished"


