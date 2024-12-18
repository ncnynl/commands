#!/bin/bash
################################################################
# Function : Configure CYCLONEDDS_URI                                   
# Desc     : 配置CYCLONEDDS_URI
# Platform :All Linux Based Platform                           
# Version  :1.0                                                
# Date     :2024-07-06                                         
# Author   :ncnynl                                             
# Contact  :1043931@qq.com                                     
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.   
# URL: https://www.ncnynl.com/archives/202206/5268.html                                   
################################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Configure CYCLONEDDS_URI")"

echo "export CYCLONEDDS_URI=\"<CycloneDDS><Domain><General><DontRoute>true</></></></>\"" >> ~/.bashrc
