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
sudo apt install git vim terminator ssh chromium-browser tree cheese -y 

echo "install 录制工具"
sudo apt install audacity simplescreenrecorder kazam vlc -y


