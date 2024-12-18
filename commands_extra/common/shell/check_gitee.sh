#!/bin/bash
################################################
# Function : Check Gitee Site          
# Desc     : 用于检查是否可以访问github网站脚本
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-24 15:17:32                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Check Gitee Site")"


cd ~

git clone https://gitee.com/ncnynl/test rcm_check_gitee

if [ -d ~/rcm_check_gitee ]; then
    echo "Download successful"
    rm -rf  ~/rcm_check_gitee
else
    echo "Download fail"
fi