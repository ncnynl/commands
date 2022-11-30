#!/bin/bash
################################################
# Function : check_echo_shell.sh                              
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
        

#run echo 1

# echo 1

echo 1

#run echo 2

# echo 2

echo 2

#run echo 3

# echo 3

echo 3

#run echo 4

# echo 4

echo 4

#run echo 5

# echo 5

echo 5

#run echo 6

# echo 6

echo 6


#!/bin/bash
################################################
# Function : install_velodyne.sh                         
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-11-29                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#        
echo "Not Yet Supported!"
exit 0    
workspace=ros2_velodyne_ws

#workspace is exits ?
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

if [ -d ~/$workspace/src/velodyne ];then 
    echo "velodyne have installed" && exit 0
fi 

#install rosdeps
sudo apt install ros-${ROS-DISTRO}-diagnostic-updater
sudo apt install libpcap0.8-dev

# 下载源码
cd ~/$workspace/src
git clone -b galactic-devel https://github.com/ros-drivers/velodyne.git
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
cd ~/$workspace/
colcon build --symlink-install 

#add to bashrc if not exits
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi



