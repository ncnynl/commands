#!/bin/bash
################################################
# Function : Install ros2 Omni wheel gazebo car shell  
# Desc     : 源码安装全向轮仿真小车的脚本    
# Website  : https://www.ncnynl.com/archives/202303/5842.html                   
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2023-03-10                          
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                
# Company  :Foshan AiZheTeng Information Technology Co.,Ltd.                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ros2 Omni wheel gazebo car shell")"
# echo "Not Supported Yet!"
# exit 0  
echo ""
echo "Set workspace"
workspace=ros2_omni_ws

echo ""
echo "Set soft name"
soft_name=omni_control

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/src/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"
sudo apt install ros-humble-gazebo-ros-pkgs -y
sudo apt install ros-humble-ros2-control -y
sudo apt install ros-humble-ros2-controllers -y
sudo apt install ros-humble-navigation2 -y
sudo apt install ros-humble-nav2-bringup -y
sudo apt install ros-humble-cartographer-ros -y

# 下载源码
echo ""
echo "Download source"
cd ~
git clone  http://gitee.com/ncnynl/ros2_omni_ws

echo ""
echo "Install rosdeps"
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
echo "Compile source"
cd ~/$workspace/
colcon build --symlink-install 


echo "Add workspace to bashrc if not exits"
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo "export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros2_omni_ws/src/gazebo_simulation/models/" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi
#How to use
# ros2 launch gazebo_simulation cartographer_slam.launch.py
# ros2 run nav2_map_server map_saver_cli -f omni_map
# ros2 launch gazebo_simulation gazebo_sim_launch_rf2o.py
# ros2 run teleop_twist_keyboard teleop_twist_keyboard
# ros2 control list_hardware_interfaces
# ros2 control list_controllers