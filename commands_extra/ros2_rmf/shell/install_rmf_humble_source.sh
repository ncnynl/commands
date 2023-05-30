#!/bin/bash
################################################
# Function : Install ROS2 humble rmf apt version humble branch
# Desc     : 用于源码方式安装ROS2 humble版RMF框架的脚本  
# Website  : https://www.ncnynl.com/archives/202211/5751.html                          
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
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=commands        
echo "$(gettext "Install ROS2 humble rmf apt version humble branch")"

#base on 22.09 branch 
# https://github.com/open-rmf/rmf_demos.git
# echo "Not Yet Supported!"

if [ -d ~/ros2_rmf_ws ];then 
	echo "rmf have installed" && exit 0
fi
# exit 0

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
  -y
python3 -m pip install flask-socketio fastapi uvicorn datamodel_code_generator asyncio
sudo apt-get install python3-colcon* -y
sudo apt-get install libyaml-dev -y


#安装rosdep
# sudo apt install python3-rosdep
# sudo rosdep init
rosdep update

#新建目录
mkdir -p ~/ros2_rmf_ws/src
cd ~/ros2_rmf_ws
# wget https://raw.githubusercontent.com/open-rmf/rmf/release/22.09/rmf.repos
# rmf for 22.09
echo "repositories:
  rmf/rmf_battery:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_battery.git
    version: humble
  rmf/rmf_internal_msgs:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_internal_msgs.git
    version: humble
  rmf/rmf_api_msgs:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_api_msgs.git
    version: humble
  rmf/rmf_ros2:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_ros2.git
    version: humble
  rmf/rmf_task:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_task.git
    version: humble
  rmf/rmf_traffic:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_traffic.git
    version: humble
  rmf/rmf_utils:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_utils.git
    version: humble
  rmf/ament_cmake_catch2:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/ament_cmake_catch2.git
    version: humble
  rmf/rmf_visualization:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_visualization.git
    version: humble
  rmf/rmf_visualization_msgs:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_visualization_msgs.git
    version: humble
  rmf/rmf_building_map_msgs:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_building_map_msgs.git
    version: humble
  rmf/rmf_simulation:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_simulation.git
    version: humble
  rmf/rmf_traffic_editor:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_traffic_editor.git
    version: humble
  demonstrations/rmf_demos:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/rmf_demos.git
    version: humble
  thirdparty/menge_vendor:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/menge_vendor.git
    version: humble
  thirdparty/nlohmann_json_schema_validator_vendor:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/nlohmann_json_schema_validator_vendor.git
    version: humble
  thirdparty/pybind11_json_vendor:
    type: git
    url: https://ghproxy.com/https://github.com/open-rmf/pybind11_json_vendor.git
    version: humble" > rmf.repos

#下载源码 
vcs import src < rmf.repos

#自动安装依赖 
cd ~/ros2_rmf_ws
rosdep install --from-paths src --ignore-src --rosdistro humble -y

#issue for github.com/open-rmf/rmf_demos/issues/169
#issue for github.com/open-rmf/rmf/pull/272
sudo apt purge python3-websockets
python3 -m pip install websockets==10.4


# Install clang
sudo apt update
sudo apt install clang lldb lld

#Compile using clang
#Update colcon mixin which is a one time step:
colcon mixin add default https://ghproxy.com/https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml
colcon mixin update default


#Compile the workspace:
source /opt/ros/humble/setup.bash
cd ~/ros2_rmf_ws
export CXX=clang++
export CC=clang
colcon build  --mixin release lld
# colcon build --symlink-install --parallel-workers 1  --mixin release lld




