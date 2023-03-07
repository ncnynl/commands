#!/bin/bash
################################################
# Function : Check echo shell  
# Desc     : 用于检测RCM是否正常工作的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-06-28 19:14:02                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                          
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Check echo shell")"
#run echo 1

# echo 1
echo "$(gettext "Test First")"
echo 1

#run echo 2

# echo 2
echo "$(gettext "Test Second")"
echo 2

#run echo 3

# echo 3
echo "$(gettext "Test Three")"
echo 3

#run echo 4

# echo 4
echo "$(gettext "Test Four")"
echo 4

#run echo 5

# echo 5
echo "$(gettext "Test Five")"
echo 5

#run echo 6

# echo 6
echo "$(gettext "Test Six")"
echo 6


echo "$(gettext "Test Seven")"
echo 7