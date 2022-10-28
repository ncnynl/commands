#!/bin/bash
################################################
# Function : install_ros2_tb4_source.sh                              
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-06 16:19:08                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
        

#run 
mkdir -p ~/ros2_tb4_ws/src

#rosdep 
#rosdep 
pwd=$(pwd)
sh -c "$pwd/../common/shell/update_rosdep_tsinghua.sh"


# install  turtlebot4
echo "Download turtlebot4"
cd ~/ros2_tb4_ws/src
git clone -b galactic  https://ghproxy.com/https://github.com/turtlebot/turtlebot4.git
git clone -b galactic  https://ghproxy.com/https://github.com/iRobotEducation/create3_sim.git
git clone -b galactic  https://ghproxy.com/https://github.com/iRobotEducation/irobot_create_msgs.git
# cd ~/turtlebot4_ws
# vcs import src < src/turtlebot4/dependencies.repos
# rosdep install --from-path src -yi
# repositories:
#   create3_sim:
#     type: git
#     url: https://github.com/iRobotEducation/create3_sim.git
#     version: main
#   irobot_create_msgs:
#     type: git
#     url: https://github.com/iRobotEducation/irobot_create_msgs.git
#     version: main
#run 

# source /opt/ros/galactic/setup.bash
# colcon build --symlink-install
# 

# 
echo "Download turtlebot4_robot"
cd ~/ros2_tb4_ws/src
git clone -b galactic  https://ghproxy.com/https://github.com/turtlebot/turtlebot4_robot.git
git clone -b main  https://ghproxy.com/https://github.com/luxonis/depthai-ros
git clone -b main  https://ghproxy.com/https://github.com/luxonis/depthai-ros-examples.git


#run 
# cd ~/turtlebot4_ws
# vcs import src < src/turtlebot4_robot/dependencies.repos
# rosdep install --from-path src -yi
# repositories:
#   irobot_create_msgs:
#     type: git
#     url: https://github.com/iRobotEducation/irobot_create_msgs.git
#     version: main
#   luxonis/depthai-ros:
#     type: git
#     url: https://github.com/luxonis/depthai-ros.git
#     version: main
#   luxonis/depthai-ros-examples:
#     type: git
#     url: https://github.com/luxonis/depthai-ros-examples.git
#     version: main
#   turtlebot4:
#     type: git
#     url: https://github.com/turtlebot/turtlebot4.git
#     version: galactic

# source /opt/ros/galactic/setup.bash
# colcon build --symlink-install

#run 
echo "Download turtlebot4_desktop"
cd ~/ros2_tb4_ws/src
git clone -b galactic  https://ghproxy.com/https://github.com/turtlebot/turtlebot4_desktop.git

cd ~/ros2_tb4_ws
rosdep install --from-path src -yi

#install dep 
sudo apt install -y \
python3-colcon-common-extensions \
python3-rosdep \
python3-vcstool

#run 

echo "Download turtlebot4_simulator"
cd ~/ros2_tb4_ws/src
git clone -b galactic  https://ghproxy.com/https://github.com/turtlebot/turtlebot4_simulator.git

# vcs import src < src/turtlebot4_simulator/dependencies.repos
# repositories:
#   irobot_create_msgs:
#     type: git
#     url: https://github.com/iRobotEducation/irobot_create_msgs.git
#     version: main
#   create3_sim:
#     type: git
#     url: https://github.com/iRobotEducation/create3_sim.git
#     version: main
#   turtlebot4:
#     type: git
#     url: https://github.com/turtlebot/turtlebot4.git
#     version: galactic
#   turtlebot4_desktop:
#     type: git
#     url: https://github.com/turtlebot/turtlebot4_desktop.git
#     version: galactic


# install dep
cd ~/ros2_tb4_ws
rosdep install --from-path src -yi

#build 

source /opt/ros/galactic/setup.bash
colcon build --symlink-install

# add workspace to ~/.bashrc
echo "source ~/ros2_tb4_ws/install/local_setup.bash" >> ~/.bashrc