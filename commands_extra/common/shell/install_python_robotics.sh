#!/bin/bash
################################################
# Function : Install PythonRobotics
# Desc     : 用于安装PythonRobotics的脚本                           
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-08-31                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# QQ Qun: 创客智造B群:926779095                                 
# QQ Qun: 创客智造C群:937347681                                  
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install PythonRobotics")"


if  [ -d $HOME/tools/PythonRobotics ]; then 
    echo "PythonRobotics have installed!"
else
        
    echo "Install PythonRobotics"

    cd $HOME/tools
    
    git clone https://github.com/AtsushiSakai/PythonRobotics.git

    # Go into the repository
    cd PythonRobotics
    # Install dependencies
    #fix matplotlib==3.7.2 to high
    sed -i 's/3.7.2/3.7.1/g' requirements/requirements.txt
    pip install -r requirements/requirements.txt

    # Run the app
    echo "PythonRobotics have successfully installed"
fi