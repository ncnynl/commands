#!/bin/bash
################################################
# Function : config_date_shell.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-02 21:25:53                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
        

#run install chrony

# 安装TB3

sudo apt-get install chrony

#run install ntpdate

# 安装navigation

sudo apt-get install ntpdate

#run update 

# 安装键盘控制

sudo ntpdate ntp.ubuntu.com

#run launch date

# 输出最新日期时间

date

