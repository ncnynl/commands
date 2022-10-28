#!/bin/bash
################################################
# Function : update_python_to_3.8.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-25 18:08:16                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
#Not real test        

#run update

# 

sudo apt update
#run properties

# 

sudo apt install software-properties-common

#run repository

sudo add-apt-repository ppa:deadsnakes/ppa

#run install

# 

sudo apt install python3.8

#run alternatives

# 

sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

#run alternatives

# 

sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2

#run config

# 

sudo update-alternatives --config python3

