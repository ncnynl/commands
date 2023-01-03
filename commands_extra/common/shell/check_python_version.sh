#!/bin/bash
################################################
# Function : Check Python Version                            
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

PY3_VERSION=`python3 -V 2>&1|awk '{print $2}'|awk -F '.' '{print $1}'`

PY2_VERSION=`python2 -V 2>&1|awk '{print $2}'|awk -F '.' '{print $1}'`

if (( $PY3_VERSION == 3 ))
then
    echo "Your Python3 Version: "  
    python3 -V
fi

if (( $PY2_VERSION == 2 ))
then
    echo "Your Python2 Version: "  
    python2 -V
else

    if [[ $PY3_VERSION -ne 3 ]] ; then 
        echo "Python don't installed!"
    fi

fi

