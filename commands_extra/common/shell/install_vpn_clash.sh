#!/bin/bash
################################################
# Function : install vpn class 
# Desc     : 用于安装VPN软件class的脚本                               
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-14 17:17:58                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#https://mahongfei.com/1776.html
#https://github.com/Fndroid/clash_for_windows_pkg/releases
#安装最新版本的vpn clash for ubuntu
#下载
wget "https://ghproxy.com/https://github.com/Fndroid/clash_for_windows_pkg/releases/download/0.20.7/Clash.for.Windows-0.20.7-x64-linux.tar.gz"

#解压
tar -zxvf Clash.for.Windows-0.19.16-x64-linux.tar.gz

#设置权限 
cd Clash.for.Windows-0.19.16-x64-linux
chmod +x cfw

#查看版本 


