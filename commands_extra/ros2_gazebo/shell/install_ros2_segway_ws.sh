#!/bin/bash
################################################
# Function : Install ros2 segway gazebo shell  
# Desc     : 源码安装ros2 segway平衡车仿真脚本                      
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
# https://github.com/TixiaoShan/LIO-SAM/tree/ros2

export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ros2 segway gazebo shell")"
# echo "Not Supported Yet!"
# exit 0  
# for humble
cs -rv "humble"
if [ 1 == $? ];then 
    exit 0
fi

echo ""
echo "Set workspace"
workspace=ros2_segway_ws

echo ""
echo "Set soft name"
soft_name=segway_gazebo

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/src/$soft_name ];then 
    echo "$soft_name have installed" && exit 0
fi 

echo ""
echo "Install system deps"
sudo apt install ros-humble-gazebo-ros-pkgs -y
sudo apt install ros-humble-gazebo-ros -y
sudo apt install ros-humble-ros2-control -y
sudo apt install ros-humble-ros2-controllers -y

# 下载源码
echo ""
echo "Download source"
cd ~
git clone  http://gitee.com/ncnynl/ros2_segway_ws

echo ""
echo "Install rosdeps"
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y


# 编译代码
echo "Compile source"
cd ~/$workspace/
colcon build --symlink-install 

# add to ~/.bashrc
cs -ss load_ros2_segway_ws -add

# echo "Add workspace to bashrc if not exits"
# if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
# then
#     echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
#     echo "export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros2_segway_ws/src/segway_gazebo/models/" >> ~/.bashrc
#     echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
# else
#     echo "Has been inited before! Please check ~/.bashrc"
# fi

#How to use
# ros2 launch segway_gazebo segway_sim.launch.py
# ros2 run teleop_twist_keyboard teleop_twist_keyboard 