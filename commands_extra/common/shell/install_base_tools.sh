#!/bin/bash
################################################
# Function : install vscode.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-25 17:12:05                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
        
#if vim error , maybe sudo apt-get remove vim-common
#https://askubuntu.com/questions/168069/problem-installing-vim

echo "install git vim terminator ssh chromium-browser tree cheese "
sudo apt install wget curl git vim terminator ssh chromium-browser tree cheese mesa-utils -y 

echo "install video and audio tools"
sudo apt install audacity simplescreenrecorder kazam vlc -y

echo "install database: mosquitto sqlite3"
sudo apt install -y sqlite3  mosquitto mosquitto-clients -y


