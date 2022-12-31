#!/bin/bash
################################################
# Function : install arduino.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-12-31                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                           
# QQ Qun: 创客智造D群:562093920                               
################################################
        
echo "Begin to Install boot-repair"

echo "Add repository"
sudo add-apt-repository ppa:yannubuntu/boot-repair

echo "sudo apt update"
sudo apt update 


echo "Install boot-repair"
sudo apt install boot-repair



