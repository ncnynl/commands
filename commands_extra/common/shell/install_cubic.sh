#!/bin/bash
################################################
# Function : install_cubic.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-21                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################

#usage:https://www.ncnynl.com/archives/202210/5484.html
#add ppa 

sudo apt-add-repository ppa:cubic-wizard/release 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6494C6D6997C215E


#install 
sudo apt update && sudo apt install cubic -y 