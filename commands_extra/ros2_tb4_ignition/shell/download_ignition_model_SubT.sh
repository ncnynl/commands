#!/bin/bash
################################################
# Function : download_gazebo_model_shell.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-02 01:45:01                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
        
# https://github.com/osrf/subt/pull/561/files        
# https://github.com/osrf/subt        
# https://github.com/osrf/subt/wiki
#run cd gazebo

sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'

wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

sudo apt-get update

sudo apt-get install libignition-fuel-tools5-dev

# ign fuel download -u https://fuel.gazebosim.org/1.0/OpenRobotics/models/Ambulance -v 4

echo "It will be taked a long time to download all model"

ign fuel download -v 4 -j 4 -u "https://fuel.ignitionrobotics.org/openrobotics/collections/SubT Tech Repo"

echo "Download models finished"
