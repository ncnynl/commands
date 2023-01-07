#!/bin/bash
################################################
# Function : install ros2 rmf source shell  
# Desc     : 用于源码方式安装ROS2 galactic-level版RMF框架的脚本                            
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-07-06 18:22:04                            
# Author   : ncnynl                             
# Contact  : 1043931@qq.com                              
# URL: https://ncnynl.com                                   
# Licnese: MIT                                 
# QQ Qun: 创客智造B群:926779095                                  
# QQ Qun: 创客智造C群:937347681                               
# QQ Qun: 创客智造D群:562093920                               
################################################
#base on galactic-devel branch        

#安装gazebo源 
if [ ! -f /etc/apt/sources.list.d/gazebo-stable.list ];then
    sudo apt update
    sudo apt install -y wget
    sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
    wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
fi 


#添加依赖 
sudo apt update && sudo apt install \
  git cmake python3-vcstool curl \
  qt5-default \
  -y
python3 -m pip install flask-socketio 
sudo apt-get install python3-colcon* -y

#安装rosdep
# sudo apt install python3-rosdep
# sudo rosdep init
rosdep update

#新建目录
mkdir -p ~/ros2_rmf_ws/src
cd ~/ros2_rmf_ws
# wget https://raw.githubusercontent.com/open-rmf/rmf/release/21.09/rmf.repos
# rmf for 21.09
# echo "repositories:
#   rmf/rmf_battery:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_battery.git
#     version: 0.1.1
#   rmf/rmf_internal_msgs:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_internal_msgs.git
#     version: 1.4.0
#   rmf/rmf_ros2:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_ros2.git
#     version: 1.4.0
#   rmf/rmf_task:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_task.git
#     version: 1.0.0
#   rmf/rmf_traffic:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_traffic.git
#     version: 1.4.0
#   rmf/rmf_utils:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_utils.git
#     version: 1.3.0
#   rmf/rmf_cmake_uncrustify:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_cmake_uncrustify.git
#     version: 1.2.0
#   rmf/ament_cmake_catch2:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/ament_cmake_catch2.git
#     version: 1.2.0
#   rmf/rmf_visualization:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_visualization.git
#     version: 1.2.1
#   rmf/rmf_visualization_msgs:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_visualization_msgs.git
#     version: 1.2.0
#   rmf/rmf_building_map_msgs:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_building_map_msgs.git
#     version: 1.2.0
#   rmf/rmf_simulation:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_simulation.git
#     version: 1.3.0
#   rmf/rmf_traffic_editor:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_traffic_editor.git
#     version: 1.4.0
#   demonstrations/rmf_demos:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/rmf_demos.git
#     version: 1.3.1
#   thirdparty/menge_vendor:
#     type: git
#     url: https://ghproxy.com/https://github.com/open-rmf/menge_vendor.git
#     version: 1.0.0" > rmf.repos


# rmf for galactic
# https://github.com/open-rmf/rmf/blob/galactic/rmf.repos
echo "repositories:
  rmf/rmf_battery:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_battery.git
    version: galactic-devel
  rmf/rmf_internal_msgs:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_internal_msgs.git
    version: galactic-devel
  rmf/rmf_api_msgs:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_api_msgs.git
    version: galactic-devel
  rmf/rmf_ros2:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_ros2.git
    version: galactic-devel
  rmf/rmf_task:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_task.git
    version: galactic-devel
  rmf/rmf_traffic:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_traffic.git
    version: galactic-devel
  rmf/rmf_utils:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_utils.git
    version: galactic-devel
  rmf/ament_cmake_catch2:
    type: git
    url: https://ghproxy.com/https://ghproxy.com/https://ghproxy.com/https://github.com/open-rmf/ament_cmake_catch2.git
    version: galactic-devel
  rmf/rmf_visualization:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_visualization.git
    version: galactic-devel
  rmf/rmf_visualization_msgs:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_visualization_msgs.git
    version: galactic-devel
  rmf/rmf_building_map_msgs:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_building_map_msgs.git
    version: galactic-devel
  rmf/rmf_simulation:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_simulation.git
    version: galactic-devel
  rmf/rmf_traffic_editor:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_traffic_editor.git
    version: galactic-devel
  demonstrations/rmf_demos:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_demos.git
    version: galactic-devel
  thirdparty/menge_vendor:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/menge_vendor.git
    version: master
  thirdparty/nlohmann_json_schema_validator_vendor:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/nlohmann_json_schema_validator_vendor.git
    version: main
  thirdparty/pybind11_json_vendor:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/pybind11_json_vendor.git
    version: main
  thirdparty/ros_ign:
    type: git
    url: https://ghproxy.com/https://github.com/ignitionrobotics/ros_ign.git
    version: galactic" > rmf.repos

#下载源码 
vcs import src < rmf.repos

#自动安装依赖 
cd ~/ros2_rmf_ws
rosdep install --from-paths src --ignore-src --rosdistro galactic -y


#编译源码
cd ~/ros2_rmf_ws
source /opt/ros/galactic/setup.bash
colcon build --symlink-install --parallel-workers 1 --cmake-args -DCMAKE_BUILD_TYPE=Release 




