#!/bin/bash
################################################
# Function : Install snap proxy      
# Desc     : 用于安装snap proxy的脚本                       
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install snap proxy")"

echo "Install proxyto download faster"
sudo snap install snap-store
sudo snap install snap-store-proxy
sudo snap install snap-store-proxy-client


# sudo snap set system proxy.https=socks5://127.0.0.1:1080
# sudo snap set system proxy.http=socks5://127.0.0.1:1080

# sudo snap set system proxy.http="http://192.168.0.16:10809"
# sudo snap set system proxy.https="http://192.168.0.16:10809"









