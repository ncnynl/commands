#!/bin/bash
################################################
# Function : install_ublox_gps_shell.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-03 02:27:37                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
        

#run install  serial

#run mkdir

# 
if [ ! -d ~/ros1_sensor_ws/src/ ];then
    mkdir  -p ~/ros1_sensor_ws/src/
fi

#run cd

# 

cd ~/ros1_sensor_ws/src/

#run git clone

# 

git clone https://ghproxy.com/https://github.com/ncnynl/ublox

#run cd

# 

cd ..

#run catkin_make

# 

catkin_make 


#run 

# 

cd ~/ros1_sensor_ws/src/ublox/ublox_gps/script

#run 

# 

sudo ./gps.sh


#replug usb

echo "Please re-connect usb! Try launch"


