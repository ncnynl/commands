#!/bin/bash
################################################
# Function : Test echo shell   
# Desc     : 用于检测嵌套连续执行是否正常工作的脚本                           
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

echo "Test 1"        
cs -s check_echo_shell.sh 

echo "Test 2"
cs -si check_echo_shell.sh 

