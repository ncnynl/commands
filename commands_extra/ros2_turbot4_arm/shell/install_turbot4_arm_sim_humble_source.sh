#!/bin/bash
################################################
# Function : Install ROS2 humble Turbot4-ARM source version 
# Desc     : 用于源码方式安装Turbot4-ARM相关脚本(humble版)                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2024-07-09                           
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 humble Turbot4-ARM source version ")"

# echo "Not Supported Yet!"
# exit 0 
ros2_distro=humble 

echo ""
echo "Set workspace"
workspace=ros2_turbot4_arm_sim_ws

echo ""
echo "Set soft name"
soft_name=interbotix_ros_core

echo ""
echo "Workspace if exits ?"
if [ ! -d ~/$workspace ];then 
    mkdir -p ~/$workspace/src
fi 

echo ""
echo "Software if installed ?"
if [ -d ~/$workspace/src/$soft_name ];then 
    echo "$soft_name have installed" 
    # exit 0
fi 

echo ""
echo "Install system deps"
sudo apt install ros-$ros2_distro-pcl-ros

# 下载源码
echo ""
echo "Download source"
cd ~/$workspace/src
git clone -b $ros2_distro https://github.com/Interbotix/interbotix_ros_core.git
# git clone -b $ros2_distro https://github.com/Interbotix/interbotix_ros_rovers.git
git clone -b $ros2_distro https://gitee.com/ncnynl/interbotix_ros_rovers.git
git clone -b $ros2_distro https://github.com/Interbotix/interbotix_ros_toolboxes.git
# git clone -b $ros2_distro https://github.com/Interbotix/interbotix_ros_manipulators.git
git clone -b $ros2_distro https://gitee.com/ncnynl/interbotix_ros_manipulators.git
git clone -b ros2 https://github.com/ros-planning/moveit_visual_tools.git 
git clone -b $ros2_distro https://github.com/iRobotEducation/create3_sim.git

echo "rm COLCON_IGNORE"
rm                                                                                                  \
    interbotix_ros_toolboxes/interbotix_perception_toolbox/COLCON_IGNORE                              \
    interbotix_ros_toolboxes/interbotix_common_toolbox/interbotix_moveit_interface/COLCON_IGNORE      \
    interbotix_ros_toolboxes/interbotix_common_toolbox/interbotix_moveit_interface_msgs/COLCON_IGNORE \                                                                                              \
    interbotix_ros_manipulators/interbotix_ros_xsarms/interbotix_xsarm_perception/COLCON_IGNORE     \
    interbotix_ros_toolboxes/interbotix_perception_toolbox/COLCON_IGNORE                             \
    interbotix_ros_core/interbotix_ros_xseries/COLCON_IGNORE                                          


echo "interbotix_ros_core submodule"
cd ~/$workspace/src/interbotix_ros_core
git submodule update --init interbotix_ros_xseries/dynamixel_workbench_toolbox
git submodule update --init interbotix_ros_xseries/interbotix_xs_driver

echo "interbotix_xs_sdk udev"
cd ~/$workspace/src/interbotix_ros_core/interbotix_ros_xseries/interbotix_xs_sdk
sudo cp 99-interbotix-udev.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger

#install by rosdep
# cd ~/$workspace/src
# echo "irobot_create_msgs"
# git clone -b $ros2_distro https://github.com/iRobotEducation/irobot_create_msgs.git 

echo ""
echo "Install rosdeps"
# cs -si update_rosdep_tsinghua
cd ~/$workspace/
rosdep install --from-paths src --ignore-src --rosdistro ${ros2_distro} -y

# if all package downloaded?
package_noinstall=""
if [ ! -d ~/$workspace/src/interbotix_ros_core ];then 
package_noinstall=interbotix_ros_core
elif [ ! -d ~/$workspace/src/interbotix_ros_toolboxes ]; then 
package_noinstall=interbotix_ros_toolboxes
elif [ ! -d ~/$workspace/src/interbotix_ros_rovers ]; then 
package_noinstall=interbotix_ros_rovers
elif [ ! -d ~/$workspace/src/interbotix_ros_manipulators ]; then 
package_noinstall=interbotix_ros_manipulators
elif [ ! -d ~/$workspace/src/moveit_visual_tools ]; then 
package_noinstall=moveit_visual_tools
elif [ ! -d ~/$workspace/src/interbotix_ros_core/interbotix_ros_xseries/dynamixel_workbench_toolbox ]; then 
package_noinstall=dynamixel_workbench_toolbox
elif [ ! -d ~/$workspace/src/interbotix_ros_core/interbotix_ros_xseries/interbotix_xs_driver ]; then 
package_noinstall=interbotix_xs_driver
elif [ ! -d ~/$workspace/src/create3_sim ]; then 
package_noinstall=create3_sim
else
    echo "All Package is downloaded "
fi 

if [ ${package_noinstall} ]; then 
    echo "package $package_noinstall is not installed "
    exit 0
fi

# 编译代码
echo "Compile source"
cd ~/$workspace/
colcon build --symlink-install  --executor sequential



echo "Add workspace to bashrc if not exits"
if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
then
    echo  "configures Turbot4-ARM's computer's RMW"

    echo "export INTERBOTIX_XSLOCOBOT_BASE_TYPE=create3" >> ~/.bashrc
    echo "export INTERBOTIX_XSLOCOBOT_ROBOT_MODEL=locobot_wx250s" >> ~/.bashrc
    
    # if [ -z "$ROS_DISCOVERY_SERVER" ]; then
    #     echo "export RMW_IMPLEMENTATION=rmw_fastrtps_cpp" >> ~/.bashrc
    #     FASTRTPS_DEFAULT_PROFILES_FILE=~/$workspace/src/interbotix_ros_rovers/interbotix_ros_xslocobots/install/resources/super_client_configuration_file.xml
    #     echo "export FASTRTPS_DEFAULT_PROFILES_FILE=${FASTRTPS_DEFAULT_PROFILES_FILE}" >> ~/.bashrc
    #     echo "export ROS_DISCOVERY_SERVER=127.0.0.1:11811" >> ~/.bashrc
    #     sudo cp "~/$workspace"/src/interbotix_ros_rovers/interbotix_ros_xslocobots/install/resources/service/fastdds_disc_server.service /lib/systemd/system/
    #     sudo systemctl daemon-reload
    #     sudo systemctl enable fastdds_disc_server.service
    # fi

    echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
    echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
else
    echo "Has been inited before! Please check ~/.bashrc"
fi

#How to use
# ros2 pkg list | grep interbotix_