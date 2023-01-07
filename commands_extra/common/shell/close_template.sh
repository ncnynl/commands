#!/bin/bash
################################################
# Function : Close Commands           
# Desc     : 用于关闭RCM打开的脚本模板                     
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
PidFind(){   
    PIDCOUNT=`ps -ef | grep $1 | grep -v "grep" | grep -v $0 | awk '{print $2}' | wc -l`;  
    echo "Found process num: ${PIDCOUNT} "
    if [ ${PIDCOUNT} -gt 0 ] ; then  
        echo "There are ${PIDCOUNT} process contains name[$1]" 
        PID=`ps -ef | grep $1 | grep -v "grep" | awk '{print $2}'` ;
        echo "$1 's PID is: $PID"
        kill -9  ${PID};
        echo "$1 's PID has killed!";
    elif [ ${PIDCOUNT} -le 0 ] ; then 
        echo "No such process[$1]!"  
    fi  
} 

PidFind  '/install/'
PidFind  'ros-args'
# exit 1
