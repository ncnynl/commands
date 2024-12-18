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
if [ -d ~/ros2_tb4_ws/src/turtlebot4_tutorials ]; then
    echo "Turtlebot4 ignition have installed!!"
else 

    # install dep
    sudo apt install -y  wget python3-colcon-common-extensions python3-rosdep  python3-vcstool
    #fix fatal error: 'rclcpp_components/register_node_macro.hpp' file not found
    sudo apt install -y ros-humble-rclcpp-components
    sudo apt install qtquickcontrols2-5-dev

    # 新建工作空间
    if [ ! -d ~/ros2_tb4_ws/src ]; then 
        mkdir -p ~/ros2_tb4_ws/src
    fi

    # 进入工作空间

    cd ~/ros2_tb4_ws/src

    #run wget

    # 获取仓库列表

    git clone -b humble https://github.com/turtlebot/turtlebot4_simulator.git

    #run import
    echo "this will take 10-30 min to download"

    # 下载仓库
    echo "Dowload from irobot_create_msgs "

    git clone -b ${ROS_DISTRO} https://github.com/iRobotEducation/irobot_create_msgs.git

    echo "Dowload from create3_sim support namespace"
    git clone -b ${ROS_DISTRO}  https://github.com/iRobotEducation/create3_sim.git

    #fix:https://github.com/turtlebot/turtlebot4_simulator/issues/55
    CHOICE_C=$(echo -e "If your system is support GPU ? [Y/n]")
    read -p "${CHOICE_C}" YN
    [ -z ${YN} ] && YN = Y
    case $YN in 
    [Yy] | [Yy][Ee][Ss])
        ;;
    *)
        sed -i 's/ogre/ogre2/'g ~/ros2_tb4_ws/src/create3_sim/irobot_create_common/irobot_create_description/urdf/create3.urdf.xacro
        ;;
    esac 

    echo "Dowload from turtlebot4 common "
    git clone -b ${ROS_DISTRO} https://github.com/turtlebot/turtlebot4.git

    echo "Dowload from turtlebot4 robot "
    git clone -b ${ROS_DISTRO} https://github.com/turtlebot/turtlebot4_robot.git

    echo "Dowload from turtlebot4_desktop "
    git clone -b ${ROS_DISTRO} https://github.com/turtlebot/turtlebot4_desktop.git

    echo "Dowload from turtlebot4_tutorials "
    git clone -b ${ROS_DISTRO}  https://github.com/turtlebot/turtlebot4_tutorials.git


    # 编辑各个包, 如果编译出错，重新编译一次
    echo "build workspace..."
    cd ~/ros2_tb4_ws/
    rosdep install --from-path src -yi
    export CXX=clang++
    export CC=clang
    # colcon build  --mixin release lld
    colcon build --symlink-install  --parallel-workers 1  

    echo "Add workspace to bashrc if not exits"
    if ! grep -Fq "$workspace/install/local_setup.bash" ~/.bashrc
    then
        echo ". ~/$workspace/install/local_setup.bash" >> ~/.bashrc
        echo " $workspace workspace have installed successfully! writed to ~/.bashrc"
    else
        echo "Has been inited before! Please check ~/.bashrc"
    fi

fi