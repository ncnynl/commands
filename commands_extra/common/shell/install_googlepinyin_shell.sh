#!/bin/bash
################################################
# Function : install googlepinyin shell  
# Desc     : 用于安装谷歌输入法googlepinyin的脚本                               
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
        

#run install fcitx

# 安装中文输入法

sudo apt-get install fcitx

#run install googlepinyin

# 安装谷歌中文输入法

sudo apt-get install fcitx fcitx-googlepinyin

#run reboot

# 重启系统

echo "please reboot system"

