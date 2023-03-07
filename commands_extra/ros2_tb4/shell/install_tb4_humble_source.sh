#!/bin/bash
################################################
# Function : Install ROS2 humble turtlebot4 and ignition source version 
# Desc     : 用于源码方式安装ROS2 humble版ignition仿真及TB4仿真程序的脚本                             
# Platform : ubuntu                                
# Version  : 1.0                               
# Date     : 2022-10-31                           
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
echo "$(gettext "Install ROS2 humble turtlebot4 and ignition source version")"

# echo "Not Yet Supported!"
# compile is pass, but run error when launch 
# exit 0


# if installed ?
# if [ -d ~/ros2_tb4_ws/src/turtlebot4_tutorials ]; then
#     echo "Turtlebot4 ignition have installed!!"

# else 

    # install dep

    sudo apt install -y  wget python3-colcon-common-extensions python3-rosdep  python3-vcstool
    #fix fatal error: 'rclcpp_components/register_node_macro.hpp' file not found
    sudo apt install -y ros-humble-rclcpp-components

    # 新建工作空间
    mkdir -p ~/ros2_tb4_ws/src

    #run cd ros2_tb4_ws

    # 进入工作空间

    cd ~/ros2_tb4_ws/src

    #run wget

    # 获取仓库列表

    git clone -b humble https://ghproxy.com/https://github.com/turtlebot/turtlebot4_simulator.git
    #fix ignition-gui5 to ignition-gui6
    if [ ${ROS_DISTRO} == "humble" ]; then
        sed -i 's/ignition-gui5/ignition-gui6/'g ~/ros2_tb4_ws/src/turtlebot4_simulator/turtlebot4_ignition_gui_plugins/package.xml
        sed -i 's/ignition-gui5/ignition-gui6/'g ~/ros2_tb4_ws/src/turtlebot4_simulator/turtlebot4_ignition_gui_plugins/Turtlebot4Hmi/CMakeLists.txt
    fi

    #run import
    echo "this will take 10-30 min to download"

    # 下载仓库
    echo "Dowload from irobot_create_msgs "

    git clone -b humble https://ghproxy.com/https://github.com/iRobotEducation/irobot_create_msgs.git

    echo "Dowload from create3_sim support namespace"
    # git clone -b humble https://ghproxy.com/https://github.com/iRobotEducation/create3_sim.git
    #commit e589410aa4ee483c4a3948c55a6b53c37118143a
    git clone -b asoragna/humble https://ghproxy.com/https://github.com/iRobotEducation/create3_sim.git
    # git clone -b feat/create3_namespace https://ghproxy.com/https://github.com/sp-sophia-labs/create3_sim.git
    #fix ignition-gui5 to ignition-gui6
    if [ ${ROS_DISTRO} == "humble" ]; then
        sed -i 's/ignition-gui5/ignition-gui6/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_plugins/package.xml
        sed -i 's/ignition-gui5/ignition-gui6/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_plugins/CMakeLists.txt
    fi
    # fix msg/dock.hpp to msg/dock_status.hpp
    #fix msg::Dock to msg::DockStatus
    # ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/include/irobot_create_nodes/robot_state.hpp
    # ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/src/robot_state.cpp
    # ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_toolbox/src/sensors/ir_opcode.cpp
    # ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_toolbox/include/irobot_create_ignition_toolbox/sensors/ir_opcode.hpp
    # ~/ros2_tb4_ws/src/create3_sim/irobot_create_gazebo/irobot_create_gazebo_plugins/include/irobot_create_gazebo_plugins/gazebo_ros_docking_status.hpp
    # ~/ros2_tb4_ws/src/create3_sim/irobot_create_gazebo/irobot_create_gazebo_plugins/src/gazebo_ros_docking_status.cpp

    # fix action/dock_servo.hpp to action/dock.hpp
    # fix action::DockServo to action::Dock 
    # ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/include/irobot_create_nodes/motion_control/docking_behavior.hpp
    # ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/src/motion_control/docking_behavior.cpp

    if [ ${ROS_DISTRO} == "humble" ]; then
        sed -i 's/msg\/dock.hpp/msg\/dock_status.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/include/irobot_create_nodes/robot_state.hpp
        sed -i 's/msg\/dock.hpp/msg\/dock_status.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/src/robot_state.cpp
        sed -i 's/msg\/dock.hpp/msg\/dock_status.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_toolbox/src/sensors/ir_opcode.cpp
        sed -i 's/msg\/dock.hpp/msg\/dock_status.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_toolbox/include/irobot_create_ignition_toolbox/sensors/ir_opcode.hpp
        sed -i 's/msg\/dock.hpp/msg\/dock_status.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_gazebo/irobot_create_gazebo_plugins/include/irobot_create_gazebo_plugins/gazebo_ros_docking_status.hpp
        sed -i 's/msg\/dock.hpp/msg\/dock_status.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_gazebo/irobot_create_gazebo_plugins/src/gazebo_ros_docking_status.cpp
        sed -i 's/msg\/dock.hpp/msg\/dock_status.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/include/irobot_create_nodes/motion_control/docking_behavior.hpp
        sed -i 's/msg\/dock.hpp/msg\/dock_status.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/src/motion_control/docking_behavior.cpp
        
        sed -i 's/msg::Dock/msg::DockStatus/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/include/irobot_create_nodes/robot_state.hpp
        sed -i 's/msg::Dock/msg::DockStatus/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/src/robot_state.cpp
        sed -i 's/msg::Dock/msg::DockStatus/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_toolbox/src/sensors/ir_opcode.cpp
        sed -i 's/msg::Dock/msg::DockStatus/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_toolbox/include/irobot_create_ignition_toolbox/sensors/ir_opcode.hpp
        sed -i 's/msg::Dock/msg::DockStatus/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_gazebo/irobot_create_gazebo_plugins/include/irobot_create_gazebo_plugins/gazebo_ros_docking_status.hpp
        sed -i 's/msg::Dock/msg::DockStatus/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_gazebo/irobot_create_gazebo_plugins/src/gazebo_ros_docking_status.cpp
        sed -i 's/msg::Dock/msg::DockStatus/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/include/irobot_create_nodes/motion_control/docking_behavior.hpp
        sed -i 's/msg::Dock/msg::DockStatus/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/src/motion_control/docking_behavior.cpp

        sed -i 's/action\/dock_servo.hpp/action\/dock.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/include/irobot_create_nodes/robot_state.hpp
        sed -i 's/action\/dock_servo.hpp/action\/dock.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/src/robot_state.cpp
        sed -i 's/action\/dock_servo.hpp/action\/dock.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_toolbox/src/sensors/ir_opcode.cpp
        sed -i 's/action\/dock_servo.hpp/action\/dock.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_toolbox/include/irobot_create_ignition_toolbox/sensors/ir_opcode.hpp
        sed -i 's/action\/dock_servo.hpp/action\/dock.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_gazebo/irobot_create_gazebo_plugins/include/irobot_create_gazebo_plugins/gazebo_ros_docking_status.hpp
        sed -i 's/action\/dock_servo.hpp/action\/dock.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_gazebo/irobot_create_gazebo_plugins/src/gazebo_ros_docking_status.cpp
        sed -i 's/action\/dock_servo.hpp/action\/dock.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/include/irobot_create_nodes/motion_control/docking_behavior.hpp
        sed -i 's/action\/dock_servo.hpp/action\/dock.hpp/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/src/motion_control/docking_behavior.cpp

        sed -i 's/action::DockServo/action::Dock/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/include/irobot_create_nodes/robot_state.hpp
        sed -i 's/action::DockServo/action::Dock/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/src/robot_state.cpp
        sed -i 's/action::DockServo/action::Dock/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_toolbox/src/sensors/ir_opcode.cpp
        sed -i 's/action::DockServo/action::Dock/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_ignition/irobot_create_ignition_toolbox/include/irobot_create_ignition_toolbox/sensors/ir_opcode.hpp
        sed -i 's/action::DockServo/action::Dock/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_gazebo/irobot_create_gazebo_plugins/include/irobot_create_gazebo_plugins/gazebo_ros_docking_status.hpp
        sed -i 's/action::DockServo/action::Dock/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_gazebo/irobot_create_gazebo_plugins/src/gazebo_ros_docking_status.cpp
        sed -i 's/action::DockServo/action::Dock/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/include/irobot_create_nodes/motion_control/docking_behavior.hpp
        sed -i 's/action::DockServo/action::Dock/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_nodes/src/motion_control/docking_behavior.cpp
    fi

    echo "Dowload from turtlebot4 "
    git clone -b humble https://ghproxy.com/https://github.com/turtlebot/turtlebot4.git

    echo "Dowload from turtlebot4_desktop "
    git clone -b humble https://ghproxy.com/https://github.com/turtlebot/turtlebot4_desktop.git

    echo "Dowload from turtlebot4_tutorials "
    git clone -b galactic https://ghproxy.com/https://github.com/turtlebot/turtlebot4_tutorials.git

    echo "Dowload from ign_ros2_control "
    git clone -b humble https://ghproxy.com/https://github.com/ros-controls/gz_ros2_control/

    # 编辑各个包, 如果编译出错，重新编译一次
    echo "build workspace..."
    cd ~/ros2_tb4_ws/
    rosdep install --from-path src -yi
    export CXX=clang++
    export CC=clang
    # colcon build  --mixin release lld
    colcon build --symlink-install  --parallel-workers 1  

    #run echo
    echo "Install turtlebot4 source successfully"
    # 添加工作空间路径到bashrc文件

    # echo 'source ~/ros2_tb4_ws/install/local_setup.bash' >> ~/.bashrc

    # 加载工作空间到当前环境

    # source ~/.bashrc
    # export IGNITION_VERSION=edifice

# fi