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

echo "remove libreoffice"
sudo apt remove libreoffice-calc libreoffice-draw  libreoffice-impress libreoffice-writer  libreoffice-common
sudo apt autoremove


echo "remove system tools"
sudo apt remove unity-webapps-common thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines transmission-common gnome-orca gnome-sudoku deja-dup

